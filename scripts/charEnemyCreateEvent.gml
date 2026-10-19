/*
This script should be placed in the "Create Event" of the character and enemies.
It sets the default values needed for them.
Characters will set their own values for these parameters in their create event after this is set.
*/

if parent!="trap" and parent!="projectile"
{
  maxLife=1           //character's max health
  life=maxLife        //character's current health
  lifePercent=1       //character's health percent
  atkDefense=0        //general defense against attacks
}
atkPower=0            //base attack power

if bPlayable=false //whether the character is playable
{
  if parent!="trap" and parent!="projectile"
  {
    FIREresist=0
    WATERresist=0
    WINDresist=0
    EARTHresist=0
    eName=""                    //enemy name
    baseItemChance=-100         //chance the enemy will drop an item
    pointWorth=0                //the amount of exp awarded when the player kills the enemy
    bNoBonus=false              //whether the enemy gives a bonus
    baseColor=c_white           //color used for sprite shading
    flashTime=2                 //how long the enemy flashes red when taking damage
    stunnedTime=0               //how long the enemy is stunned
    hitSound=global.snd_EnemyHit  //sound effect played when enemy is hit
    dieSound=global.snd_EnemyDie  //sound effect played when enemy is killed
    dieEffect=0                 //effect shown when enemy dies
    effectXscale=1              //effect x scale
    effectYscale=1              //effect y scale
    dieFade=0                   //fade after death, use only if dieEffect is 0
    effectSpeed=0.9             //effect image speed
    bShowHealthBar=false        //show the enemy health bar
    bIsBoss=false               //relates to effects shown and health meter
    questType=0                 //which quest the enemy is related to. 0 is standard enemy
    scanText=""                 //Chao's info on the enemy
    jeremyText=""               //Jeremy's info on the enemy
    skillResist=0               //resist% against all skill attacks. 100=full resist
  }
  damageType="PHYSICAL"       //the type of damage the enemy deals
  elementType=0               //elemental damage the enemy deals
  bCanDealDamage=true         //whether the enemy can cause damage to the player
  bCauseKnockback=true        //will cause the character to knock back after taking damage from the enemy
  bActive=false               //whether or not the enemy will attack the player
  findTargetX=0               //how close the enemy is to the player
  findTargetY=0               //how close the enemy is to the player
  detectDistX=280             //how close the player has to be to the enemy before it becomes active
  detectDistY=224             //how close the player has to be to the enemy before it becomes active
  bInflictPoison=false        //if poison is inflicted when the player is hit by it
  bInflictSpiritDrain=false   //if spirit drain is inflicted when the player is hit by it
  bInflictSkillLock=false     //if skill lock is inflicted when the player is hit by it
  inactiveDist=detectDistX*3  //how far till the enemy becomes inactive
}
else
{
  spiritPercent=1
  firePercent=1
  waterPercent=1
  windPercent=1
  earthPercent=1
  bCanTakeHit=true     //whether the character can take damage, this is used after the character is hit
  flashTime=30         //how long the character is invulverable after taking damage
  bRaveActive=false    //whether in Rave Mode
  statusSpiritDrain=0
  statusSkillLock=0
}

if parent!="trap" and parent!="projectile"
{
  statusCripple=0        //-40% defense
  statusPoison=0         //-1 life every other frame (15 per second)
  weight=10000           //wind/gravity effects
  bShowDamage=true       //show damage dealt
  damageTime=0           //current time till the character can take damage again
}
bTakingDamage=false    //if the character is currently taking damage
bCanTakeDamage=true    //whether the character can take damage
