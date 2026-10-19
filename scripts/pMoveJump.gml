//This script allows the player to jump

playSound(global.snd_PlayerJump[jumpSound],0,1)
//yAcc+=initialJumpAcc
//60fps change: above 30fps the jump is a starting speed, corrected so the heights match 30fps (jumpBodge60/jumpGravComp60,
//set in characterCreateEvent: the jump's acceleration is spread over each frame above 30fps, and the pixel rounding
//differs). Simulating this engine's 30fps and 60/120fps jumps with DT2's gravity and jump values, the same corrections
//as DT3+'s (1.07 and 0.5) match: a full jump is 83 (60fps) / 84 (120fps) pixels high where 30fps's are 81-85, and every
//shorter jump (letting go early) lands within 30fps's range too
if gDeltaTime==1
  yAcc+=initialJumpAcc
else
{
  yVel+=initialJumpAcc*jumpBodge60
  //uses grav, not gravityIntensity: gravityIntensity is still last frame's value here (DT3+)
  yVel+=grav*jumpGravComp60
}
ditherCounter=15 //60fps change (added): make jumps deterministic (above 30fps the pixel rounding always starts the same way)
xAcc+=xVel/2
xVelSetTick=1 //60fps change (added): one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
effect=instance_create(oPlayer1.x,oPlayer1.y+2,oEffect)
effect.sprite_index=sSpellCast
effect.image_xscale=0.6
effect.image_yscale=0.6

//the "state" gets changed to JUMPING later on in the code
state=FALLING
//"variable jumping" states
jumpButtonReleased=0
jumpTime=0
