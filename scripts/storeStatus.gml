/*
This script is called to store the player status.
argument0 is whether to read or write to the values
0=write
1=read
*/
if argument0=0
{
  global.pStatusStore[0]=oPlayer1.life
  global.pStatusStore[1]=oPlayer1.fireEnergy
  global.pStatusStore[2]=oPlayer1.waterEnergy
  global.pStatusStore[3]=oPlayer1.windEnergy
  global.pStatusStore[4]=oPlayer1.earthEnergy
}
else if argument0=1
{
  oPlayer1.life=global.pStatusStore[0]
  oPlayer1.fireEnergy=global.pStatusStore[1]
  oPlayer1.waterEnergy=global.pStatusStore[2]
  oPlayer1.windEnergy=global.pStatusStore[3]
  oPlayer1.earthEnergy=global.pStatusStore[4]
}
