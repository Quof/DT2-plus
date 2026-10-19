/*
This script is called to stop the player's momentum.
It is best used for cutscenes.
*/
with oPlayerAfterImage
  instance_destroy()
oPlayer1.kLeft=0
oPlayer1.kRight=0
oPlayer1.kUp=0
oPlayer1.kDown=0
oPlayer1.kJump=0
oPlayer1.kJumpPressed=0
oPlayer1.kRun=0
oPlayer1.kAttack=0
oPlayer1.kAttackPressed=0
oPlayer1.kElementSwapForward=0
oPlayer1.kElementSwapForwardPressed=0
oPlayer1.kElementSwapBack=0
oPlayer1.kElementSwapBackPressed=0
oPlayer1.kTechUse=0
oPlayer1.kTechUsePressed=0
oPlayer1.kSpellUse=0
oPlayer1.kSpellUsePressed=0
oPlayer1.image_speed=0.1
