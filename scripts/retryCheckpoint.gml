/*
This script is called when the level is restarted from a checkpoint.
*/
stopLoopingSounds()
global.p1Life=global.p1MaxLife

global.p1FireEnergy=global.p1MaxFireEnergy
global.p1WaterEnergy=global.p1MaxWaterEnergy
global.p1WindEnergy=global.p1MaxWindEnergy
global.p1EarthEnergy=global.p1MaxEarthEnergy

global.killingSpree=0
global.consecCry=0

global.levelTimeFrameCount=0
if global.lvlCurrent="Final" {global.recordScore-=10}
else {global.recordScore-=100}

if global.recordScore<0 {global.recordScore=0}

if global.bossTrack=0 {global.recordTime+=30}
