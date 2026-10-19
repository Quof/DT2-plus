#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
shiftTime=0
shiftTimeMax=96
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
bCanMove=true

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=xDir
yVel=yDir
shiftTimeMax=shiftChange
if variable_local_exists("spriteChange")
  newSprite=spriteChange
if variable_local_exists("newRangeX")
  drawRangeX=newRangeX
if variable_local_exists("newRangeY")
  drawRangeY=newRangeY
if variable_local_exists("doNotMove")
{
  bCanMove=false
  xVel=0
  yVel=0
}
if variable_local_exists("newStartTime")
  shiftTime=newStartTime
if newSprite=4 and variable_local_exists("xSize")
  image_xscale=1+(xSize*0.5)
if newSprite=5
  image_yscale=4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  if bCanMove=true
  {
    if shiftTime>=shiftTimeMax
    {
      shiftTime=0
      xVel*=-1
      yVel*=-1
    }
    else
      shiftTime+=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if newSprite=0
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //Intermediary Woods Log Horizontal
  {
    draw_background_part(tileIntermediaryWoods,80,32,64,16,x,y)
  }
  else if newSprite=2 //Intermediary Woods Log Vertical
  {
    draw_background_part(tileIntermediaryWoods,32,48,16,16,x,y) //top
    var tileToUse;
    tileToUse=0
    for(i=1;i<image_yscale-1;i+=1)
    {
      if tileToUse=0
        draw_background_part(tileIntermediaryWoods,32,64,16,16,x,y+(i*16)) //mid 1
      else if tileToUse=1
        draw_background_part(tileIntermediaryWoods,32,80,16,16,x,y+(i*16)) //mid 2
      else if tileToUse=2
        draw_background_part(tileIntermediaryWoods,32,96,16,16,x,y+(i*16)) //mid 3
      tileToUse+=1
      if tileToUse=3
        tileToUse=0
    }
    draw_background_part(tileIntermediaryWoods,32,112,16,16,x,y+(image_yscale*16)-16) //bottom
  }
  else if newSprite=3 //Intermediary Woods Log Horizontal
  {
    draw_background_part(tileIntermediaryCaves,96,32,32,16,x,y)
  }
  else if newSprite=4 //Desert Factory
  {
    draw_background_part(tileMMSewers,16,64,16,16,x,y)
    if image_xscale>2
    {
      for(i=0;i<image_xscale-2;i+=1)
      {
        draw_background_part(tileMMSewers,32,64,16,16,x+(i*16)+16,y)
      }
    }
    draw_background_part(tileMMSewers,16,64,16,16,x+(image_xscale*16)-16,y)
  }
  else if newSprite=5 //Desert Factory 2 - Final Level
    draw_background_part(tileMMSewers,0,64,64,64,x,y)
}
