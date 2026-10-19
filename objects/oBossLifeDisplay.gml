#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(bossID)
{
  if bossID.life>0 and bossID.bShowHealthBar=true
  {
    draw_set_font(fnt_BossName)
    draw_set_color(make_color_rgb(228,183,76))
    draw_set_halign(fa_left)
    bossBarX=view_xview[0]+16
    bossBarY=view_yview[0]+359
    draw_set_alpha(1)
    draw_sprite_ext(sBossBarMid,0,bossBarX+17,bossBarY,280,1,0,c_white,1)
    draw_sprite(sBossBarEnds,0,bossBarX,bossBarY)
    draw_sprite(sBossBarEnds,1,bossBarX+297,bossBarY)

    draw_sprite(sBossNameBar,0,bossBarX,bossBarY-14)

    if bossID.eName="Suffering"
    {
      draw_set_color(make_color_rgb(234,93,46))
      draw_text(bossBarX+6,bossBarY-11,"<Data locked>")
      draw_sprite_ext(sBossBarTrack,2,bossBarX+7,bossBarY+6,300,1,0,c_gray,1)
      draw_text(bossBarX+12,bossBarY+5,"<Data locked> <Data locked> <Data locked>")
    }
    else
    {
      draw_text(bossBarX+6,bossBarY-11,bossID.eName)
      healthTrack=(bossID.life/bossID.maxLife)*300
      draw_sprite_ext(sBossBarTrack,2,bossBarX+7,bossBarY+6,healthTrack,1,0,c_white,1)
    }
  }
}
else {instance_destroy()}
