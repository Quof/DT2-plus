#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

decay=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction
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
  //decay+=1
  //if decay=300
  //60fps change: decay counts 30fps ticks. At 30fps it's gone in its step before tick 300's move, so it goes on the
  //first frame of that tick (>299; the same as =300 at 30fps)
  _speed=bulletSpeed
  image_angle=_direction
  decay+=1*gDeltaTime
  if decay>299
    instance_destroy()
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
