oPlayer1.x=256
oPlayer1.y=321
global.gamePaused=false
global.showHUD=true
bLoaded=false
if global.resetMusic=true
{
  var tempMplay;
  tempMplay=findMusic()
  playMusic(tempMplay,0)

  global.resetMusic=false
  bLoaded=true
}
dataScatter=instance_create(0,0,oDataCenter)
if bLoaded=true
  dataScatter.init=1
