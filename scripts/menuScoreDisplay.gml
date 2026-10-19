/*
This script is called in the map pause menu as well as find the game completion score
argument0: Determines what whether to draw the map stars. 0-do not draw, 1-draw
*/
var tDraw,starY,tGamePercent;
tDraw=argument0
starY=23
tGamePercent=0

findTargetScores()

draw_set_font(fnt_PauseText)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(1)

for(i=0;i<global.maxLevels-1;i+=1)
{
  //level
  if global.lvlComplete[i]=1
    tGamePercent+=1
  //crystal
  if global.lvlCrystal[i]=1
  {
    if tDraw=1
      draw_sprite(sItemIcon,0,scoreMenuX-32,scoreMenuY+starY)
    tGamePercent+=1
  }
  //time
  if global.lvlTime[i]<=targetTime[i] and global.lvlTime[i]>0
  {
    if tDraw=1
      draw_sprite(sItemIcon,0,scoreMenuX-6,scoreMenuY+starY)
    tGamePercent+=1
  }
  if global.lvlTime[i]>0
  {
    if tDraw=1
      draw_text(scoreMenuX+3,scoreMenuY+starY-6,global.lvlTime[i])
  }
  else
  {
    if tDraw=1
    {
      if i!=14
        draw_text(scoreMenuX+5,scoreMenuY+starY-7,"- - -")
    }
  }
  //score
  if global.lvlScore[i]>=targetScore[i]
  {
    if tDraw=1
      draw_sprite(sItemIcon,0,scoreMenuX+37,scoreMenuY+starY)
    tGamePercent+=1
  }
  if global.lvlScore[i]>0
  {
    if tDraw=1
      draw_text(scoreMenuX+46,scoreMenuY+starY-6,global.lvlScore[i])
  }
  else
  {
    if tDraw=1
    {
      if i!=3 and i!=6 and i!=10 and i!=13
        draw_text(scoreMenuX+47,scoreMenuY+starY-7,"- - - - -")
    }
  }

  starY+=13
}
global.gamePercent=round((tGamePercent/50)*100)
