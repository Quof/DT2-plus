#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Fang"
maxLife=20
life=maxLife
pointWorth=150
atkPower=3
atkDefense=0
FIREresist=25
WATERresist=25
WINDresist=0
EARTHresist=75
baseItemChance=60
weight=100
runAcc=2
if x>oPlayer1.x
  runAcc*=-1
if runAcc>0
  image_xscale=1
else
  image_xscale=-1
inactiveDist*=2
scanText="Aww, I want one. NO, I want a bunch of these! They're so cute!!"
if global.lvlCurrent="Final"
  jeremyText="My little sis probably wants everything from Yoshi's Island. You know, now that we're here, I can actually get her all of them!"
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
  }
  enemyStepEvent()
}
