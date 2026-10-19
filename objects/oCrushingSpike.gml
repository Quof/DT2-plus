#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-15,15,15)

//Enemy base statistics
atkPower=5
bCanTakeDamage=false
bShowHealthBar=false
seekSpeed=10
seekTime=0
seekDelay=20
bReturning=false
bTargetFound=false
detectDistX=44
detectDistY=288
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //start movement in Player's direction (down)
  if bActive=true and y<oPlayer1.y
  {
    if bTargetFound=false
    {
      yVel=seekSpeed
      bTargetFound=true
      seekTime=seekDelay
    }
  }
  if seekTime>0
  {
    //seekTime-=1
    seekTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    //if isCollisionBottom(1)
    //60fps change: not while already going back up. At 30fps it's 3px off the ground a tick after turning around, but above
    //30fps a frame's move up is under a pixel, so it was still touching the ground and turned around again (and again).
    //The same at 30fps
    if isCollisionBottom(1) and bReturning=false
    {
      bReturning=true
      yVel/=-3
    }
    if seekTime=0 and bReturning=false
    {
      bReturning=true
      yVel/=-3
    }
  }
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move

  //Return to original position
  if bReturning=true
  {
    if y<=ystart
    {
      y=ystart
      yVel=0
      bTargetFound=false
      bReturning=false
      bActive=false
    }
  }
}
