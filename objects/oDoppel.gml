#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.4

//Enemy base statistics
eName="Dopple"
maxLife=10
life=maxLife
pointWorth=10
atkPower=1
atkDefense=0
FIREresist=0
WATERresist=0
WINDresist=0
EARTHresist=0
scanText="It doesn't do anything. I guess it's some kind of joke because it's really pathetic."
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
}
