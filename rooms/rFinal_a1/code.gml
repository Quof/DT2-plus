global.saveOnAuto=1
global.currentScore=0
levelEvent=instance_create(0,0,oEvW5)

if global.gameProgress>=25
{
  fleetDoor=instance_create(248,320,oExit)
  fleetDoor.sprite_index=sKirbyDoorway
  fleetDoor.bShowArrow=true
  fleetDoor.exitType=0
  fleetDoor.newMapX=0
  fleetDoor.newMapY=0
  fleetDoor.toRoom=rFinal_aFleetA
}
if global.gameProgress>=29
{
  fleetDoor=instance_create(448,320,oExit)
  fleetDoor.sprite_index=sKirbyDoorway
  fleetDoor.bShowArrow=true
  fleetDoor.exitType=0
  fleetDoor.newMapX=0
  fleetDoor.newMapY=0
  fleetDoor.toRoom=rFinal_Boss_Core
}

stopAllMusic()
var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
