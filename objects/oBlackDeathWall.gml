#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveSpd=3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if oGame.time mod 3=0
  if oGame.time mod (3/gDeltaTime)=0 //60fps change: every 3 ticks (oGame.time counts frames)
  {
    instance_create(x-24,random(room_height),oBDeathWallFLight)
  }
  //x+=moveSpd
  x+=moveSpd*gDeltaTime //60fps change: per 30fps tick
  if x+8>=oPlayer1.x
  {
    oPlayer1.life-=oPlayer1.maxLife
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(0,0,x,room_height,0)
draw_set_blend_mode(bm_subtract)
draw_rectangle_color(x,0,x+64,room_height,c_white,c_black,c_black,c_white,0)
draw_set_blend_mode(bm_normal)
