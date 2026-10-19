#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
sizeMod=0
distSize=0
bSizeUp=false
effectDelay=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
{
  oPlayer1.life=oPlayer1.maxLife
  oPlayer1.fireEnergy=oPlayer1.maxFireEnergy
  oPlayer1.waterEnergy=oPlayer1.maxWaterEnergy
  oPlayer1.windEnergy=oPlayer1.maxWindEnergy
  oPlayer1.earthEnergy=oPlayer1.maxEarthEnergy
  playSound(global.snd_HealingPlant,0,1)
  effect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
  effect.sprite_index=sHeal
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sHealingPost,-1,x,y)
draw_set_alpha(0.45)
if bSizeUp=false
{
  //sizeMod-=0.08
  sizeMod-=0.08*gDeltaTime //60fps change: the glow pulses per 30fps tick (Draw runs every frame)
  if sizeMod<=-2
    bSizeUp=true
}
else
{
  //sizeMod+=0.08
  sizeMod+=0.08*gDeltaTime //60fps change: the glow pulses per 30fps tick (Draw runs every frame)
  if sizeMod>=6
    bSizeUp=false
}
distSize=-point_distance(oPlayer1.x,oPlayer1.y,x,y)/16
if distSize<-16
  distSize=-16
draw_set_blend_mode(bm_add)
draw_circle_color(x,y-40,36+sizeMod+distSize,make_color_rgb(72,248,64),c_black,false)
draw_set_blend_mode(bm_normal)
if global.gamePaused=false
{
  if effectDelay=0
  {
    ranX=x-(sprite_width/2)+random(14)
    ranY=y-(sprite_height)+random(sprite_height/2)
    ranColor=make_color_rgb(67+random(10),243+random(10),59+random(10))
    effect_create_above(ef_spark,ranX,ranY,0,ranColor)
    effectDelay=22+round(random(12))
  }
  else
    //effectDelay-=1
    effectDelay-=1*gDeltaTime //60fps change: counts 30fps ticks (the sparkles came 2x/4x as often)
}
