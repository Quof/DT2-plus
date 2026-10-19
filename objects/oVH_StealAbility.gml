#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.05+random(0.05)
moveProg=0
moveTime=0

growth=1
pulsate=0
wobble=0
scaleMultiplier=1.25
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction
_speed=0
_direction=0

for(i=0;i<8;i+=1)
{
  handDir[i]=random(360)
  handFrm[i]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //pulsate+=0.5
  //wobble+=sin(pulsate)/100
  //60fps change: per 30fps tick (as are the counts and moves below)
  pulsate+=0.5*gDeltaTime
  wobble+=sin(pulsate)/100*gDeltaTime

  if moveProg=0
  {
    //y-=1
    //moveTime+=1
    y-=1*gDeltaTime
    moveTime+=1*gDeltaTime
    if moveTime>=80
    {
      moveTime=0
      moveProg=1
    }
  }
  else if moveProg=1
  {
    //moveTime+=1
    moveTime+=1*gDeltaTime
    if moveTime>=40
    {
      moveTime=0
      moveProg=2
    }
  }
  else if moveProg=2
  {
    //direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
    //speed=3
    //growth+=0.0005
    _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26) //60fps change: see Create
    _speed=3
    growth+=0.0005*gDeltaTime
    image_xscale=growth; image_yscale=growth
  }
}
//else {speed=0}
else {_speed=0}
correctSpeedDirection(self) //60fps change (added): see Create
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveProg=2
{
  oHorrorVirus.bossProgress+=1
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,(image_yscale+wobble)*scaleMultiplier,(image_yscale+wobble)*scaleMultiplier,image_angle,image_blend,0.25)
for(i=0;i<8;i+=1)
{
  //handFrm[i]+=0.1+random(0.1)
  handFrm[i]+=(0.1+random(0.1))*gDeltaTime //60fps change: animates per 30fps tick (Draw runs every frame)
  draw_sprite_ext(sVH_ExtendHands,handFrm[i],x+lengthdir_x(12,handDir[i]),y+lengthdir_y(12,handDir[i]),(image_yscale+wobble),(image_yscale+wobble),handDir[i],image_blend,image_alpha)
}
draw_sprite_ext(sprite_index,image_index,x,y,(image_yscale+wobble),(image_yscale+wobble),image_angle,image_blend,image_alpha)
