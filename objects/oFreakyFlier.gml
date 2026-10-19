#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-20,-18,20,18)
image_speed=0.25

//Enemy base statistics
eName="Freaky Flier"
maxLife=35
life=maxLife
pointWorth=250
atkPower=3
atkDefense=0
FIREresist=50
WATERresist=25
WINDresist=75
EARTHresist=0
baseItemChance=40

runAcc=2
shotWait=50
shotTime=10
scanText="Freaky is right. Why is everything so weird here? This shoots 3 lasers with the middle one directed at you."
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
    dir=point_direction(x,y,oCharacter.x,oCharacter.y-24)
    //moveTo(runAcc*cos(degtorad(dir)),-runAcc*sin(degtorad(dir)))
    moveTo(runAcc*cos(degtorad(dir))*gDeltaTime,-runAcc*sin(degtorad(dir))*gDeltaTime) //60fps change: moveTo takes this frame's share of the move

    if x>oCharacter.x
      image_xscale=-1
    else
      image_xscale=1

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
        afterImage.image_xscale=image_xscale
        afterImage.imageFade=0.05
        if image_xscale=1
          afterImage.xScalingSet=0.1
        else
          afterImage.xScalingSet=-0.1
        afterImage.yScalingSet=0.1
      }
      else if shotTime=shotWait+15
      {
        var xChange;
        if image_xscale=1
          xChange=6
        else
          xChange=-6

        dir=point_direction(x+xChange,y+15,oPlayer1.x,oPlayer1.y-24)
        dir-=15

        for(i=0;i<3;i+=1)
        {
          newAttack=instance_create(x+xChange,y+15,oPassBullet)
          newAttack.sprite_index=sGTrackShot2
          //newAttack.direction=dir
          newAttack._direction=dir //60fps change: the shot moves by _speed/_direction
          newAttack.image_speed=0
          newAttack.image_xscale=2.75
          newAttack.image_yscale=0.75
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=6
          dir+=15
        }
      }
      else if shotTime=shotWait+30
        shotTime=0
    }
  }

  enemyStepEvent()
}
