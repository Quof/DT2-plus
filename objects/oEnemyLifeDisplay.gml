#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
displayAlpha=1
displayFadeTime=80
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if displayFadeTime<=0
{
  //displayAlpha-=0.04
  displayAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
  if displayAlpha<=0
    instance_destroy()
}
else
  //displayFadeTime-=1
  displayFadeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
if instance_exists(eID)
{
  displayIndX=view_xview[0]+508
  displayIndY=view_yview[0]+375
  draw_set_color(make_color_rgb(0,255,0))
  draw_set_halign(fa_right)
  draw_set_font(fnt_EnemyName)
  draw_set_alpha(displayAlpha)
  if eID.life>0
    lifeTrack=(eID.life/eID.maxLife)*50
  else
    lifeTrack=0
  //text
  draw_set_color(make_color_rgb(0,255,0))
  draw_text(displayIndX+2,displayIndY-13,eID.eName)
  //life bar
  draw_set_color(make_color_rgb(32,47,66))
  draw_rectangle(displayIndX-51,displayIndY,displayIndX,displayIndY+4,false)
  draw_set_color(make_color_rgb(248,192,71))
  draw_rectangle(displayIndX-51,displayIndY,displayIndX,displayIndY+4,true)
  draw_sprite_ext(sHealthTrack,1,displayIndX-50,displayIndY+1,lifeTrack,0.5,0,c_white,displayAlpha)
}
else
  instance_destroy()
