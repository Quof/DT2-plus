backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=2
backFollowFore.backSet=backStars
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.6
backFollowFore.depth=1499999
backFollowFore.bgAlpha=0.2

background_hspeed[0]=-2
background_vspeed[0]=0.5
background_alpha[0]=0.2
background_xscale[0]=2
background_yscale[0]=2
background_hspeed[1]=-1

levelEvent=instance_create(0,0,oEvW4)

colorControl=instance_create(0,0,oColorIndControl)
colorControl.warnDelay=160

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
