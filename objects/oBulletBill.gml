#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Bullet Bill"
maxLife=20
life=maxLife
atkPower=3
atkDefense=0
FIREresist=75
WATERresist=0
WINDresist=100
EARTHresist=0
bNoBonus=true
runAcc=7.5
if x>oPlayer1.x
  runAcc*=-1
if runAcc>0
  image_xscale=1
else
  image_xscale=-1
inactiveDist*=2
scanText="You didn't play a lot of Mario games did you " +string(global.mainCharacters[3]) +string("? All these can do is go in the direction they were fired in. Oh yeah! The Bullet Blasters won't shoot if you are close to them!")
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
    if findTargetX>inactiveDist/2
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }

    //x+=runAcc
    x+=runAcc*gDeltaTime //60fps change: per 30fps tick
  }
  enemyStepEvent()
}
