#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myTarget=noone
xOffset=0
yOffset=0

circleRad=0
var i;
for(i=0;i<4;i+=1) {angHist[i]=0} //60fps change (added): see the Step
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): the parts of a leg (types 0-2) turn with the next part (arms[arm+1]), which is updated after them,
//so they take the angle it had on the last step: a turn of the leg's end reaches its base over 3 steps. At 30fps that's
//3 ticks; above 30fps it was 3 frames, so the legs snapped into place 2x/4x as fast. The next part's angle is kept for a
//30fps tick (angHist) and the one from a tick ago is used (at 30fps it's still the last step's)
var tNextAng;
if type<3
{
  var tN, i;
  tN=round(1/gDeltaTime)
  for(i=tN-1;i>0;i-=1) {angHist[i]=angHist[i-1]}
  angHist[0]=oTWSG.arms[arm+1].image_angle
  tNextAng=angHist[tN-1]
}
if type=0
{
  x=oTWSG.x+lengthdir_x(24,angleSet)
  y=oTWSG.y+32+lengthdir_y(24,angleSet)
  //if arm<=7 {image_angle=oTWSG.arms[arm+1].image_angle+30}
  //else {image_angle=oTWSG.arms[arm+1].image_angle-30}
  if arm<=7 {image_angle=tNextAng+30} //60fps change: see above
  else {image_angle=tNextAng-30}
}
else if type=1
{
  x=oTWSG.arms[arm-1].x+lengthdir_x(27,oTWSG.arms[arm-1].image_angle)
  y=oTWSG.arms[arm-1].y+lengthdir_y(27,oTWSG.arms[arm-1].image_angle)
  //if arm<=7 {image_angle=oTWSG.arms[arm+1].image_angle+25}
  //else {image_angle=oTWSG.arms[arm+1].image_angle-25}
  if arm<=7 {image_angle=tNextAng+25} //60fps change: see above
  else {image_angle=tNextAng-25}
}
else if type=2
{
  x=oTWSG.arms[arm-1].x+lengthdir_x(27,oTWSG.arms[arm-1].image_angle)
  y=oTWSG.arms[arm-1].y+lengthdir_y(27,oTWSG.arms[arm-1].image_angle)
  //if arm<=7 {image_angle=oTWSG.arms[arm+1].image_angle+20}
  //else {image_angle=oTWSG.arms[arm+1].image_angle-20}
  if arm<=7 {image_angle=tNextAng+20} //60fps change: see above
  else {image_angle=tNextAng-20}
}
else if type=3
{
  if myTarget=noone
  {
    if arm=3 {tDir=340}
    else if arm=7 {tDir=290}
    else if arm=11 {tDir=200}
    else if arm=15 {tDir=250}
  }
  else
  {
    var tDist;
    tDist=point_distance(x+lengthdir_x(27,image_angle),y+lengthdir_y(27,image_angle),myTarget.x+xOffset,myTarget.y+yOffset)
    if tDist>76 {tDir=point_direction(x+lengthdir_x(27,image_angle),y+lengthdir_y(27,image_angle),myTarget.x+xOffset,myTarget.y+yOffset)}
  }
  x=oTWSG.arms[arm-1].x+lengthdir_x(27,oTWSG.arms[arm-1].image_angle)
  y=oTWSG.arms[arm-1].y+lengthdir_y(27,oTWSG.arms[arm-1].image_angle)
  image_angle=tDir
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if global.gamePaused=false
{
  if circleRad>=1
  {
    draw_set_alpha(1)
    draw_set_color(c_white)
    //circleRad-=0.5
    circleRad-=0.5*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    draw_circle(x+lengthdir_x(27,image_angle),y+lengthdir_y(27,image_angle),circleRad,1)
    //if circleRad=1
    if circleRad<=1 //60fps change: <=, so it still fires if the frame rate changed mid-count (the same at 30fps)
    {
      var newAttack,toPlayer;
      toPlayer=point_direction(x+lengthdir_x(27,image_angle),y+lengthdir_y(27,image_angle),oPlayer1.x,oPlayer1.y-26)
      newAttack=instance_create(x+lengthdir_x(27,image_angle),y+lengthdir_y(27,image_angle),oPassBullet)
      //newAttack.sprite_index=sEnergyBall; newAttack.direction=toPlayer; newAttack.image_speed=0.25
      newAttack.sprite_index=sEnergyBall; newAttack._direction=toPlayer; newAttack.image_speed=0.25 //60fps change: _direction (oPassBullet moves by _speed/_direction)
      newAttack.atkPower=oTWSG.atkPower; newAttack.bulletSpeed=6
      circleRad=0
    }
  }
}
