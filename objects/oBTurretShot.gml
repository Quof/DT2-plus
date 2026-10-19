#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-4,-4,4,4)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bBlownUp=0
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
  //speed=bulletSpeed
  //image_angle=direction
  _speed=bulletSpeed //60fps change: see Create
  image_angle=_direction
  if isCollisionTop(1)
    bBlownUp=1
  if isCollisionBottom(1)
    bBlownUp=1
  if isCollisionLeft(1)
    bBlownUp=1
  if isCollisionRight(1)
    bBlownUp=1
  if bBlownUp=1
  {
    explosion=instance_create(x,y,oDataBomb)
    explosion.atkPower=atkPower
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.9)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,13,make_color_rgb(240,193,64),c_black,false)
draw_set_blend_mode(bm_normal)
event_inherited()
