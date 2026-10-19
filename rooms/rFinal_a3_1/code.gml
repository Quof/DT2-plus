if global.gameProgress<12
  global.gameProgress=12

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
