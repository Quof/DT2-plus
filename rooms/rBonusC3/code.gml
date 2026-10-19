levelEvent=instance_create(0,0,oEvBonusChallenge)
//instance id fix (added): the spikes on top of the two Tetris blocks are made before the blocks, so they get the block
//they follow here, once all of the room's instances are made (GID; their creation code keeps its original id)
with oStaticSpike {if variable_local_exists("idFollowGID") {idFollow=GID(idFollowGID)}}

var tempMplay;
tempMplay=findMusic()
playMusic(tempMplay,0)
