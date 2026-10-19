#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if gDeltaTime<1 {scrSolidPushOut()} //60fps change (added): out of a solid it's in (e.g. an elevator that rose into it) before anything looks at where it is (see scrSolidPushOut)
  //yVel+=0.3
  yVel=scrGravAcc(yVel,0.3,1) //60fps change: gravity (accelerate, then move) spread over the frames so falls match 30fps (see scrGravAcc)
  if isCollisionBottom(1)
    yVel=0
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
  //if isCollisionSolid()
  //  y-=2
  if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step
  if y>room_height+24
    instance_destroy()
}
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.yVel>0
{
  oPlayer1.canAirDash=1
  //other.yVel=-20
  other.yVel=-20
  other.yVelSetExt=1 //60fps change (added): velocity set after the player's move: its next move uses the 30fps formula (see pMoveToWrapNew)
  if other.attackState=other.PART_JUMP_SLASH_1
    other.attackState=0
  else if other.attackState=other.TECH_GRAND_SLAM
    other.attackState=0
}
