#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveSpd=oBlackDeathWall.moveSpd+1+random(2)
//direction=random_range(100,260)+180
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame
_direction=random_range(100,260)+180
_speed=0
lifeTime=15
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=moveSpd
  //lifeTime-=1
  //if lifeTime=0 {instance_destroy()}
  _speed=moveSpd //60fps change: see Create
  lifeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if lifeTime<=0 {instance_destroy()} //60fps change: <=, so it still ends if the frame rate changed mid-count (the same at 30fps)
}
//else {speed=0}
else {_speed=0}
correctSpeedDirection(self) //60fps change (added): see Create
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_subtract)
draw_circle_color(x,y,48,c_white,c_black,false)
draw_set_blend_mode(bm_normal)
