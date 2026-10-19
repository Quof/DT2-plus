//This script allows the player to wall jump
//argument0: 0: left, 1: right

var tWallCheck;
tWallCheck=argument0

jumpTime=0
jumpButtonReleased=0
kRight=0
kRightReleased=1
kLeft=0
kLeftReleased=1

playSound(global.snd_PlayerJump[0],0,1)

yAcc+=initialJumpAcc
yVel=-0.05
//60fps change (added): the 30fps kick at every frame rate, with yVelSetTick/xVelSetTick so pMoveToWrapNew uses the 30fps
//formula (velocity + acceleration) * friction for this frame (as in DT3+, where it came within ~1px of 30fps)
yVelSetTick=1
xVelSetTick=1

clingTime=0
bSticking=0

//walljumpTime=2

scrSlowFall(5,0.5)
canAirDash=1

if tWallCheck=0
{
  xVel=-6
  xAcc-=4
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sAirDashWave
  effect.image_xscale=-0.75; effect.image_yscale=0.75;
}
else
{
  xVel=6
  xAcc+=4
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sAirDashWave
  effect.image_xscale=0.75; effect.image_yscale=0.75;
}
