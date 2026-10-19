#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)

newSprite=0
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spriteChange")
  newSprite=spriteChange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the platform
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  if isCollisionCharacterTop(1)
  {
    if isCollisionBottom(1)
      xVel=0
    else
      xVel=fallSpeed
  }
  else
  {
    if riseSpeed>0
    {
      if x>xstart
        xVel=-riseSpeed
      else
        xVel=0
    }
    else if riseSpeed<0
    {
      if x<xstart
        xVel=-riseSpeed
      else
        xVel=0
    }
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
    draw_sprite(sprite_index,-1,x,y)
  else if newSprite=1 //Data Segment 1
  {
    draw_background_part(tileDataSegment1,64,112,16,16,x,y)
    xSpace=16
    if image_xscale>2
    {
      for(i=0;i<image_xscale-2;i+=1)
      {
        draw_background_part(tileDataSegment1,80,112,16,16,x+xSpace,y)
        xSpace+=16
      }
    }
    draw_background_part(tileDataSegment1,96,112,16,16,x+xSpace,y)
  }
}
