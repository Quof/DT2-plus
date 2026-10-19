#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(-12,-24,12,-1)
image_speed=0.3

//Enemy base statistics
eName="Ruin Monkey"
maxLife=25
life=maxLife
pointWorth=200
atkPower=3
atkDefense=0
FIREresist=25
WATERresist=75
WINDresist=75
EARTHresist=0
baseItemChance=50
initDir=0

runAcc=3.25
bJumpReady=1
scanText="Eww gross!##The behavior is simple. It tracks you and will jump at cliff edges."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if gDeltaTime<1 {scrSolidPushOut()} //60fps change (added): out of a solid it's in (e.g. an elevator that rose into it) before anything looks at where it is (see scrSolidPushOut)
    //---------- Movement ----------
    if yVel=0 and bJumpReady=1
    {
      image_speed=0.25
      sprite_index=sRuinMonkeyRun
      if x<oPlayer1.x
      {
        image_xscale=1
        xVel=runAcc
      }
      else
      {
        image_xscale=-1
        xVel=-runAcc
      }
    }
    else
    {
      image_speed=0
      sprite_index=sRuinMonkeyJump
      if yVel<0
        image_index=0
      else
        image_index=1
    }

    //Check if cliff edge and jump
    if yVel=0 and bJumpReady=1
    {
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,16,16,4)=1
        {
          tDrop=1
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    //yVel+=0.33
    yVel=scrGravAcc(yVel,0.33,1) //60fps change: gravity (accelerate, then move) spread over the frames so jumps and falls match 30fps (see scrGravAcc)
    if isCollisionBottom(1)
    {
      yVel=0
      bJumpReady=1
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    //if isCollisionSolid()
    //  y-=2
    if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step

    //moveTo(xVel,yVel)
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
