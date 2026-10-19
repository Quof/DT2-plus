/*
Save script.
This will save the game data in DT2save.ini
*/
playSound(global.snd_MenuConfirm,0,1)
bSaving=1
saveProgress=0
stringToShow="Saving, please wait a second..."
messageWidth=string_width(stringToShow)
newMessage=instance_create(256-(messageWidth/2),128,oMessageSign)
newMessage.message=stringToShow
newMessage.fadingTime=45
screen_redraw()
ini_open("DT2save.dts")
var sectionWrite,tempVar;
if global.currentQuestLog=1
  sectionWrite="ALPHA"
else if global.currentQuestLog=2
  sectionWrite="BETA"

ini_write_real(sectionWrite,"101",global.playTimeHour)
ini_write_real(sectionWrite,"102",global.playTimeMinute)
ini_write_real(sectionWrite,"103",global.playTimeSecond)
ini_write_real(sectionWrite,"104",global.gamePercent)
ini_write_real(sectionWrite,"105",global.gameProgress)
ini_write_real(sectionWrite,"106",global.p1KillCount)
ini_write_real(sectionWrite,"107",global.deathCount)
ini_write_real(sectionWrite,"108",global.gameRank)
ini_write_real(sectionWrite,"109",global.storyProgress)
//saveProgress=25
//screen_redraw()

ini_write_real(sectionWrite,"201",global.optLowHealthWarn)
ini_write_real(sectionWrite,"202",global.optShowPointsEarned)
ini_write_real(sectionWrite,"203",global.optShowDamage)
ini_write_real(sectionWrite,"204",global.optMusic)
ini_write_real(sectionWrite,"205",global.optSound)
ini_write_real(sectionWrite,"206",global.optFairy)
ini_write_real(sectionWrite,"207",global.optEnemyHP)
ini_write_real(sectionWrite,"208",global.optAutoSave)
ini_write_real(sectionWrite,"209",global.optKillChainScreen)
ini_write_real(sectionWrite,"210",global.optKillChainSound)
ini_write_real(sectionWrite,"211",global.optKillingSpreeScreen)
ini_write_real(sectionWrite,"212",global.optKillingSpreeSound)
ini_write_real(sectionWrite,"213",global.optDPadDash)
ini_write_real(sectionWrite,"214",global.optRightIsForward)
ini_write_real(sectionWrite,"215",global.optShowHUD)
//saveProgress=50
//screen_redraw()

ini_write_string(sectionWrite,"301",global.ctrlUp)
ini_write_string(sectionWrite,"302",global.ctrlDown)
ini_write_string(sectionWrite,"303",global.ctrlLeft)
ini_write_string(sectionWrite,"304",global.ctrlRight)
ini_write_string(sectionWrite,"305",global.ctrlJump)
ini_write_string(sectionWrite,"306",global.ctrlFire)
ini_write_string(sectionWrite,"307",global.ctrlWater)
ini_write_string(sectionWrite,"308",global.ctrlWind)
ini_write_string(sectionWrite,"309",global.ctrlEarth)
ini_write_string(sectionWrite,"310",global.ctrlDashLeft)
ini_write_string(sectionWrite,"311",global.ctrlDashRight)

ini_write_real(sectionWrite,"400tf",global.saveFile_TimeFix)

//saveProgress=75
//screen_redraw()

for(i=0;i<global.maxLevels;i+=1)
{
  tempVar=encryptDecrypt(global.lvlComplete[i],0); ini_write_real(sectionWrite,string("r1") +string(i),tempVar)
  tempVar=encryptDecrypt(global.lvlCrystal[i],0); ini_write_real(sectionWrite,string("r2") +string(i),tempVar)
  tempVar=encryptDecrypt(global.lvlTime[i],0); ini_write_real(sectionWrite,string("r3") +string(i),tempVar)
  tempVar=encryptDecrypt(global.lvlScore[i],0); ini_write_real(sectionWrite,string("r4") +string(i),tempVar)
}

for(i=0;i<4;i+=1)
{
  tempVar=encryptDecrypt(global.challScore[i],0); ini_write_real(sectionWrite,string("ch1") +string(i),tempVar)
}

ini_close()
with oMessageSign
  instance_destroy()
stringToShow="Save Successful!!"
messageWidth=string_width(stringToShow)
newMessage=instance_create(256-(messageWidth/2),128,oMessageSign)
newMessage.message=stringToShow
newMessage.fadingTime=45
bSaving=0
