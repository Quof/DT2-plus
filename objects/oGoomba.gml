#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(-7,-18,7,-1)
image_speed=0.3

//Enemy base statistics
eName="Goomba"
maxLife=20
life=maxLife
pointWorth=100
atkPower=2
atkDefense=0
FIREresist=50
WATERresist=75
WINDresist=50
EARTHresist=0
baseItemChance=50
initDir=0
runAcc=1
scanText="Goombas are so cute! I wish I could have one as a pet, but not these guys, they look mean. :( I want one from the Paper Mario series, OMG they were so cute!!"
if global.lvlCurrent="Final"
  jeremyText="I can't really say anything about them that you don't already know. I'm working on making it possible for you to stomp on anything Mario related. I should have it done soon.##And sis, did you design this scan interface? It's really an eye sore."
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
    if initDir=0
    {
      xVel=runAcc
      if x>oPlayer1.x
        xVel*=-1
      initDir=1
    }
    //yVel+=0.2
    yVel=scrGravAcc(yVel,0.2,1) //60fps change: gravity (accelerate, then move) spread over the frames so falls match 30fps (see scrGravAcc)
    if isCollisionBottom(1)
      yVel=0
    //if isCollisionLeft(1)
    //  xVel*=-1
    //if isCollisionRight(1)
    //  xVel*=-1
    //60fps change: only a wall it's walking into turns it around (isCollisionLeftEdit/RightEdit): moving less than a pixel a
    //frame, it was still touching the wall on the next frame and turned back into it, over and over
    if isCollisionLeftEdit(1)
      xVel*=-1
    if isCollisionRightEdit(1)
      xVel*=-1
    //if isCollisionSolid()
    //  y-=2
    if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step
    if xVel>0
      image_xscale=1
    else
      image_xscale=-1
    //moveTo(xVel,yVel)
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
