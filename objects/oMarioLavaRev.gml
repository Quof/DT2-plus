#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_angle=180
x+=15
y+=15
image_speed=random(0.1)+0.1

//Enemy base statistics
atkPower=5
bCanTakeDamage=false
bCauseKnockback=false
bShowHealthBar=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  makeEnemyActive()
