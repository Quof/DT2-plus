#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_speed=random(0.15)+0.5

//Enemy base statistics
atkPower=4
bCanTakeDamage=false
bCauseKnockback=false
bShowHealthBar=false
difficultyAdjustments(global.difficulty)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  makeEnemyActive()
