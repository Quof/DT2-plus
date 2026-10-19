#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //x-=2
  x-=2*gDeltaTime //60fps change: per 30fps tick
  if x<view_xview[0]-sprite_width
    instance_destroy()
}
