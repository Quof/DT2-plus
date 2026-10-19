#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=-4.5
friction=0.15
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_Points)
draw_set_halign(fa_center)
draw_text_color(x,y+1,round(pointValue),c_black,c_black,c_black,c_black,1)
draw_text_color(x,y,round(pointValue),c_white,c_white,c_white,c_white,1)

if vspeed>=0
  instance_destroy()
