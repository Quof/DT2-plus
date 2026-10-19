#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bulletProg=0
bulletTime=0
bDestroyIfOffScreen=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //bulletTime+=1
  bulletTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if bulletProg=0 //shoot out
  {
    if bulletTime=bulletDelay
    {
      bulletSpeed=0
      bulletTime=0
      bulletProg=1
    }
  }
  else if bulletProg=1 //target and pause
  {
    if bulletTime=1
      //direction=point_direction(x,y,oClaireShip.x,oClaireShip.y)
      _direction=point_direction(x,y,oClaireShip.x,oClaireShip.y) //60fps change: see the shooter note in oShipEnemyBase's Create
    else if bulletTime=bulletDelay*8
    {
      bulletSpeed=2
      bulletProg=2
    }
  }
}
