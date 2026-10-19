if global.gameProgress<28
  global.gameProgress=28

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
