/*
This script finds which music track to play depending on where the player is.
Returns the ID of the music file to play.
argument0: 0: stop previous music when starting boss music, 1: don't stop
*/
var tempFindMusic,stopPrev;
stopPrev=argument0

if global.currentBoss=""
{
  if global.lvlCurrent="0-1"
    tempFindMusic=global.msc_Tutorial
  else if global.lvlCurrent="1-1" or global.lvlCurrent="1-2"
    tempFindMusic=global.msc_MarioOverworld
  else if global.lvlCurrent="1-3"
    tempFindMusic=global.msc_Caves
  else if global.lvlCurrent="2-1" or global.lvlCurrent="2-2"
    tempFindMusic=global.msc_SharpRuins
  else if global.lvlCurrent="3-1" or global.lvlCurrent="4-1"
    tempFindMusic=global.msc_Desert
  else if global.lvlCurrent="3-2" or global.lvlCurrent="3-3"
    tempFindMusic=global.msc_Temple
  else if global.lvlCurrent="4-2"
    tempFindMusic=global.msc_DataSegment
  else if global.lvlCurrent="5-1"
    tempFindMusic=global.msc_Flight
  else if global.lvlCurrent="Final"
  {
    if room=rFinal_aFleetA or room=rFinal_aFleetB or room=rFinal_aFleetC
      tempFindMusic=global.msc_Airship
    else if room=rFinal_a1 or room=rFinal_Boss_Core
      tempFindMusic=global.msc_LurkingEvil
    else
      tempFindMusic=global.msc_TheBug
  }
  else if global.lvlCurrent="Bonus"
    tempFindMusic=global.msc_Challenge
  else
    tempFindMusic=noone
}
else
{
  if stopPrev=0
    stopAllMusic()
  if global.currentBoss="Garbage Tracker" or global.currentBoss="TWSG" or global.currentBoss="Twin Bloom" or global.currentBoss="Harpuia" or global.currentBoss="Core"
    tempFindMusic=global.msc_BossFight
  else if global.currentBoss="Chaser" or global.currentBoss="Horror"
    tempFindMusic=global.msc_LurkingEvil
}

return tempFindMusic
