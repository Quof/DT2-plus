#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
depth=1500000

image_angle=180
x+=15
y+=16

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bCauseKnockback=false
bShowHealthBar=false
bOut=1
switchTime=0
switchDelay=60
if variable_local_exists("bReverse")
{
  bOut=0
  y+=16
}
if variable_local_exists("newTime")
  switchDelay=newTime
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //switchTime+=1
  switchTime+=1*gDeltaTime //60fps change: counts 30fps ticks
  if switchTime>=switchDelay
  {
    if bOut=0
    {
      y-=16
      bOut=1
    }
    else
    {
      y+=16
      bOut=0
    }
    switchTime=0
  }
}
