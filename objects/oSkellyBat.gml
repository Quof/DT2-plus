#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Skelly Bat"
maxLife=25
life=maxLife
pointWorth=200
atkPower=3
atkDefense=0
FIREresist=75
WATERresist=50
WINDresist=0
EARTHresist=50
baseItemChance=60
weight=100
runAcc=1.75
if x>oPlayer1.x
  runAcc*=-1
if runAcc>0
  image_xscale=1
else
  image_xscale=-1
fireDropTime=40
fireDropDelay=70
inactiveDist*=2
scanText="They're just like any other video game bat. Flies straight, but it also drops fire as it flies."
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
    if findTargetX>inactiveDist/1.5
      instance_destroy()

    //x+=runAcc
    x+=runAcc*gDeltaTime //60fps change: per 30fps tick

    //fireDropTime+=1
    fireDropTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if fireDropTime>=fireDropDelay
    {
      newAttack=instance_create(x,y,oNormalBullet)
      newAttack.type=2
      newAttack.sprite_index=sSkellyBatFireA
      //newAttack.direction=270
      newAttack._direction=270 //60fps change: the shot moves by _speed/_direction
      newAttack.atkPower=atkPower
      newAttack.bulletSpeed=4
      fireDropTime=0
    }
  }
  enemyStepEvent()
}
