global.gamePaused=false
if global.gameProgress<23
  global.gameProgress=23

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
