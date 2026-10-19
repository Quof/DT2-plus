#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
delayTime=1000
image_speed=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //delayTime-=1
  delayTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if delayTime=0
  {
    tNewEnemy=instance_create(x,y,ceObject)
    tNewEnemy.bActive=1
    instance_destroy()
  }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if delayTime>100
{
  delayTime=10
  visible=0
}
