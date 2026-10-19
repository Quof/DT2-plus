#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,image_alpha)

draw_set_font(fnt_TutorialBox)
draw_set_halign(fa_middle)
draw_set_color(c_black)
draw_set_alpha(image_alpha)
//input text change (added): while the gamepad is the input being used, the [ ] boxes show the button's icon (DT3+'s, scrDrawInputPad) instead of the key
if sprite_index=sTutMovement
{
  //draw_text(x-52,y+33,global.ctrlLeft)
  if !scrDrawInputPad(1,x-52,y+33) {draw_text(x-52,y+33,global.ctrlLeft)}
  //draw_text(x-17,y+33,global.ctrlRight)
  if !scrDrawInputPad(2,x-17,y+33) {draw_text(x-17,y+33,global.ctrlRight)}
}
else if sprite_index=sTutJump
{
  //draw_text(x,y+19,global.ctrlJump)
  if !scrDrawInputPad(5,x,y+19) {draw_text(x,y+19,global.ctrlJump)}
}
else if sprite_index=sTutDash
{
  //draw_text(x-8,y+19,global.ctrlDown)
  if !scrDrawInputPad(4,x-8,y+19) {draw_text(x-8,y+19,global.ctrlDown)}
  //draw_text(x+26,y+19,global.ctrlUp)
  if !scrDrawInputPad(3,x+26,y+19) {draw_text(x+26,y+19,global.ctrlUp)}
}
else if sprite_index=sTutDuck
{
  //draw_text(x+47,y+19,global.ctrlDown)
  if !scrDrawInputPad(4,x+47,y+19) {draw_text(x+47,y+19,global.ctrlDown)}
}
else if sprite_index=sTutElements
{
  //draw_text(x-81,y+62,global.ctrlWind)
  if !scrDrawInputPad(8,x-81,y+62) {draw_text(x-81,y+62,global.ctrlWind)}
  //draw_text(x-21,y+62,global.ctrlEarth)
  if !scrDrawInputPad(9,x-21,y+62) {draw_text(x-21,y+62,global.ctrlEarth)}
  //draw_text(x-81,y+77,global.ctrlFire)
  if !scrDrawInputPad(6,x-81,y+77) {draw_text(x-81,y+77,global.ctrlFire)}
  //draw_text(x-21,y+77,global.ctrlWater)
  if !scrDrawInputPad(7,x-21,y+77) {draw_text(x-21,y+77,global.ctrlWater)}
}
else if sprite_index=sTutShooter
{
  //draw_text(x+68,y+18,global.ctrlUp)
  if !scrDrawInputPad(3,x+68,y+18) {draw_text(x+68,y+18,global.ctrlUp)}
  //draw_text(x+81,y+18,global.ctrlDown)
  if !scrDrawInputPad(4,x+81,y+18) {draw_text(x+81,y+18,global.ctrlDown)}
  //draw_text(x+94,y+18,global.ctrlLeft)
  if !scrDrawInputPad(1,x+94,y+18) {draw_text(x+94,y+18,global.ctrlLeft)}
  //draw_text(x+107,y+18,global.ctrlRight)
  if !scrDrawInputPad(2,x+107,y+18) {draw_text(x+107,y+18,global.ctrlRight)}

  //draw_text(x+47,y+32,global.ctrlFire)
  if !scrDrawInputPad(6,x+47,y+32) {draw_text(x+47,y+32,global.ctrlFire)}
  //draw_text(x+27,y+61,global.ctrlJump)
  if !scrDrawInputPad(5,x+27,y+61) {draw_text(x+27,y+61,global.ctrlJump)}
  //draw_text(x+1,y+90,global.ctrlDashRight)
  if !scrDrawInputPad(11,x+1,y+90) {draw_text(x+1,y+90,global.ctrlDashRight)}
  //draw_text(x-136,y+162,global.ctrlWind)
  if !scrDrawInputPad(8,x-136,y+162) {draw_text(x-136,y+162,global.ctrlWind)}
  //draw_text(x-136,y+176,global.ctrlEarth)
  if !scrDrawInputPad(9,x-136,y+176) {draw_text(x-136,y+176,global.ctrlEarth)}
}
