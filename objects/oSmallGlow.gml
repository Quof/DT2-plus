#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

sizeMod=0
bSizeUp=false
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_set_alpha(0.4)
  //60fps change: the glow pulses per 30fps tick (Draw runs every frame)
  if bSizeUp=false
  {
    //sizeMod-=0.05
    sizeMod-=0.05*gDeltaTime
    if sizeMod<=-1
      bSizeUp=true
  }
  else
  {
    //sizeMod+=0.05
    sizeMod+=0.05*gDeltaTime
    if sizeMod>=3
      bSizeUp=false
  }
  draw_set_blend_mode(bm_add)
  draw_circle_color(x+8,y+8,15+sizeMod,make_color_rgb(240,193,64),c_black,false)
  draw_set_blend_mode(bm_normal)
}
