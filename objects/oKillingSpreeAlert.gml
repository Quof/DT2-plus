#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
killingSpreeAlpha=1
killingSpreeFadeTime=80
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if killingSpreeFadeTime<=0
{
  //killingSpreeAlpha-=0.04
  killingSpreeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
  if killingSpreeAlpha<=0
    instance_destroy()
}
else
  //killingSpreeFadeTime-=1
  killingSpreeFadeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
killingSpreeIndX=view_xview[0]+256
killingSpreeIndY=view_yview[0]+72
comboCl=make_color_rgb(168,64,80)
draw_set_color(comboCl)
draw_set_halign(fa_center)
draw_set_font(fnt_KillChain)
draw_set_alpha(killingSpreeAlpha)

if alertType=0
  killingSpreeText="KILLING SPREE!!"
else if alertType=1
  killingSpreeText="DOMINATING!!"
else if alertType=2
  killingSpreeText="EXTERMINATION!!"
else if alertType=3
  killingSpreeText="SLAUGHTER!!"
else if alertType=4
  killingSpreeText="BLOOD BATH!!"
else if alertType=5
  killingSpreeText="ERRADICATION!!"
else if alertType=6
  killingSpreeText="WHICKED SICK!!"
else if alertType=7
  killingSpreeText="RAMPAGE!!"
else if alertType=8
  killingSpreeText="UNSTOPPABLE!!"
else if alertType=9
  killingSpreeText="GOD LIKE!!"
//text shadow - downright
draw_text(killingSpreeIndX+29,killingSpreeIndY+1,killingSpreeText)
//text highlight - upleft
comboCl=make_color_rgb(250,219,154)
draw_set_color(comboCl)
draw_text(killingSpreeIndX+27,killingSpreeIndY-1,killingSpreeText)
//text
comboCl=make_color_rgb(248,192,72)
draw_set_color(comboCl)
draw_text(killingSpreeIndX+28,killingSpreeIndY,killingSpreeText)
