backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backStars
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.6
backFollowFore.depth=1499999

if global.gameProgress<11
  global.gameProgress=11

levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
