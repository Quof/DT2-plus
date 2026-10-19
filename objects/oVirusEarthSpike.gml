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
  //y+=yVel
  yVel=scrGravAcc(yVel,grav,1) //60fps change: gravity spread over the frames (scrGravAcc; accelerates, then moves)
  y+=yVel*gDeltaTime //60fps change: per 30fps tick
  if y>room_height+sprite_height
    instance_destroy()
}
