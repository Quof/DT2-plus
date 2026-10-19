#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false

flameTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //flameTime+=1
  flameTime+=1*gDeltaTime //60fps change: counts 30fps ticks (lands on each of the times below)
  if flameTime=3
    image_index=1
  else if flameTime=6
    image_index=2
  else if flameTime=9
    image_index=3
  else if flameTime=12
  {
    sprite_index=sTankFlameB
    bCanDealDamage=true
    image_index=0
    image_speed=0.7
  }
  else if flameTime=60
  {
    sprite_index=sTankFlameA
    bCanDealDamage=false
    image_index=3
    image_speed=0
  }
  else if flameTime=62
    image_index=2
  else if flameTime=64
    image_index=1
  else if flameTime=66
    image_index=0
  //else if flameTime=68
  else if flameTime>=68 //60fps change: >=, so it still ends if the frame rate changed mid-count (the same at 30fps)
    instance_destroy()
}
