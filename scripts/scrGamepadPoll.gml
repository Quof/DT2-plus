/*
gamepad change (added): reads the gamepad once per frame (oGamepad's Begin Step, before any Step event asks) into
global.gpHeld[action] (held now), global.gpPressed[action] (pressed this frame) and global.gpReleased[action] (let go
this frame), which scrPadHeld/scrPadPressed/scrPadReleased return while Gamepad Input is on. Ported from DT1 Plus /
DT3+. Every action is checked on its own, so any number of them can be held at once; the d-pad hat is split into its
horizontal and vertical parts, so up+right on it counts as both Up and Right. Codes, actions, layouts and the gp*
variables are explained in scrGamepadInit.
*/
var i,tCount,tName,tRead;

//---------- Pick the pad, again whenever pads are plugged in or unplugged ----------
tCount=joystick_count()
if joystick_found() or (global.gpDevice=-1 and tCount>0) or global.gpDevice>=tCount
{
  global.gpDevice=-1
  //the first one that looks like a gamepad (wheels, flight sticks and some other devices show up as joysticks too)
  for(i=0;i<tCount;i+=1)
  {
    if joystick_buttons(i)>=10 and joystick_axes(i)>=4 {global.gpDevice=i; break}
  }
  if global.gpDevice=-1 and tCount>0 {global.gpDevice=0}

  global.gpName=""
  if global.gpDevice>=0
  {
    global.gpName=joystick_name(global.gpDevice)
    global.gpAxes=min(joystick_axes(global.gpDevice),16)
    global.gpHasHat=joystick_has_pov(global.gpDevice)
    global.gpAxL2=4; global.gpAxR2=5; global.gpAxRX=2; global.gpAxRY=3 //layout 2, and layout 1's RawInput order until checked below
    global.gpOrderSure=1
    if global.gpHasHat=0 and joystick_buttons(global.gpDevice)>=15 {global.gpLayout=2} //PlayStation/Switch
    else {global.gpLayout=1; global.gpOrderSure=0} //Xbox/XInput (and anything unknown): axis order checked below
    if global.gpAxes<6 //no trigger axes (pads with digital L2/R2 have them as buttons, which can be set in the list)
    {
      global.gpAxL2=-1; global.gpAxR2=-1
      if global.gpAxes<4 {global.gpAxRX=-1; global.gpAxRY=-1}
      global.gpOrderSure=1
    }
    global.gpL2Ready=0
    global.gpR2Ready=0
    global.gpOrderXInput=0
    global.gpOrderRawInput=0
    //button names: PlayStation pads get their own (scrGamepadName)
    tName=string_upper(global.gpName)
    global.gpPlayStation=(global.gpLayout=2 and (string_pos("PS3",tName)>0 or string_pos("PS4",tName)>0 or string_pos("PS5",tName)>0 or string_pos("DUALSHOCK",tName)>0 or string_pos("DUALSENSE",tName)>0 or string_pos("PLAYSTATION",tName)>0))
    global.gpPS5=(string_pos("PS5",tName)>0 or string_pos("DUALSENSE",tName)>0)
  }
  else {global.gpLayout=0; global.gpAxes=0; global.gpHasHat=0}
}

for(i=1;i<=global.gpActions;i+=1) {global.gpHeld[i]=0}
global.gpFrames+=1
//input text change (added): a key pressed (or no pad, or Gamepad Input off) means the keyboard is what's being used, so
//the on-screen prompts show keys (scrDrawInput); a held gamepad action sets it back, below (as in DT3+)
if keyboard_check(vk_anykey) or global.gpDevice<0 or global.optGamePad=0 {global.gpLastUsed=0}
//Only while the game window has focus (gm82core's window_has_focus, updated in its Begin Step), so the pad doesn't play
//the game from the background. Skipped for the first frames, before gm82core has set it.
tRead=(global.gpDevice>=0)
if tRead and global.gpFrames>2 {if !window_has_focus() {tRead=0}}

