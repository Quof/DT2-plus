#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
swingSpeed=0
swingTick=0 //60fps change (added): this spike's 30fps ticks (see the Step)

//Enemy base statistics
atkPower=6
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
  //image_angle+=swingSpeed
  //60fps change: the angle moves by this frame's share of the tick's speed, and the speed changes once per 30fps tick, after
  //that tick's move, from where the angle is then, as at 30fps (it turns around by the angle after the move and is capped,
  //so changing it a little every frame would drift from the 30fps swing over time). The same as the original at 30fps
  image_angle+=swingSpeed*gDeltaTime
  swingTick+=gDeltaTime
  if swingTick>=1
  {
  swingTick-=1

  if image_angle>360
  {
    swingSpeed-=0.05
    if swingSpeed<-4
      swingSpeed=-4
  }
  else
  {
    swingSpeed+=0.05
    if swingSpeed>4
      swingSpeed=4
  }
  } //60fps change (added)
}
