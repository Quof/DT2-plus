#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever throws it sets _direction. topTickTime runs the aimed top's 30fps
//step on its own ticks (see Step)
_speed=0
_direction=0
topTickTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=1 //aimed at player
  {
    //speed=bulletSpeed
    //bulletSpeed-=spdDown
    //if bulletSpeed<=0
    //60fps change: the 30fps step (set the speed, slow down, turn to the player once it runs out) runs on the first frame
    //of each of this top's 30fps ticks, and the tick's move is spread over its frames with the speed and direction that
    //step left (as at 30fps, where it moves after its step), so it takes the 30fps path (the same as before at 30fps)
    if topTickTime<=0
    {
    topTickTime+=1
    _speed=bulletSpeed
    bulletSpeed-=spdDown
    if bulletSpeed<=0
    {
      bulletSpeed=9
      var pDir;
      pDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-22)
      //direction=pDir
      _direction=pDir
      image_angle=pDir
      lifeLine-=1
      if lifeLine<=0
      {
        effect=instance_create(x,y,oEffect)
        effect.sprite_index=sMMExplosion
        effect.image_speed=0.7
        instance_destroy()
      }
    }
    }
    topTickTime-=gDeltaTime
  }
  else if type=2 //shoot energy balls down
  {
    if y>=136
    {
      //atkProg+=1
      atkProg+=1*gDeltaTime //60fps change: counts 30fps ticks ("mod atkSpd=0" only lands on whole numbers)
      if atkProg mod atkSpd=0
      {
        energyBall=instance_create(x,y,oPassBullet)
        energyBall.sprite_index=sHarpuiaEnergyBall
        energyBall.atkPower=atkPower
        energyBall.bulletSpeed=7
        //energyBall.direction=270
        energyBall._direction=270 //60fps change: _direction (oPassBullet moves by _speed/_direction)
        energyBall.image_speed=0.5
      }

      if atkProg>=lifeLine
      {
        effect=instance_create(x,y,oEffect)
        effect.sprite_index=sMMExplosion
        effect.image_speed=0.7
        instance_destroy()
      }
    }
    else
      //y+=4
      y+=4*gDeltaTime //60fps change: per 30fps tick (lands on 136 as at 30fps)
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.9)
draw_set_blend_mode(bm_add)
draw_circle_color(x,y,12,make_color_rgb(240,193,64),c_black,false)
draw_set_blend_mode(bm_normal)
event_inherited()
