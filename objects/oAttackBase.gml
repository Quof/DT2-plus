#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCanDealDamage=true
currentSpell="NONE"
damageType="PHYSICAL"
skillPower=0
jumpSlashPower=0
elementType=0
attackType=0

maxAtkId=0
atkId=0
atkIdTime=0

HURRICANE_DASH=37
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  for(i=0;i<maxAtkId;i+=1)
  {
    if atkId[i]!=0
    {
      //atkIdTime[i]+=1
      atkIdTime[i]+=1*gDeltaTime //60fps change: counts 30fps ticks (the same enemy could be hit again 2x/4x as soon)
      if atkIdTime[i]>=15
        atkId[i]=0
    }
  }
}
