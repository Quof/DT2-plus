#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if yVel>16
    yVel=16
  if y>room_height+24
    instance_destroy()
}
