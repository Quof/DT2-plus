#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
viscidTop=1
makeActive()

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=384
xVel=0
yVel=0
init=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  if init=0
  {
    xVel=xMove
    yVel=yMove
    init=1
  }
  moveTime-=1
  if moveTime=0
  {
    xVel=0
    yVel=0
  }
  if decayTime<5000
    decayTime-=1
  if decayTime<=0
  {
    if decayTime=0
      image_blend=c_green
    image_alpha-=0.1
    if image_alpha<=0
      instance_destroy()
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
  if newSprite=0 //WSJ
  {
    draw_background_part_ext(tileWSJungle,64,0,48,32,x,y,1,1,image_blend,image_alpha)
    draw_background_part_ext(tileWSJungle,80,0,48,32,x+48,y,1,1,image_blend,image_alpha)
  }
  else if newSprite=1 //Zelda 2
  {
    for(i=0;i<image_xscale;i+=1)
    {
      draw_background_part_ext(tileVeiledDetritusInner,drawType,0,16,16,x+(i*16),y,1,1,image_blend,image_alpha)
    }
  }
}
