#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
parent="Bullet"
bulletSpeed=1
bulletArc=0
moveDelay=0
decay=-1
//60fps change (added): see the shooter note in oShipEnemyBase's Create
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if moveDelay=0
  //{
  //  speed=bulletSpeed
  //  direction+=bulletArc
  //}
  //else
  //  moveDelay-=1
  //60fps change: see the shooter note in oShipEnemyBase's Create (moveDelay counts down 30fps ticks; <=0 is the same as
  //=0 at 30fps, where it never goes below 0)
  if moveDelay<=0
  {
    _speed=bulletSpeed
    _direction+=bulletArc*gDeltaTime
  }
  else
    moveDelay-=1*gDeltaTime

  //delete if off screen
  if bDestroyIfOffScreen=1
  {
    if x<-abs(sprite_width)-4 //left
      instance_destroy()
    else if x>room_width+abs(sprite_width)+4 //right
      instance_destroy()
    else if y<-sprite_height-36 //top
      instance_destroy()
    else if y>room_height+sprite_height+4 //bottom
      instance_destroy()
  }
  if decay>0
  {
    //decay-=1
    //if decay=0
    //60fps change: counts 30fps ticks; at 30fps it's gone in its step on the tick decay runs out, before that tick's move,
    //so it goes on that tick's first frame (<1; the same as =0 at 30fps)
    decay-=1*gDeltaTime
    if decay<1
      instance_destroy()
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
correctSpeedDirection(self) //60fps change (added): see Create
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*draw_set_alpha(1)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,12,make_color_rgb(240,193,64),c_black,false)
draw_set_blend_mode(bm_normal)*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
