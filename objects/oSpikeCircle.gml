#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=5
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
spinSpd=-3
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newSpd")
  spinSpd=newSpd
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //image_angle+=spinSpd
  image_angle+=spinSpd*gDeltaTime //60fps change: per 30fps tick
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if bCanTakeHit=true and bCanTakeDamage=true
    takeDamage()
}
