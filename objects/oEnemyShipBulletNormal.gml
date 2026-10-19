#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if sprite_index=sShipShot2 or sprite_index=sShipShot3  or sprite_index=sShipShot4
    //image_angle=direction
    image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
}
