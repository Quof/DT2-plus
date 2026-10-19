#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0

//Enemy base statistics
eName="Turn Cannon"
maxLife=40
life=maxLife
pointWorth=250
atkPower=4
atkDefense=0
FIREresist=75
WATERresist=0
WINDresist=100
EARTHresist=0
baseItemChance=35
bFollow=false

shotProg=0

scanText="A rotating cannon from the Mega Man X series that shoot in two directions, either horizontally or diagonally. Mostly they appear on the ceilings or floors, but in some cases they are on flying platforms.#-Mega Man Wiki"
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("idFollow")
  bFollow=true
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
    //shotProg+=1
    shotProg+=1*gDeltaTime //60fps change: counts 30fps ticks (every value it's checked against is a whole number it lands on)
    if shotProg=10
      image_index=1
    else if shotProg=20
      image_index=2
    else if shotProg=22 //diagonal shot
    {
      var dir1,dir2,xOffset,yOffset;
      if image_angle=0
      {
        dir1=45
        dir2=135
        xOffset=8
        yOffset=-16
      }
      else
      {
        dir1=225
        dir2=315
        xOffset=-8
        yOffset=16
      }
      effect=instance_create(x+xOffset,y+yOffset,oEffect)
      effect.sprite_index=sMMSmokeCloud
      effect.image_speed=0.27
      effect=instance_create(x-xOffset,y+yOffset,oEffect)
      effect.sprite_index=sMMSmokeCloud
      effect.image_speed=0.27

      newAttack=instance_create(x+xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot
      //newAttack.direction=dir1
      newAttack._direction=dir1 //60fps change: the shot moves by _speed/_direction
      newAttack.image_speed=0
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=5
      newAttack=instance_create(x-xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot
      //newAttack.direction=dir2
      newAttack._direction=dir2 //60fps change: the shot moves by _speed/_direction
      newAttack.image_speed=0
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=5
    }
    else if shotProg=42
      image_index=3
    else if shotProg=52
      image_index=0
    else if shotProg=54 //horizontal shot
    {
      var dir1,dir2,xOffset,yOffset;
      if image_angle=0
      {
        dir1=0
        dir2=180
        xOffset=13
        yOffset=-12
      }
      else
      {
        dir1=180
        dir2=0
        xOffset=-13
        yOffset=12
      }
      effect=instance_create(x+xOffset,y+yOffset,oEffect)
      effect.sprite_index=sMMSmokeCloud
      effect.image_speed=0.27
      effect=instance_create(x-xOffset,y+yOffset,oEffect)
      effect.sprite_index=sMMSmokeCloud
      effect.image_speed=0.27

      newAttack=instance_create(x+xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot
      //newAttack.direction=dir1
      newAttack._direction=dir1 //60fps change: the shot moves by _speed/_direction
      newAttack.image_speed=0
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=5
      newAttack=instance_create(x-xOffset,y+yOffset,oPassBullet)
      newAttack.sprite_index=sTCShot
      //newAttack.direction=dir2
      newAttack._direction=dir2 //60fps change: the shot moves by _speed/_direction
      newAttack.image_speed=0
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=5

      shotProg=-10
    }
  }
  enemyStepEvent()
}
followInstance()
