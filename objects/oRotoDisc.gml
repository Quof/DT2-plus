#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
sX=x
sY=y
if image_blend=c_black
  midBlend=c_black
else
  midBlend=c_gray

//Enemy base statistics
atkPower=5
bCanTakeDamage=false
bShowHealthBar=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //dir+=swingSpeed
  dir+=swingSpeed*gDeltaTime //60fps change: per 30fps tick
  x=sX+lengthdir_x(spinDist,dir)
  y=sY+lengthdir_y(spinDist,dir)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(c_black)
draw_set_alpha(0.2)
draw_line(x,y,sX,sY)
draw_sprite_ext(sRotoDisc,-1,sX,sY,1,1,0,midBlend,0.8)
draw_sprite_ext(sprite_index,-1,x,y,1,1,0,image_blend,1)
