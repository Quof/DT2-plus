/*
This script is called to end spell use.
*/
idleTime=0
var tEffect;
tEffect=instance_create(oPlayer1.x,oPlayer1.y+4,oEffect)
tEffect.sprite_index=sSpellCast
attackState=ACT_CASTED
castRecovering=castRecoveryTime
