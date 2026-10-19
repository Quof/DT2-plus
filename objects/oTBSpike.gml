#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.1
image_yscale=0.1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

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
  atkProg+=1*gDeltaTime //60fps change: counts 30fps ticks (on the last frame of each tick it's that tick's number)
  //if atkProg>=1 and atkProg<=9
  if atkProg>0 and atkProg<=9 //60fps change: every frame of ticks 1-9, so it grows by the same amount as at 30fps (the same at 30fps)
  {
    //image_xscale+=0.1
    image_xscale+=0.1*gDeltaTime //60fps change: per 30fps tick
    //image_yscale+=0.1
    image_yscale+=0.1*gDeltaTime //60fps change: per 30fps tick
  }
  //else if atkProg>=15 and atkProg<=23
  else if atkProg>14 and atkProg<=23 //60fps change: every frame of ticks 15-23 (the same at 30fps)
  {
    //image_xscale-=0.1
    image_xscale-=0.1*gDeltaTime //60fps change: per 30fps tick
    //image_yscale-=0.1
    image_yscale-=0.1*gDeltaTime //60fps change: per 30fps tick
  }
  //else if atkProg>=24
  else if atkProg>23 //60fps change: from the first frame of tick 24 (the same at 30fps)
    instance_destroy()
}
