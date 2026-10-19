if global.gameProgress<26
  global.gameProgress=26

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

stopAllMusic()
var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
