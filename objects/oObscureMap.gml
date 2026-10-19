#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oWorldMap.menuActive=false
{
  draw_set_blend_mode(bm_subtract)
  draw_circle_color(x,y,64,c_white,c_black,false)
  draw_set_blend_mode(bm_normal)
}
