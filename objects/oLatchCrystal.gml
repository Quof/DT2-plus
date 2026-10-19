#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Latch Crystal"
maxLife=2500
life=maxLife
expWorth=10000
bCanDealDamage=false
bShowHealthBar=false
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
physicalDefense=oPlayer1.physicalPower-20
spiritDefense=oPlayer1.spiritPower-20
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  enemyStepEvent()
  life=maxLife
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTakingDamage=false and bActive=true
  oPlayer1.hitCombo-=1
event_inherited()
