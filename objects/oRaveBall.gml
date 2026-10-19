#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.4
for (i=0;i<10;i+=1)
{
  if x>256
    lineLightX[i]=random(224)+288
  else
    lineLightX[i]=random(224)
  lineLightY[i]=random(224)
  lineEffectDelay[i]=round(random(3)+2)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//hang line
draw_set_alpha(1)
lightColor=make_color_rgb(207,242,254)
draw_set_color(lightColor)
draw_line_width(view_xview[0]+x,view_yview[0],view_xview[0]+x,view_yview[0]+88,4)
//disco ball
draw_sprite_ext(sprite_index,image_index,view_xview[0]+x,view_yview[0]+84,1,1,0,image_blend,image_alpha)
//glow effect
draw_set_alpha(0.4)
draw_set_blend_mode(bm_add)
draw_circle_color(view_xview[0]+x,view_yview[0]+128,64,lightColor,c_black,false)
draw_set_blend_mode(bm_normal)
//line light effect
for (i=0;i<10;i+=1)
{
  draw_line(view_xview[0]+x,view_yview[0]+128,view_xview[0]+lineLightX[i],view_yview[0]+lineLightY[i])
  if lineEffectDelay[i]<=0
  {
    if x>256
      lineLightX[i]=random(224)+288
    else
      lineLightX[i]=random(224)
    lineLightY[i]=random(224)
    lineEffectDelay[i]=round(random(3)+2)
  }
  else
    lineEffectDelay[i]-=1
}
