//This script allows the player to dash back

playSound(global.snd_PlayerJump[0],0,1)
effect=instance_create(oPlayer1.x,oPlayer1.y+2,oEffect)
effect.sprite_index=sSpellCast
effect.image_xscale=0.6
effect.image_yscale=0.6
dashInvulnerabilityTime+=dashInvulnerability
dashPoints-=1
//yAcc+=initialJumpAcc/2
//60fps change: see pMoveDashForward
if gDeltaTime==1
  yAcc+=initialJumpAcc/2
else
  yVel=initialJumpAcc/2+grav*0.08*(gDeltaTime-0.25)
xAcc+=xVel
dashMomentumTime=24
backDashRec=8
//the "state" gets changed to JUMPING later on in the code
state=FALLING
xVelSetTick=1 //60fps change (added): see pMoveDashForward
if facing=RIGHT
{
  xVel=-dashVel
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sDashWave
  effect.image_xscale=-1
}
else
{
  xVel=dashVel
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sDashWave
}

//"variable jumping" states
jumpButtonReleased=0
jumpTime=0

//60fps change (added): see pMoveDashForward (holding forward during a back dash turned it around early without this)
dashTickTime=1; dashTickXAcc=xAcc
