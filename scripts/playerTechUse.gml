/*
This script is called inside the character step event.
It is used when the player uses a technique.
argument0: Which element is used
1: Fire
2: Water
3: Wind
4: Earth
*/

if argument0=1 and attackState=0 and fireEnergy>=3 and global.canUseFire=1 //============================== FIRE ==============================
{
  elementCast=1
  if kUp and platformCharacterIs(IN_AIR) and blastOffRecoveryTime=0
  {
    spellCasting="BLAST OFF"
    playSound(global.snd_SpellFireball,0,1)
    blastOffRecoveryTime=40
    playerAttack=instance_create(x,y,oBlastOff)
    if fireEnergy>=13 {fireEnergy-=2}
    else {fireEnergy-=3}
    endSpellUse()
  }
  else
  {
    stopPlayer()
    spellCasting="FIREBALL"
    playSound(global.snd_SpellFireball,0,1)
    playerAttack=instance_create(x,y,oSpell)
    if fireEnergy>=13 {fireEnergy-=2}
    else {fireEnergy-=3}
    endSpellUse()
  }
}
else if argument0=2 and attackState=0 and waterEnergy>=3 and global.canUseWater=1 //============================== WATER ==============================
{
  elementCast=2
  if kRight or kLeft
  {
    stopPlayer()
    spellCasting="FLOOD"
    playSound(global.snd_SpellWaterBlast,0,1)
    playerAttack=instance_create(x,y,oSpell)
    if waterEnergy>=13 {waterEnergy-=2}
    else {waterEnergy-=3}
    endSpellUse()
  }
  else
  {
    stopPlayer()
    spellCasting="WATER BLAST"
    playSound(global.snd_SpellWaterBlast,0,1)
    playerAttack=instance_create(x,y+16,oSpell)
    if waterEnergy>=13 {waterEnergy-=2}
    else {waterEnergy-=3}
    endSpellUse()
  }
}
else if argument0=3 and attackState=0 and windEnergy>=3 and global.canUseWind=1 //============================== WIND ==============================
{
  elementCast=3
  stopPlayer()
  spellCasting="WIND BURST"
  playSound(global.snd_SpellWindStorm,0,1)
  playerAttack=instance_create(x,y,oSpell)
  playerAttack.xSpd=4
  playerAttack=instance_create(x,y,oSpell)
  playerAttack.xSpd=-4
  if windEnergy>=13 {windEnergy-=2}
  else {windEnergy-=3}
  endSpellUse()
}
else if argument0=4 and attackState=0 and earthEnergy>=3 and global.canUseEarth=1 //============================== EARTH ==============================
{
  elementCast=4
  if kDown and platformCharacterIs(IN_AIR)
  {
    playSound(global.snd_RockThrow,0,0.95)
    slowFallTime=0
    attackState=TECH_EARTH_SLAM
    if earthEnergy>=13 {earthEnergy-=2}
    else {earthEnergy-=3}
  }
  else
  {
    stopPlayer()
    spellCasting="ROCK SMASH"
    playSound(global.snd_PlayerAtk[2],0,1)
    playerAttack=instance_create(x,y,oSpell)
    if earthEnergy>=13 {earthEnergy-=2}
    else {earthEnergy-=3}
    endSpellUse()
  }
}

if room=rFinal_EscapeA
{
  if argument0=1 and attackState=0 and global.canUseFire=0
  {
    oHorrorVirus.buttonAttempt+=1
  }
  else if argument0=2 and attackState=0 and global.canUseWater=0
  {
    oHorrorVirus.buttonAttempt+=1
  }
  else if argument0=3 and attackState=0 and global.canUseWind=0
  {
    oHorrorVirus.buttonAttempt+=1
  }
  else if argument0=4 and attackState=0 and global.canUseEarth=0
  {
    oHorrorVirus.buttonAttempt+=1
  }
}
