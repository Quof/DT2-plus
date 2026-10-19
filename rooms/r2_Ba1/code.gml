global.currentBoss="TWSG"
boss=instance_create(320,80,oGChainCon)

levelEvent=instance_create(0,0,oEvW2)
instance_create(0,0,oBlackFadeDown)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
