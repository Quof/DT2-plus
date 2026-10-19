/*
This script inverts the colors of the designated area.
Use in draw event.
argument0: type: 0-rectangle, 1-circle
argument1: if rectangle-width, if circle-radius
argument2: if rectangle-height, if circle-not used
*/
draw_set_color(c_white)
draw_set_blend_mode_ext(bm_inv_dest_color,bm_zero)
if argument0=0
  draw_rectangle(x,y,x+argument1,y+argument2,0)
else if argument0=1
  draw_circle(x,y,argument1,0)
draw_set_blend_mode(bm_normal)
