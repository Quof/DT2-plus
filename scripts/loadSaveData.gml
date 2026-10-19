/*
This script is used to load in saved data from "GameDetails.ini".
argument0:  0: Load from Title Screen
            1: Load from Game Over Screen
*/

ini_open("DT2save.dts")
if argument0=0
{
  if fileCursorPos=1
    sectionRead="ALPHA"
  else if fileCursorPos=2
    sectionRead="BETA"
}
else if argument0=1
{
  if global.currentQuestLog=1
    sectionRead="ALPHA"
  else if global.currentQuestLog=2
    sectionRead="BETA"
}

global.playTimeHour=ini_read_real(sectionRead,"101",0)
global.playTimeMinute=ini_read_real(sectionRead,"102",0)
global.playTimeSecond=ini_read_real(sectionRead,"103",0)
global.gamePercent=ini_read_real(sectionRead,"104",0)
global.gameProgress=ini_read_real(sectionRead,"105",0)
global.p1KillCount=ini_read_real(sectionRead,"106",0)
global.deathCount=ini_read_real(sectionRead,"107",0)
global.gameRank=ini_read_real(sectionRead,"108",0)
global.storyProgress=ini_read_real(sectionRead,"109",0)

global.optLowHealthWarn=ini_read_real(sectionRead,"201",1)
global.optShowPointsEarned=ini_read_real(sectionRead,"202",1)
global.optShowDamage=ini_read_real(sectionRead,"203",1)
global.optMusic=ini_read_real(sectionRead,"204",1)
global.optSound=ini_read_real(sectionRead,"205",1)
global.optFairy=ini_read_real(sectionRead,"206",1)
global.optEnemyHP=ini_read_real(sectionRead,"207",1)
global.optAutoSave=ini_read_real(sectionRead,"208",1)
global.optKillChainScreen=ini_read_real(sectionRead,"209",1)
global.optKillChainSound=ini_read_real(sectionRead,"210",1)
global.optKillingSpreeScreen=ini_read_real(sectionRead,"211",1)
global.optKillingSpreeSound=ini_read_real(sectionRead,"212",1)
//global.optDPadDash=ini_read_real(sectionRead,"213",1)
global.optDPadDash=ini_read_real(sectionRead,"213",0) //options change: off by default
global.optRightIsForward=ini_read_real(sectionRead,"214",1)
global.optShowHUD=ini_read_real(sectionRead,"215",1)

global.ctrlUp=ini_read_string(sectionRead,"301","W")
global.ctrlDown=ini_read_string(sectionRead,"302","S")
global.ctrlLeft=ini_read_string(sectionRead,"303","A")
global.ctrlRight=ini_read_string(sectionRead,"304","D")
global.ctrlJump=ini_read_string(sectionRead,"305","J")
global.ctrlFire=ini_read_string(sectionRead,"306","K")
global.ctrlWater=ini_read_string(sectionRead,"307","L")
global.ctrlWind=ini_read_string(sectionRead,"308","I")
global.ctrlEarth=ini_read_string(sectionRead,"309","O")
global.ctrlDashLeft=ini_read_string(sectionRead,"310","Q")
global.ctrlDashRight=ini_read_string(sectionRead,"311","E")

for(i=0;i<global.maxLevels;i+=1)
{
  global.lvlComplete[i]=ini_read_real(sectionRead,string("r1") +string(i),0); global.lvlComplete[i]=encryptDecrypt(global.lvlComplete[i],1)
  global.lvlCrystal[i]=ini_read_real(sectionRead,string("r2") +string(i),0); global.lvlCrystal[i]=encryptDecrypt(global.lvlCrystal[i],1)
  global.lvlTime[i]=ini_read_real(sectionRead,string("r3") +string(i),0); global.lvlTime[i]=encryptDecrypt(global.lvlTime[i],1)
  global.lvlScore[i]=ini_read_real(sectionRead,string("r4") +string(i),0); global.lvlScore[i]=encryptDecrypt(global.lvlScore[i],1)
}

for(i=0;i<4;i+=1)
{
  global.challScore[i]=ini_read_real(sectionRead,string("ch1") +string(i),0); global.challScore[i]=encryptDecrypt(global.challScore[i],1)
}

global.saveFile_TimeFix=ini_read_real(sectionRead,"400tf",0)
if global.saveFile_TimeFix=0
{
  for(i=0;i<global.maxLevels;i+=1)
  {
    global.lvlTime[i]*=30
  }
  for(i=0;i<4;i+=1)
  {
    global.challScore[i]*=30
  }
  global.saveFile_TimeFix=1
}

ini_close()
