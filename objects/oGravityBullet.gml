#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-3,-3,3,3)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
weight=50
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //yVel+=grav
  yVel=scrGravAcc(yVel,grav,1) //60fps change: gravity (accelerate, then move) spread over the frames so the arc matches 30fps (see scrGravAcc)
  if isCollisionTop(1)
    instance_destroy()
  if isCollisionBottom(1)
    instance_destroy()
  if isCollisionLeft(1)
    instance_destroy()
  if isCollisionRight(1)
    instance_destroy()
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move

  if y>room_height+32
    instance_destroy()
}
