backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=1
backFollowFore.backSet=backSandstorm
backFollowFore.xScrollSpeed=-25
backFollowFore.yScrollSpeed=0.4
backFollowFore.depth=10
backFollowFore.image_xscale=2
backFollowFore.image_yscale=2
backFollowFore.bgAlpha=0.25

levelEvent=instance_create(0,0,oEvW3)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
