#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bBlownUp=false
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever fires it sets _direction
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //image_angle=direction
  //speed=bulletSpeed
  image_angle=_direction //60fps change: see Create
  _speed=bulletSpeed
  dist=point_distance(x,y,xstart,ystart)
  if dist>32
  {
    if isCollisionTop(1)
      bBlownUp=true
    if isCollisionBottom(1)
      bBlownUp=true
    if isCollisionLeft(1)
      bBlownUp=true
    if isCollisionRight(1)
      bBlownUp=true
    if bBlownUp=true
      instance_destroy()
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
