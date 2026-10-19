#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
arcStart=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //image_angle=direction
  image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
  //arcStart+=1
  arcStart+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  //if arcStart>=10
  if arcStart>9 //60fps change: see the shooter note in oShipEnemyBase's Create (it turns on all the frames of the ticks from 10 on)
  {
    if type=1 //top first
    {
      //if direction<=270
      if _direction<=270 //60fps change: see the shooter note in oShipEnemyBase's Create
        //direction+=arcDir
        _direction+=arcDir*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      else
      {
        bulletSpeed/=2
        //direction=270
        _direction=270 //60fps change: see the shooter note in oShipEnemyBase's Create
        type=10
      }
    }
    else if type=2 //bottom first
    {
      //if direction>=90
      if _direction>=90 //60fps change: see the shooter note in oShipEnemyBase's Create
        //direction-=arcDir
        _direction-=arcDir*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      else
      {
        bulletSpeed/=2
        //direction=90
        _direction=90 //60fps change: see the shooter note in oShipEnemyBase's Create
        type=10
      }
    }
  }

  //if arcStart=300
  if arcStart>=300 //60fps change: see the shooter note in oShipEnemyBase's Create (>=: the same at 30fps)
    bDestroyIfOffScreen=true
}
