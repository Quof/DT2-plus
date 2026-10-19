#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bDestroyIfOffScreen=true
bounceDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//image_angle=direction
image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
if bounceDelay>0
  //bounceDelay-=1
  bounceDelay-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
#define Collision_oBCLaser
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if bounceDelay=0
if bounceDelay<=0 //60fps change: see the shooter note in oShipEnemyBase's Create (the same as =0 at 30fps)
{
  x-=12
  //var angleChange; angleChange=abs(direction-180)
  var angleChange; angleChange=abs(_direction-180) //60fps change: see the shooter note in oShipEnemyBase's Create
  //if direction>180 //angle up
  if _direction>180 //angle up //60fps change: see the shooter note in oShipEnemyBase's Create
    //direction-=angleChange*2
    _direction-=angleChange*2 //60fps change: see the shooter note in oShipEnemyBase's Create
  else //angle down
  {
    //direction+=angleChange*2
    _direction+=angleChange*2 //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  //image_angle=direction
  image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
  bounceDelay=6
}
