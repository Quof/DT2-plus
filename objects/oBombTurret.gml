#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Bomb Turret"
maxLife=40
life=maxLife
pointWorth=300
atkPower=4
atkDefense=0
FIREresist=100
WATERresist=100
WINDresist=100
EARTHresist=100
baseItemChance=50

shotWait=75
shotTime=0
scanText="A stationary turret that can come in one of four colors. It is always completely resistant to the element depicted by it's color, but vulnerable to the next element. Look at your energy list order to see what I mean. They fire off Data Bombs, which disrupt data in the area they make contact with. These are typically indicated by the colors inverting in that area.#I stole this from my brother."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if eType=1
{
  eName="Fire Bomb Turret"
  baseColor=make_color_rgb(255,110,110)
  FIREresist=100
  WATERresist=0
  WINDresist=25
  EARTHresist=50
}
else if eType=2
{
  eName="Water Bomb Turret"
  baseColor=make_color_rgb(120,120,255)
  FIREresist=50
  WATERresist=100
  WINDresist=0
  EARTHresist=25
}
else if eType=3
{
  eName="Wind Bomb Turret"
  baseColor=make_color_rgb(120,255,120)
  FIREresist=25
  WATERresist=50
  WINDresist=100
  EARTHresist=0
}
else if eType=4
{
  eName="Earth Bomb Turret"
  baseColor=make_color_rgb(255,160,110)
  FIREresist=0
  WATERresist=25
  WINDresist=50
  EARTHresist=100
}
image_blend=baseColor
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and stunnedTime=0 and dieFade=0
  {
    direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-24)
    image_angle=direction
    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if shotTime=shotWait
      {
        afterImage=instance_create(x,y,oEnemyAfterImage)
        afterImage.image_alpha=1
        afterImage.sprite_index=sprite_index
        afterImage.image_angle=image_angle
        afterImage.imageFade=0.04
        afterImage.xScalingSet=0.1
        afterImage.yScalingSet=0.1
      }
    if shotTime>=shotWait+15
    {
      newAttack=instance_create(x,y,oBTurretShot)
      newAttack.x=x+lengthdir_x(12,direction)
      newAttack.y=y+lengthdir_y(12,direction)
      newAttack.image_xscale=0.6
      newAttack.image_yscale=0.6
      //newAttack.direction=direction
      newAttack._direction=direction //60fps change: the shot moves by _speed/_direction
      newAttack.image_blend=baseColor
      newAttack.image_speed=0.5
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=5
      shotTime=0
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sBombTurretBase,-1,x,y)
event_inherited()
