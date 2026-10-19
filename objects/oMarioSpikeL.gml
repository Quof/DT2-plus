#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_angle=90
y+=15

//Enemy base statistics
atkPower=5
bCanTakeDamage=false
bCauseKnockback=false
bShowHealthBar=false
bFollow=false
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
difficultyAdjustments(global.difficulty)

if variable_local_exists("idFollow")
  bFollow=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  makeEnemyActive()
followInstance()
