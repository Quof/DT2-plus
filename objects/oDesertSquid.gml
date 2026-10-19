#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-28,-44,28,10)
image_speed=0.2

//Enemy base statistics
eName="Desert Squid"
maxLife=35
life=maxLife
pointWorth=250
atkPower=3
atkDefense=0
FIREresist=0
WATERresist=75
WINDresist=25
EARTHresist=50
baseItemChance=50

runAcc=1.75
shotWait=50
shotTime=20
scanText="Eww, what is that thing? It's sooo gross! It's not even a squid!##Looks like it shoots 2 blue fires at you, 1 slow and 1 fast."
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
        for(i=0;i<2;i+=1)
        {
          newAttack=instance_create(x,y,oNormalBullet)
          newAttack.type=0
          newAttack.sprite_index=sDSquidShot
          //newAttack.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-22)
          newAttack._direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-22) //60fps change: the shot moves by _speed/_direction
          newAttack.image_speed=0.4
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=3.5*(i+1)
        }
      }
      else if shotTime=shotWait+30
        shotTime=0
    }
  }

  enemyStepEvent()
}
