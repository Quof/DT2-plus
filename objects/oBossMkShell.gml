#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

maxLife=100000
life=maxLife
bCanTakeDamage=0
rotSpd=0.75
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //image_angle+=rotSpd
  image_angle+=rotSpd*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
}
