#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
visible=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //atkProg+=1
  //if atkProg>=1 and atkProg<=40
  //60fps change: atkProg counts 30fps ticks. The pool grows once per tick (gDeltaDoTicks) in ticks 1-40; the slam runs on
  //all the frames of ticks 50-199, showing itself on the first one; the ends land on their ticks (the same at 30fps)
  atkProg+=1*gDeltaTime
  if atkProg>0 and atkProg<=40 and gDeltaDoTicks
  {
    var tEffect,tRanScl;
    tRanScl=1+random(0.66)
    tEffect=instance_create(x-20+random(40),y-2+random(4),oEffect)
    tEffect.sprite_index=sVH_PoolGrowth; tEffect.image_speed=0.2; tEffect.decay=12
    tEffect.image_xscale=tRanScl; tEffect.image_yscale=tRanScl; tEffect.depth=8
  }
  //else if atkProg>=50 and atkProg<=199
  else if atkProg>49 and atkProg<=199
  {
    //if atkProg=50
    if atkProg=49+gDeltaTime
    {
      bCanDealDamage=true
      visible=1
    }
    //image_index+=0.25
    image_index+=0.25*gDeltaTime
    if image_index>=7.2 {atkProg=200}
  }
  else if atkProg=201 {image_index=1; bCanDealDamage=false}
  else if atkProg=205 {image_index=0}
  //else if atkProg=208 {instance_destroy()}
  else if atkProg>=208 {instance_destroy()} //60fps change: >=, so it still goes if the frame rate changed mid-count
}
