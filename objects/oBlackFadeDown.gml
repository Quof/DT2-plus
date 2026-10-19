#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=r2_2a2 or room=rCutscene_3
{
  fadeDist=48
  pulsate=0
}
else if room=rTitle
{
  fadeDist=96
  pulsate=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: the pulse's phase and the size it adds are per 30fps tick (both ran 2x/4x as fast)
if room=r2_2a2 or room=rCutscene_3
{
  //pulsate+=0.1
  //fadeDist+=sin(pulsate)
  pulsate+=0.1*gDeltaTime
  fadeDist+=sin(pulsate)*gDeltaTime
}
else if room=rTitle
{
  //pulsate+=0.02
  //fadeDist+=sin(pulsate)
  pulsate+=0.02*gDeltaTime
  fadeDist+=sin(pulsate)*gDeltaTime
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_blend_mode(bm_subtract)
if room=r2_1a1 or room=r2_2a1
  draw_rectangle_color(0,-112,room_width,room_height+16,c_white,c_white,c_black,c_black,0) //Top to bottom
else if room=r2_1a2
{
  draw_rectangle_color(0,-32,room_width,room_height+240,c_black,c_black,c_white,c_white,0) //Top to bottom
  draw_rectangle_color(0,0,48,room_height,c_white,c_black,c_black,c_white,0) //Left
  draw_rectangle_color(464,0,512,room_height,c_black,c_white,c_white,c_black,0) //Right
}
else if room=r2_2a2 or room=rCutscene_3
{
  draw_rectangle_color(view_xview[0],view_yview[0],view_xview[0]+512,view_yview[0]+fadeDist,c_white,c_white,c_black,c_black,0) //top
  draw_rectangle_color(view_xview[0],view_yview[0]+384-fadeDist,view_xview[0]+512,view_yview[0]+384,c_black,c_black,c_white,c_white,0) //bottom
  draw_rectangle_color(view_xview[0],view_yview[0],view_xview[0]+fadeDist,view_yview[0]+384,c_white,c_black,c_black,c_white,0) //left
  draw_rectangle_color(view_xview[0]+512-fadeDist,view_yview[0],view_xview[0]+512,view_yview[0]+384,c_black,c_white,c_white,c_black,0) //right
}
else if room=r2_Ba1
{
  draw_rectangle_color(0,0,room_width,64,c_white,c_white,c_black,c_black,0) //Top
}
else if room=rFinal_EscapeA
{
  //draw_rectangle_color(240,0,room_width+768,room_height,c_black,c_white,c_white,c_black,0) //Left to right
  draw_rectangle_color(0,0,room_width,48,c_white,c_white,c_black,c_black,0) //Top
  draw_rectangle_color(0,336,room_width,384,c_black,c_black,c_white,c_white,0) //Bottom
}
else if room=rTitle
{
  draw_rectangle_color(0,-32,512,fadeDist,c_white,c_white,c_black,c_black,0) //top
  draw_rectangle_color(0,416-fadeDist,512,416,c_black,c_black,c_white,c_white,0) //bottom
  draw_rectangle_color(-32,0,fadeDist,384,c_white,c_black,c_black,c_white,0) //left
  draw_rectangle_color(544-fadeDist,0,544,384,c_black,c_white,c_white,c_black,0) //right
}
draw_set_blend_mode(bm_normal)