if tRead
{
  //---------- Read the axes and the hat once ----------
  for(i=0;i<global.gpAxes;i+=1) {global.gpAxis[i]=joystick_axis(global.gpDevice,i)}
  if global.gpHasHat {global.gpHatX=joystick_pov_x(global.gpDevice); global.gpHatY=joystick_pov_y(global.gpDevice)}
  else {global.gpHatX=0; global.gpHatY=0}

  //Layout 1 axis order: an unpressed trigger rests at -1, a stick at 0. When one of axes 2/4 sits at -1 and the other at
  //0 for 30 frames in a row (right after plugging in, everything is usually at rest), that one is L2. L2 isn't read until
  //then (R2 is axis 5 either way).
  if global.gpLayout=1 and global.gpOrderSure=0
  {
    if global.gpAxis[2]<=-0.9 and abs(global.gpAxis[4])<0.1 {global.gpOrderXInput+=1} else {global.gpOrderXInput=0}
    if global.gpAxis[4]<=-0.9 and abs(global.gpAxis[2])<0.1 {global.gpOrderRawInput+=1} else {global.gpOrderRawInput=0}
    if global.gpOrderXInput>=30 //XInput driver: LX LY L2 RX RY R2
    {
      global.gpAxL2=2; global.gpAxRX=3; global.gpAxRY=4
      global.gpL2Ready=0
      global.gpOrderSure=1
    }
    else if global.gpOrderRawInput>=30 //RawInput (SDL's default for Xbox pads) / Windows.Gaming.Input: LX LY RX RY L2 R2
    {
      global.gpAxL2=4; global.gpAxRX=2; global.gpAxRY=3
      global.gpL2Ready=0
      global.gpOrderSure=1
    }
  }
  if global.gpAxL2>=0 {if global.gpAxis[global.gpAxL2]<=-0.9 {global.gpL2Ready=1}}
  if global.gpAxR2>=0 {if global.gpAxis[global.gpAxR2]<=-0.9 {global.gpR2Ready=1}}

  //---------- Actions ----------
  for(i=1;i<=11;i+=1) {global.gpHeld[i]=scrGamepadCheck(global.gpBind[i])}
  global.gpHeld[12]=scrGamepadCheck(10) //Pause: START
  global.gpHeld[13]=scrGamepadCheck(9)  //Cutscene Skip: BACK
  global.gpHeld[14]=scrGamepadCheck(1)  //Menu Confirm: A (Cross)
  global.gpHeld[15]=scrGamepadCheck(2)  //Menu Cancel: B (Circle)
  global.gpHeld[16]=scrGamepadCheck(4)  //the menus' other key ([L]): Y (Triangle)
  //The left stick always moves as well, like the arrow keys next to the keyboard's letters. Once a direction counts, it
  //keeps counting until the stick is back under 0.3 (gpDeadZone-0.1), so a stick resting near 0.4 can't flicker on and
  //off and count as pressed again and again (menus stepping twice)
  if global.gpAxes>=2
  {
    if global.gpAxis[0]<=-(global.gpDeadZone-0.1*global.gpPrev[1]) {global.gpHeld[1]=1}
    if global.gpAxis[0]>=global.gpDeadZone-0.1*global.gpPrev[2] {global.gpHeld[2]=1}
    if global.gpAxis[1]<=-(global.gpDeadZone-0.1*global.gpPrev[3]) {global.gpHeld[3]=1}
    if global.gpAxis[1]>=global.gpDeadZone-0.1*global.gpPrev[4] {global.gpHeld[4]=1}
  }
}

//input text change (added): a gamepad action held means the gamepad is what's being used: the on-screen prompts show
//its buttons' icons (scrDrawInput), until a key is pressed (above)
if global.optGamePad=1 {for(i=1;i<=global.gpActions;i+=1) {if global.gpHeld[i] {global.gpLastUsed=1}}}

//A button held when scrGamepadSync ran (a menu, message or door used it up) doesn't count as held until it's let go, as
//io_clear makes GM forget held keys. The player reads its presses from held going on (kJump 0 -> 1 is a jump), so the A
//that closed a message would otherwise jump as soon as the player had control again
for(i=1;i<=global.gpActions;i+=1)
{
  if global.gpLock[i] {if global.gpHeld[i] {global.gpHeld[i]=0} else {global.gpLock[i]=0}}
}

//---------- Pressed / let go this frame ----------
for(i=1;i<=global.gpActions;i+=1)
{
  global.gpPressed[i]=(global.gpHeld[i] and !global.gpPrev[i])
  global.gpReleased[i]=(!global.gpHeld[i] and global.gpPrev[i])
  global.gpPrev[i]=global.gpHeld[i]
}
