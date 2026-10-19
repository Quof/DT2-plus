//Starting 1-3
backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backIntermediaryWoods
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=1
backFollowFore.depth=1499999
backFollowFore.image_yscale=2.4

levelEvent=instance_create(0,0,oEvAddedScenes)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
