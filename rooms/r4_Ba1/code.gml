background_hspeed[0]=-2
background_vspeed[0]=1

if global.bossTrack=1
{
  boss=instance_create(336,337,oHarpuia)
  boss.activateBoss=1
}

levelEvent=instance_create(0,0,oEvW4)

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
