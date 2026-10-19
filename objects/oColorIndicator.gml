#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//image_angle+=oColorIndControl.rotateAmt
image_angle+=oColorIndControl.rotateAmt*gDeltaTime //60fps change: per 30fps tick
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if oColorIndControl.warnTime>=oColorIndControl.warnDelay
if oColorIndControl.warnTime>oColorIndControl.warnDelay-1 //60fps change: from the warning's first frame (see oColorIndControl)
  draw_sprite_ext(sprite_index,image_index,x,y,oColorIndControl.visualWarnSize,oColorIndControl.visualWarnSize,image_angle*2,image_blend,oColorIndControl.visualWarnAlpha)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
