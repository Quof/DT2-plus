#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_angle=90
image_xscale=2
image_yscale=4
delay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //delay+=1
  delay+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if delay>=30
    bDestroyIfOffScreen=true
}
