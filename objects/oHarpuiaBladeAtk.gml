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
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever fires it sets _direction. bladeTickTime runs the tornado's per-tick
//slow-down on its own 30fps ticks (see Step)
_speed=0
_direction=0
bladeTickTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=bulletSpeed
  _speed=bulletSpeed //60fps change: see Create
  if type=30
  {
    //image_xscale+=0.04
    //image_yscale+=0.04
    image_xscale+=0.04*gDeltaTime //60fps change: grows per 30fps tick
    image_yscale+=0.04*gDeltaTime
  }
  else if type=50
  {
    //bulletSpeed-=0.25
    //if bulletSpeed<=0
    //  instance_destroy()
    //60fps change: the 30fps step (set the speed, then slow down, gone once it runs out) runs on the first frame of each
    //of this tornado's 30fps ticks, and the tick's move is spread over its frames at the speed it set, so it goes as far
    //as at 30fps (the same as before at 30fps)
    if bladeTickTime<=0
    {
      bladeTickTime+=1
      bladeSpd=bulletSpeed
      bulletSpeed-=0.25
      if bulletSpeed<=0
        instance_destroy()
    }
    _speed=bladeSpd
    bladeTickTime-=gDeltaTime
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
