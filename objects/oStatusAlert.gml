#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
statusYoffset=y
statusAlpha=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//statusYoffset-=3
//statusAlpha-=0.05
statusYoffset-=3*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
statusAlpha-=0.05*gDeltaTime //60fps change: per 30fps tick

draw_set_font(fnt_DamageNotice)
draw_set_halign(fa_center)
draw_text_color(x+1,statusYoffset+1,statusEffect,c_black,c_black,c_black,c_black,statusAlpha)
draw_text_color(x,statusYoffset,statusEffect,statusColor,statusColor,statusColor,statusColor,statusAlpha)

if statusAlpha<=0
  instance_destroy()
