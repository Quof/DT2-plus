#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if type=0
    //direction+=changeDir
    _direction+=changeDir*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  else if type=1
    //direction-=changeDir
    _direction-=changeDir*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  //changeDirTime+=1
  changeDirTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if changeDirTime>=dirThreshold
  {
    changeDir*=-1
    changeDirTime=0
  }
  //image_angle=direction
  image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
}
