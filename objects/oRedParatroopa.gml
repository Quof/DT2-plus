#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-7,-22,7,-1)
image_speed=0.2

//Enemy base statistics
eName="Red Paratroopa"
maxLife=20
life=maxLife
pointWorth=200
atkPower=3
atkDefense=0
FIREresist=100
WATERresist=0
WINDresist=50
EARTHresist=75
baseItemChance=60
dirChange=0
weight=100
runAcc=1.5
xVel=runAcc
if x>oPlayer1.x
  xVel*=-1
scanText="I have plush dolls of these Koopas too! I have this feeling that I'm getting off topic... OH YEAH!! These Koopas only patrol left and right."
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
    if gDeltaTime<1 {scrSolidPushOut()} //60fps change (added): out of a solid it's in (e.g. an elevator that rose into it) before anything looks at where it is (see scrSolidPushOut)
    //dirChange+=1
    //if dirChange>=60
    dirChange+=1*gDeltaTime //60fps change: counts 30fps ticks
    if dirChange>59 //60fps change: covers every frame of ticks 60-87 (the count is the tick's number on its last frame), so the slowdown totals the same as at 30fps (the same at 30fps)
    {
      //if xVel>0
      //  xVel-=runAcc/30
      //else
      //  xVel+=runAcc/30
      if xVel>0
        xVel-=(runAcc/30)*gDeltaTime //60fps change: per 30fps tick
      else
        xVel+=(runAcc/30)*gDeltaTime //60fps change: per 30fps tick
      if dirChange>=87
      {
        if xVel>0
          xVel=-runAcc
        else
          xVel=runAcc
        dirChange=0
      }
    }
    //if isCollisionLeft(1)
    //  xVel*=-1
    //if isCollisionRight(1)
    //  xVel*=-1
    //60fps change: only a wall it's moving into turns it around (isCollisionLeftEdit/RightEdit), see oGoomba
    if isCollisionLeftEdit(1)
      xVel*=-1
    if isCollisionRightEdit(1)
      xVel*=-1

    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    //moveTo(xVel,yVel)
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    //if isCollisionSolid()
    //  y-=2
    if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step
  }
  enemyStepEvent()
}
