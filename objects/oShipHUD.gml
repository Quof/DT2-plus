#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Integrated Visualization System (IVS)
menuOpen=false
powerBlend=c_white

//input commands==========
curPause=ord("P")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if keyboard_check_pressed(curPause) and global.gameOver=false
  if (keyboard_check_pressed(curPause) or scrPadPressed(12)) and global.gameOver=false //gamepad change: and the gamepad (scrGamepadInit) (START)
  {
    io_clear()
    scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
    playSound(global.snd_MenuOpen,0,1)
    global.gamePaused=true
    menuOpen=true
    oPlayer1.image_speed=0
    instance_create(0,0,oPauseMenu)
  }
}

if oClaireShip.chargePower>=100
{
  //if oGame.time mod 2=0
  if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
    powerBlend=make_color_rgb(175+random(80),175+random(80),175+random(80))
}
else
  powerBlend=c_white
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=true and menuOpen=true
{
  var backColor;
  backColor=make_color_rgb(232,136,160)
  draw_set_color(backColor)
  draw_set_alpha(0.4)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)
}

draw_sprite(sprite_index,image_index,x,y)
//Score display --------------------------------------------------
scoreDisX=view_xview[0]+158
scoreDisY=view_yview[0]+4
draw_set_font(fnt_Shooter)
draw_set_halign(fa_right)
draw_set_alpha(1)
draw_set_color(make_color_rgb(123,121,0))
draw_text(scoreDisX,scoreDisY,global.currentScore)
draw_text(scoreDisX,scoreDisY+18,global.lvlScore[14])
//Shield display --------------------------------------------------
shieldDisX=view_xview[0]+258
shieldDisY=view_yview[0]+11
if oClaireShip.life>0
  draw_sprite_ext(sCShipBarTrack,0,shieldDisX,shieldDisY,oClaireShip.life,1,0,c_white,1)

//Power display --------------------------------------------------
powerDisX=view_xview[0]+258
powerDisY=view_yview[0]+29
draw_sprite_ext(sCShipBarTrack,0,powerDisX,powerDisY,oClaireShip.chargePower,1,0,powerBlend,1)
if oClaireShip.shotType=1
  draw_text(powerDisX+92,powerDisY-7,"RAPID FIRE")

//Jerry display --------------------------------------------------
jerryDisX=view_xview[0]+455
jerryDisY=view_yview[0]+11
jerryTrack=(oClaireShip.jerryEnergy/oClaireShip.jerryEnergyMax)*50
draw_sprite_ext(sCShipBarTrack,0,jerryDisX,jerryDisY,jerryTrack,1,0,c_white,1)

//Jeremy display --------------------------------------------------
jeremyDisX=view_xview[0]+455
jeremyDisY=view_yview[0]+29
jeremyTrack=(oClaireShip.jeremyEnergy/oClaireShip.jeremyEnergyMax)*50
draw_sprite_ext(sCShipBarTrack,0,jeremyDisX,jeremyDisY,jeremyTrack,1,0,c_white,1)

//Combo display --------------------------------------------------
if oClaireShip.killCombo>0 //kill chain meter
{
  kcMeterX=view_xview[0]+6
  kcMeterY=view_yview[0]+48
  draw_set_alpha(1)
  draw_set_color(c_ltgray)
  draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+122,0)
  draw_set_color(c_black)
  draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+122,1)
  draw_set_color(c_fuchsia)
  draw_rectangle(kcMeterX+1,kcMeterY+1,kcMeterX+4,kcMeterY+(oClaireShip.comboTime*2)+1,0)
  draw_set_color(c_black)
  draw_set_halign(fa_left)
  draw_text(kcMeterX+8,kcMeterY,oClaireShip.killCombo)
}
