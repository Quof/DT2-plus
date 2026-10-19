#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
atkPower=4
bCanTakeDamage=false
bShowHealthBar=false

shiftTime=0
shiftTimeMax=96

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shiftTimeMax=shiftChange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  //x+=xDir
  //y+=yDir
  x+=xDir*gDeltaTime //60fps change: per 30fps tick
  y+=yDir*gDeltaTime //60fps change: per 30fps tick
  //if shiftTime>=shiftTimeMax
  //60fps change: the count is checked before it's added to, so at 30fps each way lasts shiftTimeMax+1 ticks; counting
  //fractions of a tick it turned around one frame after reaching it (each way half/three quarters of a tick short, so the
  //trap fell out of step with 30fps every trip). The turn-around is that much later (shiftTimeMax at 30fps)
  if shiftTime>=shiftTimeMax+1-gDeltaTime
  {
    shiftTime=0
    xDir*=-1
    yDir*=-1
  }
  else
    //shiftTime+=1
    shiftTime+=1*gDeltaTime //60fps change: counts 30fps ticks
}
