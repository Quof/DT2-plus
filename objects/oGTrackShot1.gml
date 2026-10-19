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
//which GameMaker applies in full every frame; whatever fires it sets _direction. curveTickTime counts this shot's 30fps ticks
_speed=0
_direction=0
curveTickTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=bulletSpeed
  //direction+=curveAmount
  //image_angle=direction
  //
  //curveTime-=1
  //if curveAmount!=0 and curveTime>0
  //{
  //  if curveAmount>0
  //    curveAmount-=0.1
  //  else
  //    curveAmount+=0.1
  //}
  //if curveTime=0
  //  curveAmount=0
  //60fps change: the curve is spread over the frames (curveAmount is a 30fps tick's turn), and curveTime/curveAmount
  //change once per 30fps tick of this shot (counted from when it was fired), after that tick's turn, as at 30fps, so the
  //shot follows the 30fps path (see oNormArcBullet)
  _speed=bulletSpeed
  if curveTickTime>=1
  {
    curveTickTime-=1
    curveTime-=1
    if curveAmount!=0 and curveTime>0
    {
      if curveAmount>0
        curveAmount-=0.1
      else
        curveAmount+=0.1
    }
    if curveTime=0
      curveAmount=0
  }
  _direction+=curveAmount*gDeltaTime
  image_angle=_direction
  curveTickTime+=gDeltaTime
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
