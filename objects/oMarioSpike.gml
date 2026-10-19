#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true

//Enemy base statistics
atkPower=4
bCanTakeDamage=false
bShowHealthBar=false

initX=x
initY=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //dir+=swingSpeed
  dir+=swingSpeed*gDeltaTime //60fps change: per 30fps tick
  x=initX+lengthdir_x(chainLinks*16,dir)
  y=initY+lengthdir_y(chainLinks*16,dir)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<chainLinks;i+=1)
{
  draw_sprite(sMarioChainPiece,0,initX+lengthdir_x(i*16,dir),initY+lengthdir_y(i*16,dir))
}

draw_set_blend_mode(bm_add)
draw_set_alpha(0.75)
draw_circle_color(x,y,20,make_color_rgb(240,160,70),c_black,false)
draw_set_blend_mode(bm_normal)
draw_sprite(sprite_index,0,x,y)
