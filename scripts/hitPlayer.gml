/*
This script is used when the player takes damage.
*/
if bCanTakeHit=true and bCanTakeDamage=true and dashInvulnerabilityTime=0
{
  if global.debugInvincible=false
  {
    //inflict status effect
    if other.bInflictPoison=true
      inflictStatus(1)
    if other.bInflictSpiritDrain=true
      inflictStatus(2)
    if other.bInflictSkillLock=true
      inflictStatus(3)

    //Chao emotes
    if oIdentifier.emoteType=0
    {
      var emRan;
      emRan=random(10)
      if emRan>7
      {
        oIdentifier.emoteType=oIdentifier.EM_MAD
      }
    }

    //Player hit indicator
    if instance_exists(oHitWarn)
    {
      with oHitWarn {instance_destroy()}
    }
    var tHitWarn;
    tHitWarn=instance_create(0,0,oHitWarn)
    tHitWarn.image_blend=c_red
    //calculate damage
    takeDamage()
  }
}
