#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=1
bCanTakeDamage=false
bShowHealthBar=false

//direction=270
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in
//speed/direction, which GameMaker applies in full every frame
_direction=270
_speed=0
bulletSpeed=5
turnSpeed=3

effectSize[0]=1
effectSize[1]=1.25
effectSize[2]=1.5
effectAlpha[0]=0.75
effectAlpha[1]=0.5
effectAlpha[2]=0.25
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //speed=bulletSpeed
  //image_angle=direction
  //turn_toward_direction(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),turnSpeed)
  _speed=bulletSpeed //60fps change: see Create; it turns turnSpeed per 30fps tick (turn_toward_directionUnderscore)
  image_angle=_direction
  turn_toward_directionUnderscore(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),turnSpeed)
}
//else {speed=0}
else {_speed=0}
correctSpeedDirection(self) //60fps change (added): see Create
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i=0;i<3;i+=1)
{
  if effectSize[i]<1.75
  {
    //effectSize[i]+=0.01
    //effectAlpha[i]-=0.01
    effectSize[i]+=0.01*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    effectAlpha[i]-=0.01*gDeltaTime
  }
  else
  {
    effectSize[i]=1
    effectAlpha[i]=0.75
  }
}
draw_set_blend_mode(bm_add)
draw_set_alpha(0.75)
draw_circle_color(x,y,32,make_color_rgb(240,160,70),c_black,false)
draw_sprite_ext(sprite_index,image_index,x,y,effectSize[0],effectSize[0],image_angle,image_blend,effectAlpha[0])
draw_sprite_ext(sprite_index,image_index,x,y,effectSize[1],effectSize[1],image_angle,image_blend,effectAlpha[1])
draw_sprite_ext(sprite_index,image_index,x,y,effectSize[2],effectSize[2],image_angle,image_blend,effectAlpha[2])
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
