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
eName="Green Paratroopa"
maxLife=20
life=maxLife
pointWorth=150
atkPower=3
atkDefense=0
FIREresist=25
WATERresist=75
WINDresist=0
EARTHresist=50
baseItemChance=60
initDir=0
weight=100
runAcc=1.2
scanText="Oh I love Koopas! I have so many plush dolls of them! Did I ever show them to you " +string(global.mainCharacters[3]) +string("?! I don't think I did... OH! I bet I can design my room exactly how it was. I'm sure all those programming tricks my brother taught me should help!")
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
    if initDir=false
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=true
    }
    //yVel+=0.3
    //60fps change: gravity spread over the frames (see scrGravAcc). The bounce speed is set after this tick's gravity and
    //before its move, so its correction is 2*gDeltaTime-1 (1 at 30fps): with it the bounces peak at 63px every 41 ticks at
    //60 and 120fps, as at 30fps (with 1 they came out 3-6px lower)
    yVel=scrGravAcc(yVel,0.3,2*gDeltaTime-1)
    if isCollisionBottom(1)
      yVel=-6
    //if isCollisionLeft(1)
    //  xVel*=-1
    //if isCollisionRight(1)
    //  xVel*=-1
    //60fps change: only a wall it's moving into turns it around (isCollisionLeftEdit/RightEdit), see oGoomba
    if isCollisionLeftEdit(1)
      xVel*=-1
    if isCollisionRightEdit(1)
      xVel*=-1

    if xVel>runAcc
      xVel=runAcc
    if xVel<-runAcc
      xVel=-runAcc
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    //moveTo(xVel,yVel)
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    //if isCollisionSolid()
    //  y-=2
    if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
