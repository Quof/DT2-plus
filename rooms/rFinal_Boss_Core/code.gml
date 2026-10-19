background_hspeed[0]=-0.5
background_vspeed[0]=0.5

if global.gameProgress<29
  global.gameProgress=29

//score check
if global.currentScore>global.lvlScore[15]
  global.lvlScore[15]=global.currentScore
global.currentScore=0

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

if global.bossTrack=1
{
  oPlayer1.x=192
  oPlayer1.y=480
  boss=instance_create(384,256,oVirusCore)
  boss.activateBoss=1
  barrier1=instance_create(144,384,oBossBarrier)
  barrier2=instance_create(608,384,oBossBarrier)
}

if global.gameProgress>=31
{
  rightDoor=instance_create(680,416,oExit)
  rightDoor.sprite_index=sKirbyDoorway
  rightDoor.bShowArrow=true
  rightDoor.exitType=0
  rightDoor.newMapX=0
  rightDoor.newMapY=0
  rightDoor.toRoom=rFinal_EscapeA
}

stopAllMusic()
var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
