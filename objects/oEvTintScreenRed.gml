#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(oChaserVirus) {image_alpha=0}
else {image_alpha=0.3}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if image_alpha<0.3 {image_alpha+=0.01}
  if image_alpha<0.3 {image_alpha+=0.01*gDeltaTime} //60fps change: per 30fps tick
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_red)
draw_set_alpha(image_alpha)
draw_rectangle(-1,-1,room_width+1,room_height+1,0)
