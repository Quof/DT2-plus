//This script allows the player to dash forward

playSound(global.snd_PlayerJump[0],0,1)
effect=instance_create(oPlayer1.x,oPlayer1.y+2,oEffect)
effect.sprite_index=sSpellCast
effect.image_xscale=0.6
effect.image_yscale=0.6
dashInvulnerabilityTime+=dashInvulnerability
dashPoints-=1
//yAcc+=initialJumpAcc/2
//60fps change: above 30fps the hop is a starting speed. Simulating the 30fps and 60/120fps hops with DT2's values, the
//plain half jump speed matches 30fps's heights and air times (a hair less at 60fps) without the jump's corrections
if gDeltaTime==1
  yAcc+=initialJumpAcc/2
else
  yVel=initialJumpAcc/2+grav*0.08*(gDeltaTime-0.25)
xAcc+=xVel
dashMomentumTime=24
//the "state" gets changed to JUMPING later on in the code
state=FALLING
xVelSetTick=1 //60fps change (added): velocity set + one-off push: pMoveToWrapNew uses the 30fps formula for this frame
if facing=RIGHT
{
  xVel=dashVel
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sDashWave
}
else
{
  xVel=-dashVel
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sDashWave
  effect.image_xscale=-1
}

//"variable jumping" states
jumpButtonReleased=0
jumpTime=0

//60fps change (added): above 30fps the rest of this 30fps tick skips the run code (characterStepEvent), like the 30fps
//dash that set the whole tick
dashTickTime=1; dashTickXAcc=xAcc
