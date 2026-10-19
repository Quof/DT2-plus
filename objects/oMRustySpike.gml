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
bShowHealthBar=false
detectDistX=96
detectDistY=304
fallingProgress=0
shakeDir=1
fallSpeed=4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true
  {
    //fallingProgress+=1
    if fallingProgress=0 {fallingProgress=1-gDeltaTime} //60fps change (added): so fallingProgress is 1 on the first frame, like at 30fps (it's then a whole number on the first frame of each 30fps tick)
    fallingProgress+=1*gDeltaTime //60fps change: counts 30fps ticks
    if fallingProgress=1
      x+=1
    //else if fallingProgress>=2 and fallingProgress<=30
    else if fallingProgress>=2 and fallingProgress<=30 and frac(fallingProgress)=0 //60fps change: one shake per 30fps tick (every frame shook 2x/4x as fast)
    {
      if shakeDir=1
        x-=2
      else
        x+=2
      shakeDir*=-1
    }
    else if fallingProgress=31
      x=xstart
    else if fallingProgress>=32
      //y+=fallSpeed
      y+=fallSpeed*gDeltaTime //60fps change: per 30fps tick
  }
  if y>room_height+24
    instance_destroy()
}
