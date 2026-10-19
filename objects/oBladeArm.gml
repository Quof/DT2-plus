#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Blade Arm"
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
runAcc=1.75
shotWait=70
shotTime=0
scanText="I bet my brother could draw this in MS Paint in a minute."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if eType=1
{
  eName="Fire Blade Arm"
  baseColor=make_color_rgb(255,110,110)
  FIREresist=100
  WATERresist=0
  WINDresist=25
  EARTHresist=50
}
else if eType=2
{
  eName="Water Blade Arm"
  baseColor=make_color_rgb(120,120,255)
  FIREresist=50
  WATERresist=100
  WINDresist=0
  EARTHresist=25
}
else if eType=3
{
  eName="Wind Blade Arm"
  baseColor=make_color_rgb(120,255,120)
  FIREresist=25
  WATERresist=50
  WINDresist=100
  EARTHresist=0
}
else if eType=4
{
  eName="Earth Blade Arm"
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
    if instance_exists(oCharacter)
    {
      moveDir=point_direction(x,y,oCharacter.x,oCharacter.y-24)
      //moveTo(runAcc*cos(degtorad(moveDir)),-runAcc*sin(degtorad(moveDir)))
      moveTo(runAcc*cos(degtorad(moveDir))*gDeltaTime,-runAcc*sin(degtorad(moveDir))*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    }
    //image_angle-=3
    image_angle-=3*gDeltaTime //60fps change: per 30fps tick

    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks (every value it's checked against is a whole number it lands on)
    if shotTime>=shotWait
    {
      if shotTime=shotWait
      {
        afterImage=instance_create(x,y,oEnemyAfterImage)
        afterImage.image_alpha=1
        afterImage.sprite_index=sprite_index
        afterImage.image_index=image_index
        afterImage.imageFade=0.04
        afterImage.xScalingSet=0.1
        afterImage.yScalingSet=0.1
      }
      else if shotTime=shotWait+20
      {
        var dir;
        dir=image_angle
        for(i=0;i<6;i+=1)
        {
          effect=instance_create(x,y,oEffect)
          effect.x=x+lengthdir_x(12,dir)
          effect.y=y+lengthdir_y(12,dir)
          effect.sprite_index=sBomberExplosion
          effect.image_speed=0.75
          effect.image_xscale=0.3
          effect.image_yscale=0.3
          effect.newBlend=1

          newAttack=instance_create(x,y,oNormArcBullet)
          newAttack.x=x+lengthdir_x(12,dir)
          newAttack.y=y+lengthdir_y(12,dir)
          newAttack.sprite_index=sGTrackShot1
          newAttack.image_xscale=0.6
          newAttack.image_yscale=0.6
          //newAttack.direction=dir
          newAttack._direction=dir //60fps change: the shot moves by _speed/_direction
          newAttack.image_speed=0.5
          newAttack.type=0
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=3
          newAttack.arcAmt=5
          newAttack.falloff=0.075
          newAttack.image_blend=baseColor

          dir+=360/6
        }
        shotTime=0
      }
    }
  }
  enemyStepEvent()
}
