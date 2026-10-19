#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fireTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //fireTime+=1
  if fireTime=0 {fireTime=1-gDeltaTime} //60fps change (added): so fireTime is 1 on the first frame, like at 30fps
  fireTime+=1*gDeltaTime //60fps change: counts 30fps ticks
  if fireTime=1
  {
    explosion=instance_create(x,y,oDamageExplosion)
    explosion.sprite_index=sSkellyBatFireB
    explosion.image_speed=0.2
    explosion.atkPower=atkPower
    explosion.decayTime=-100
  }
  else if fireTime=7
  {
    var tDist;
    tDist=16
    for(i=0;i<2;i+=1)
    {
      if i=1 {tDist*=-1}
      explosion=instance_create(x+tDist,y,oDamageExplosion)
      explosion.sprite_index=sSkellyBatFireB
      explosion.image_speed=0.2
      explosion.atkPower=atkPower
      explosion.decayTime=-100
    }
  }
  else if fireTime=13
  {
    var tDist;
    tDist=32
    for(i=0;i<2;i+=1)
    {
      if i=1 {tDist*=-1}
      explosion=instance_create(x+tDist,y,oDamageExplosion)
      explosion.sprite_index=sSkellyBatFireB
      explosion.image_speed=0.2
      explosion.atkPower=atkPower
      explosion.decayTime=-100
    }
    instance_destroy()
  }
}
