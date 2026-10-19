/*
This is called after a boss fight.
It is used to clear any effects still on screen
and to set the player back to the normal state.
*/
with oEnemyBase
  instance_destroy()
with oEProjectileBase
  instance_destroy()
with oBossBarrier
  instance_destroy()
with oAttackBase
  instance_destroy()
stopPlayer()
oPlayer1.image_alpha=1
oPlayer1.sprite_index=sPlayerIdle

oPlayer1.life=global.p1Life
oPlayer1.fireEnergy=global.p1MaxFireEnergy
oPlayer1.waterEnergy=global.p1MaxWaterEnergy
oPlayer1.windEnergy=global.p1MaxWindEnergy
oPlayer1.earthEnergy=global.p1MaxEarthEnergy
