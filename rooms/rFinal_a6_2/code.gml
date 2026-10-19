tile_layer_delete(1000001)
if global.gameProgress<22
  global.gameProgress=22

levelEvent=instance_create(0,0,oEvW5)
levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
