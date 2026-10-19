#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-2,-2,2,2)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bBlownUp=false

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
  image_angle=direction //(direction is only this shot's angle: it moves by xVel/yVel, and its built-in speed is 0)
  //yVel+=grav
  yVel=scrGravAcc(yVel,grav,1) //60fps change: gravity (accelerate, then move) spread over the frames so the arc matches 30fps (see scrGravAcc)
  dist=point_distance(x,y,xstart,ystart)
  if dist>32
  {
    if isCollisionTop(1)
      instance_destroy()
    if isCollisionBottom(1)
      instance_destroy()
    if isCollisionLeft(1)
      instance_destroy()
    if isCollisionRight(1)
      instance_destroy()
    if isCollisionSolid()
      instance_destroy()
  }
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move

  if y>room_height+32
    instance_destroy()
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
