/*
This script is used to stop any sounds that might still be looping.
*/
SS_StopSound(global.snd_PlayerAtk[0])
SS_StopSound(global.snd_PlayerAtk[1])
SS_StopSound(global.snd_PlayerAtk[2])
SS_StopSound(global.snd_PlayerStrAtk[0])
SS_StopSound(global.snd_PlayerStrAtk[1])
SS_StopSound(global.snd_PlayerJump[0])
SS_StopSound(global.snd_PlayerDamaged[0])
SS_StopSound(global.snd_JumpStrike)

SS_StopSound(global.snd_SpellFireball)
SS_StopSound(global.snd_SpellWaterBlast)
SS_StopSound(global.snd_BarrierDestroy)
SS_StopSound(global.snd_SpellWindStorm)
SS_StopSound(global.snd_WindGust)
SS_StopSound(global.snd_BoulderHit)

for(i=0;i<9;i+=1)
{
  SS_StopSound(global.snd_killChain[i])
}

for(i=0;i<10;i+=1)
{
  SS_StopSound(global.snd_killingSpree[i])
}

SS_StopSound(global.snd_ShipShot)

SS_StopSound(global.snd_EnemyHit)
SS_StopSound(global.snd_EnemyHit)
SS_StopSound(global.snd_CASgun)
SS_StopSound(global.snd_GASlaunch)
SS_StopSound(global.snd_CASdie)
SS_StopSound(global.snd_RockThrow)
SS_StopSound(global.snd_Teleport)
SS_StopSound(global.snd_BreakOut)
SS_StopSound(global.snd_BulletBillShot)
SS_StopSound(global.snd_Shock)

SS_StopSound(global.snd_MoneyPickup)
SS_StopSound(global.snd_HealthPickup)
SS_StopSound(global.snd_HealingPlant)
SS_StopSound(global.snd_SkillCapsule)
SS_StopSound(global.snd_HeartPiece)
SS_StopSound(global.snd_DoorUnlock)
SS_StopSound(global.snd_LevelUp)
SS_StopSound(global.snd_ChestOpen)
SS_StopSound(global.snd_WarningSiren)
SS_StopSound(global.snd_SwitchHit)
SS_StopSound(global.snd_WorldPortal)
SS_StopSound(global.snd_Earthquake)
SS_StopSound(global.snd_MarioCoin)
SS_StopSound(global.snd_RBSwitch)
SS_StopSound(global.snd_GameOver)
SS_StopSound(global.snd_Clang)
SS_StopSound(global.snd_Static)

SS_StopSound(global.snd_PressStart)
SS_StopSound(global.snd_MenuOpen)
SS_StopSound(global.snd_MenuClose)
SS_StopSound(global.snd_MenuCursor)
SS_StopSound(global.snd_MenuConfirm)
SS_StopSound(global.snd_MenuCancel)
SS_StopSound(global.snd_MenuShift)
SS_StopSound(global.snd_Continue)
SS_StopSound(global.snd_InfoOn)
SS_StopSound(global.snd_InfoOff)
SS_StopSound(global.snd_DataScan)
SS_StopSound(global.snd_ScanComplete)
SS_StopSound(global.snd_MapBlip)
