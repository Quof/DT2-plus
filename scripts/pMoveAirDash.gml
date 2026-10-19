//This script allows the player to air dash

canAirDash=0
//global.recAirDashed+=1
if facing=RIGHT
{
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sAirDashWave
}
else
{
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sAirDashWave
  effect.image_xscale=-1
}
//jumpSound=round(random(1)) //player jump sound
dashMomentumTime=18
playSound(global.snd_PlayerJump[0],0,1)
dashInvulnerabilityTime+=dashInvulnerability
dashPoints-=1
//yAcc+=initialJumpAcc/2
if gDeltaTime==1 {yAcc+=initialJumpAcc/2}
else {airDashKick=initialJumpAcc/2} //60fps change: above 30fps applied for the dash's whole first tick in characterStepEvent (airDashRecovery block)
//xAcc+=xVel
//xVel=dashVel
if airDashRecovery<7
  airDashRecovery=6
dashTickTime=1; dashTickXAcc=xAcc //60fps change (added): see pMoveDashForward; the dash's first tick keeps this frame's acceleration
