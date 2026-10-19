#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-16,12,5)
image_speed=0.2

//Enemy base statistics
eName="Fire Eye"
maxLife=35
life=maxLife
pointWorth=250
atkPower=4
atkDefense=0
FIREresist=100
WATERresist=0
WINDresist=25
EARTHresist=50
baseItemChance=50

runAcc=1.65
shotWait=70
shotTime=10
scanText="It's just a mean firey eye ball. It shoots lots of fireballs out and will warn you with that projecting image thing the bad guys do. I don't know what it's called, my brother would though."
if global.lvlCurrent="Final"
  jeremyText="My recommendation is to just run past these. If you do want to stop and fight them, use a ranged water attack to take them out before they attack."
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
    //if instance_exists(oCharacter) and shotTime<=shotWait+2
    if instance_exists(oCharacter) and shotTime<shotWait+3 //60fps change: shotTime is read before this frame's count, so the move lasts through the tick that counts up from shotWait+2, as <=shotWait+2 did at 30fps (the same at 30fps)
    {
      dir=point_direction(x,y,oCharacter.x,oCharacter.y-24)
      //moveTo(runAcc*cos(degtorad(dir)),-runAcc*sin(degtorad(dir)))
      moveTo(runAcc*cos(degtorad(dir))*gDeltaTime,-runAcc*sin(degtorad(dir))*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    }

    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks (every value it's checked against is a whole number it lands on)
    if shotTime>=shotWait
    {
      if shotTime=shotWait
      {
        afterImage=instance_create(x,y,oEnemyAfterImage)
        afterImage.image_alpha=0.7
        afterImage.sprite_index=sprite_index
        afterImage.image_index=image_index
        afterImage.imageFade=0.05
        afterImage.xScalingSet=0.1
        afterImage.yScalingSet=0.1
      }
      else if shotTime=shotWait+15
      {
        var dir;
        dir=point_direction(x,y,oPlayer1.x,oPlayer1.y-22)
        for(i=0;i<6;i+=1)
        {
          effect=instance_create(x,y,oEffect)
          effect.x=x+lengthdir_x(14,dir)
          effect.y=y+lengthdir_y(14,dir)
          effect.sprite_index=sMMSmokeCloud
          effect.image_speed=0.75

          newAttack=instance_create(x,y,oNormArcBullet)
          newAttack.x=x+lengthdir_x(14,dir)
          newAttack.y=y+lengthdir_y(14,dir)
          newAttack.sprite_index=sSpellFireball
          //newAttack.direction=dir
          newAttack._direction=dir //60fps change: the shot moves by _speed/_direction
          newAttack.image_xscale=0.75
          newAttack.image_yscale=0.75
          newAttack.type=0
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=5
          newAttack.arcAmt=4
          newAttack.falloff=0.05
          dir+=360/6
        }
      }
      else if shotTime=shotWait+30
        shotTime=0
    }
  }

  enemyStepEvent()
}
