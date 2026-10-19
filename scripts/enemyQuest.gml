/*
This script is called when an enemy dies that has a quest value attached to it.
It is used for scripted events such as bosses.
*/
if argument0=1
  oGlobalEvent.enemyCount-=1
else if argument0=2
  oExtrasRoom.enemyCount+=1
