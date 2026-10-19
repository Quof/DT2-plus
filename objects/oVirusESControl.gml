#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
rockSpawn=0
xSpawn1=64
xSpawn2=720
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //rockSpawn+=1
  rockSpawn+=1*gDeltaTime //60fps change: counts 30fps ticks ("mod 5=0" only lands on whole numbers)
  if rockSpawn mod 5=0
  {
    if instance_exists(oVirusCore)
    {
      var newAttack;
      newAttack=instance_create(xSpawn1,oVirusCore.yGround,oVirusEarthSpike)
      newAttack.atkPower=oVirusCore.atkPower
      newAttack.yVel=-12
      newAttack=instance_create(xSpawn2,oVirusCore.yGround,oVirusEarthSpike)
      newAttack.atkPower=oVirusCore.atkPower
      newAttack.yVel=-12

      xSpawn1+=56
      xSpawn2-=56
    }
    else
      instance_destroy()
  }

  if xSpawn1>=650
    instance_destroy()
}
