#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mainCurPos=1
mainInc=14
if global.gameProgress>=7 {mainMax=13}
else {mainMax=12}
tutToShow=sTutMovement
xx=318
yy=2

//---------- input commands ----------
curUp=ord("W")
curDown=ord("S")
curMenu=ord("K")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
{
  playSound(global.snd_MenuCursor,0,1)
  if mainCurPos=1
  {
    mainCurPos=mainMax
  }
  else
  {
    mainCurPos-=1
  }
}
//else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
{
  playSound(global.snd_MenuCursor,0,1)
  if mainCurPos=mainMax
  {
    mainCurPos=1
  }
  else
  {
    mainCurPos+=1
  }
}

//if keyboard_check_pressed(curMenu)
if keyboard_check_pressed(curMenu) or scrPadPressed(15) //gamepad change: and the gamepad (scrGamepadInit)
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  playSound(global.snd_MenuClose,0,1)
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sHowToPlayMenu,0,2,2)
draw_sprite(sOptionCursor,0,8,8+(mainCurPos*mainInc))

if mainCurPos=1 {tutToShow=sTutMovement}
else if mainCurPos=2 {tutToShow=sTutJump}
else if mainCurPos=3 {tutToShow=sTutDash}
else if mainCurPos=4 {tutToShow=sTutAirDash}
else if mainCurPos=5 {tutToShow=sTutDuck}
else if mainCurPos=6 {tutToShow=sTutElements}
else if mainCurPos=7 {tutToShow=sTutEnergy}
else if mainCurPos=8 {tutToShow=sTutElemental}
else if mainCurPos=9 {tutToShow=sTutElements2}
else if mainCurPos=10 {tutToShow=sTutWallJump}
else if mainCurPos=11 {tutToShow=sTutExtra}
else if mainCurPos=12 {tutToShow=sTutScoring}
else if mainCurPos=13 {tutToShow=sTutShooter}

if global.gameProgress<=6
{
  draw_set_color(make_color_rgb(0,110,50))
  draw_set_alpha(1)
  draw_rectangle(8,190,92,203,0)
}

draw_sprite(tutToShow,0,xx,yy)

draw_set_font(fnt_TutorialBox)
draw_set_halign(fa_middle)
draw_set_color(c_black)
draw_set_alpha(image_alpha)
//input text change (added): while the gamepad is the input being used, the [ ] boxes show the button's icon (DT3+'s, scrDrawInputPad) instead of the key
if tutToShow=sTutMovement
{
  //draw_text(xx-52,yy+33,global.ctrlLeft)
  if !scrDrawInputPad(1,xx-52,yy+33) {draw_text(xx-52,yy+33,global.ctrlLeft)}
  //draw_text(xx-17,yy+33,global.ctrlRight)
  if !scrDrawInputPad(2,xx-17,yy+33) {draw_text(xx-17,yy+33,global.ctrlRight)}
}
else if tutToShow=sTutJump
{
  //draw_text(xx,yy+19,global.ctrlJump)
  if !scrDrawInputPad(5,xx,yy+19) {draw_text(xx,yy+19,global.ctrlJump)}
}
else if tutToShow=sTutDash
{
  //draw_text(xx-8,yy+19,global.ctrlDown)
  if !scrDrawInputPad(4,xx-8,yy+19) {draw_text(xx-8,yy+19,global.ctrlDown)}
  //draw_text(xx+26,yy+19,global.ctrlUp)
  if !scrDrawInputPad(3,xx+26,yy+19) {draw_text(xx+26,yy+19,global.ctrlUp)}
}
else if tutToShow=sTutDuck
{
  //draw_text(xx+47,yy+19,global.ctrlDown)
  if !scrDrawInputPad(4,xx+47,yy+19) {draw_text(xx+47,yy+19,global.ctrlDown)}
}
else if tutToShow=sTutElements
{
  //draw_text(xx-81,yy+62,global.ctrlWind)
  if !scrDrawInputPad(8,xx-81,yy+62) {draw_text(xx-81,yy+62,global.ctrlWind)}
  //draw_text(xx-21,yy+62,global.ctrlEarth)
  if !scrDrawInputPad(9,xx-21,yy+62) {draw_text(xx-21,yy+62,global.ctrlEarth)}
  //draw_text(xx-81,yy+77,global.ctrlFire)
  if !scrDrawInputPad(6,xx-81,yy+77) {draw_text(xx-81,yy+77,global.ctrlFire)}
  //draw_text(xx-21,yy+77,global.ctrlWater)
  if !scrDrawInputPad(7,xx-21,yy+77) {draw_text(xx-21,yy+77,global.ctrlWater)}
}
else if tutToShow=sTutShooter
{
  //draw_text(xx+68,yy+18,global.ctrlUp)
  if !scrDrawInputPad(3,xx+68,yy+18) {draw_text(xx+68,yy+18,global.ctrlUp)}
  //draw_text(xx+81,yy+18,global.ctrlDown)
  if !scrDrawInputPad(4,xx+81,yy+18) {draw_text(xx+81,yy+18,global.ctrlDown)}
  //draw_text(xx+94,yy+18,global.ctrlLeft)
  if !scrDrawInputPad(1,xx+94,yy+18) {draw_text(xx+94,yy+18,global.ctrlLeft)}
  //draw_text(xx+107,yy+18,global.ctrlRight)
  if !scrDrawInputPad(2,xx+107,yy+18) {draw_text(xx+107,yy+18,global.ctrlRight)}

  //draw_text(xx+47,yy+32,global.ctrlFire)
  if !scrDrawInputPad(6,xx+47,yy+32) {draw_text(xx+47,yy+32,global.ctrlFire)}
  //draw_text(xx+27,yy+61,global.ctrlJump)
  if !scrDrawInputPad(5,xx+27,yy+61) {draw_text(xx+27,yy+61,global.ctrlJump)}
  //draw_text(xx+1,yy+90,global.ctrlDashRight)
  if !scrDrawInputPad(11,xx+1,yy+90) {draw_text(xx+1,yy+90,global.ctrlDashRight)}
  //draw_text(xx-136,yy+162,global.ctrlWind)
  if !scrDrawInputPad(8,xx-136,yy+162) {draw_text(xx-136,yy+162,global.ctrlWind)}
  //draw_text(xx-136,yy+176,global.ctrlEarth)
  if !scrDrawInputPad(9,xx-136,yy+176) {draw_text(xx-136,yy+176,global.ctrlEarth)}
}
