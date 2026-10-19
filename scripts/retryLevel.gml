/*
This script is called when the level is restarted.
Also used to reset everything.
*/
stopLoopingSounds()
global.p1Life=global.p1MaxLife

global.p1FireEnergy=global.p1MaxFireEnergy
global.p1WaterEnergy=global.p1MaxWaterEnergy
global.p1WindEnergy=global.p1MaxWindEnergy
global.p1EarthEnergy=global.p1MaxEarthEnergy

global.recordScore=0
global.recordTime=0

global.currentScore=0
global.killingSpree=0
global.consecCry=0

global.levelTimeSecond=0
global.levelTimeFrameCount=0
global.currentCrystals=0
global.consecCry=0
global.currentScore=0
for(i=0;i<5;i+=1)
  global.crystalNum[i]=0
global.hitsTaken=0
