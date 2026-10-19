#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bShowHealthBar=true
barAmount=2

oGlobalEvent.enemyCount=2
eName="Twin Bloom"
maxLife=900
life=maxLife
lifePercent=1
bossProgress=0

fireBloom=instance_create(160,304,oFireBloom)
waterBloom=instance_create(544,304,oWaterBloom)

showBossHP=instance_create(0,0,oBossLifeDisplay)
showBossHP.bossID=id
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  life=0
  if instance_exists(fireBloom)
    life+=fireBloom.life
  if instance_exists(waterBloom)
    life+=waterBloom.life
  life-=1100

  lifePercent=life/maxLife

  //FIRE: seedBurstDelay=90, seedBurstAmt=20, seedBurstSpd=3, teleportDelay=215, hyperBeamDelay=1110
  //WATER: seedBurstDelay=110, seedBurstAmt=20, seedBurstSpd=4, teleportDelay=230, hyperBeamDelay=1360

  //scale difficulty
  if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
  {
    fireBloom.seedBurstDelay-=10
    fireBloom.seedBurstAmt+=3
    fireBloom.seedBurstSpd-=1
    fireBloom.teleportDelay-=5
    fireBloom.hyperBeamDelay-=20

    waterBloom.seedBurstDelay-=20
    waterBloom.seedBurstAmt+=3
    waterBloom.seedBurstSpd-=1
    waterBloom.teleportDelay-=5
    waterBloom.hyperBeamDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
  {
    fireBloom.seedBurstDelay-=20
    fireBloom.seedBurstAmt+=4
    fireBloom.seedBurstSpd-=2
    fireBloom.hideThreshold-=1
    fireBloom.teleportDelay-=10
    fireBloom.hyperBeamDelay-=20

    waterBloom.seedBurstDelay-=10
    waterBloom.seedBurstAmt+=4
    waterBloom.seedBurstSpd-=2
    waterBloom.hideThreshold-=1
    waterBloom.hyperBeamDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
  {
    fireBloom.seedBurstDelay-=10
    fireBloom.seedBurstAmt+=4
    fireBloom.seedBurstSpd-=2
    fireBloom.hideThreshold-=1
    fireBloom.teleportDelay-=5
    fireBloom.hyperBeamDelay-=20

    waterBloom.seedBurstDelay-=20
    waterBloom.seedBurstAmt+=4
    waterBloom.seedBurstSpd-=1
    waterBloom.hideThreshold-=1
    waterBloom.teleportDelay-=5
    waterBloom.hyperBeamDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.2 and bossProgress=3
  {
    fireBloom.seedBurstDelay-=20
    fireBloom.seedBurstAmt+=3
    fireBloom.seedBurstSpd-=1
    fireBloom.teleportDelay-=5
    fireBloom.hyperBeamDelay-=30

    waterBloom.seedBurstDelay-=10
    waterBloom.seedBurstAmt+=3
    waterBloom.seedBurstSpd-=1
    waterBloom.hyperBeamDelay-=10
    bossProgress+=1
  }

  if life<=0
    oGlobalEvent.enemyCount=0
}
