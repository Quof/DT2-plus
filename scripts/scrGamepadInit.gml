/*
gamepad change (added): gamepad support, ported from DT1 Plus / DT3+ (Game Maker 8.2's joystick extension, gm82joy: SDL2
joysticks, ids and buttons count from 0; gm82core for window_has_focus). Called once from oGamepad's Create (made in
rIntro's creation code). scrGamepadPoll reads the pad every frame (oGamepad's Begin Step); scrPadHeld/scrPadPressed/
scrPadReleased give the game what it read, next to its keyboard checks, while Gamepad Input is on (pause menu: Options).

The gamepad controls (global.gpBind[action]) are kept as these codes, so they mean the same button on any pad SDL knows
the layout of:
  0 nothing
  1 A (bottom face button: Cross)     2 B (right: Circle)     3 X (left: Square)     4 Y (top: Triangle)
  5 L1   6 R1   7 L2   8 R2   9 BACK (Select/Share/View)   10 START (Options/Menu)   11 L3   12 R3 (stick clicks)
  13-16 d-pad up/down/left/right    17-20 left stick up/down/left/right    21-24 right stick up/down/left/right
  100+n raw button n                200+2*a axis a pushed + (201+2*a: pushed -), for pads SDL has no layout for

Actions (global.gpBind/gpHeld/gpPressed/gpReleased index):
  1 Left   2 Right   3 Up   4 Down   5 Jump   6 Use Fire   7 Use Water   8 Use Wind   9 Use Earth   10 Dash Left
  11 Dash Right: set in the pause menu's Set Controls (Gamepad list, [L] / Y swaps the lists), and the left stick always
  moves too (1-4), like the arrow keys next to the keyboard's letters.
  Fixed: 12 Pause ([P]): START   13 Cutscene Skip ([M]): BACK   14 Menu Confirm ([J]): A (Cross)
  15 Menu Cancel ([K]): B (Circle)   16 the menus' other key ([L]): Y (Triangle)

SDL's raw joystick layout depends on the pad:
  layout 1 - Xbox pads and anything XInput (also DS4Windows, Steam's virtual pads): A B X Y L1 R1 BACK START L3 R3
             are buttons 0-9, the d-pad is the hat, L2/R2 are axes. Unknown pads are read this way too.
  layout 2 - PlayStation and Switch pads (SDL's HIDAPI drivers, no hat): A B X Y BACK GUIDE START L3 R3 L1 R1
             are buttons 0-10, the d-pad is buttons 11-14, sticks are axes 0-3, L2/R2 are axes 4/5.
*/
var i;

global.gpDevice=-1    //joystick being read (-1: none)
global.gpName=""      //its name, as SDL reports it
global.gpLayout=0     //1 or 2, see above
global.gpAxes=0       //number of axes on the pad
global.gpHasHat=0
global.gpPlayStation=0 //1: show PlayStation button names (scrGamepadName)
global.gpPS5=0
//Axis numbers of L2, R2 and the right stick. Layout 1 has two orders, depending on the driver SDL picked:
//XInput (L2 = axis 2, right stick = 3/4) or RawInput/Windows.Gaming.Input (right stick = 2/3, L2 = 4).
//scrGamepadPoll works out which one by looking at which axis rests at -1 (an unpressed trigger).
global.gpAxL2=4
global.gpAxR2=5
global.gpAxRX=2
global.gpAxRY=3
global.gpOrderXInput=0   //frames in a row each order has looked right
global.gpOrderRawInput=0
global.gpOrderSure=0     //1 once the order is known; until then L2 isn't read (axis 4 could be the right stick)
//SDL reports every axis as 0 for a frame when a pad is plugged in, which would look like a half-pressed trigger.
//A trigger only counts once it has been seen resting.
global.gpL2Ready=0
global.gpR2Ready=0
global.gpDeadZone=0.4  //how far a stick has to be pushed to count

global.gpActions=16   //actions, the fixed ones included (see above)
for(i=0;i<=global.gpActions;i+=1)
{
  global.gpHeld[i]=0      //held this frame (scrGamepadPoll)
  global.gpPressed[i]=0   //pressed this frame: held now, not on the last frame
  global.gpReleased[i]=0  //let go this frame: held on the last frame, not now
  global.gpPrev[i]=0      //held on the last frame
  global.gpLock[i]=0      //held since scrGamepadSync: doesn't count as held until let go (scrGamepadPoll)
}
global.gpFrames=0     //frames since startup: window_has_focus() is only read once gm82core has updated it (scrGamepadPoll)
global.gpLastUsed=0   //input text change (added): 1 once a gamepad action is held, 0 again on a key press (scrGamepadPoll): the on-screen prompts show the pad's buttons or the keys (scrDrawInput)
global.inputAlign=fa_left //input text change (added): how scrDrawInput lines up a text with icons (a centered or right-aligned caller sets it first)
for(i=0;i<16;i+=1)
{
  global.gpAxis[i]=0     //this frame's axis values
  global.gpCapBase[i]=0  //axis values when the Gamepad list started waiting for a button (scrGamepadCapture)
}
global.gpHatX=0
global.gpHatY=0

//Raw button for codes 1-12 (-1: it's an axis), per layout
global.gpRaw1[1]=0; global.gpRaw1[2]=1; global.gpRaw1[3]=2; global.gpRaw1[4]=3; global.gpRaw1[5]=4; global.gpRaw1[6]=5
global.gpRaw1[7]=-1; global.gpRaw1[8]=-1; global.gpRaw1[9]=6; global.gpRaw1[10]=7; global.gpRaw1[11]=8; global.gpRaw1[12]=9
global.gpRaw2[1]=0; global.gpRaw2[2]=1; global.gpRaw2[3]=2; global.gpRaw2[4]=3; global.gpRaw2[5]=9; global.gpRaw2[6]=10
global.gpRaw2[7]=-1; global.gpRaw2[8]=-1; global.gpRaw2[9]=4; global.gpRaw2[10]=6; global.gpRaw2[11]=7; global.gpRaw2[12]=8

//Set Controls' rows (pause menu) -> action: the same rows as the keyboard list (Up Down Left Right Jump Fire Water Wind
//Earth Dash Left, Dash Right; row 12 is Restore Default)
global.gpRowAct[1]=3
global.gpRowAct[2]=4
global.gpRowAct[3]=1
global.gpRowAct[4]=2
for(i=5;i<=11;i+=1) {global.gpRowAct[i]=i}

if !variable_global_exists("optGamePad") {global.optGamePad=1} //Gamepad Input on (pause menu: Options); loadOptions reads the saved one
scrGamepadDefaults()
