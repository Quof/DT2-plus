backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=3
backFollowFore.backSet=backMMSewers
backFollowFore.xMoveScale=0.6
backFollowFore.yMoveScale=0.6
backFollowFore.depth=1499999
backFollowFore.image_xscale=1.5
backFollowFore.image_yscale=1.5
backFollowFore.xAdjust=0
backFollowFore.yAdjust=128

background_hspeed[1]=-25
background_vspeed[1]=0.4
background_xscale[1]=2
background_yscale[1]=2
background_alpha[1]=0.25

if global.gameProgress<16
  global.gameProgress=16

levelEvent=instance_create(0,0,oEvW5Convo)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
