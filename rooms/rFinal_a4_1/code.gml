backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backIntermediaryCaves
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999
backFollowFore.image_xscale=1.6
backFollowFore.image_yscale=1.6

if global.gameProgress<15
  global.gameProgress=15

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
