#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
alarm[0]=1
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dir=dirStart
dirChangeRate=changeRate
mSpeed=pSpeed
if variable_local_exists("spriteChange")
  newSprite=spriteChange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  dir+=dirChangeRate
  xVel=mSpeed*cos(degtorad(dir))
  yVel=mSpeed*sin(degtorad(dir))
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
  else if newSprite=1 //Desert Factory
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
  else if newSprite=2 //Data Segment Clone Factory
  {
    draw_background_part(tileDataSegment,32,64,32,16,x,y)
    draw_background_part(tileDataSegment,48,64,32,16,x+32,y)
  }
}
