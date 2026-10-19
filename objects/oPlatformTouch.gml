#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
moving=false
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
if variable_local_exists("spriteChange")
  newSprite=spriteChange
if newSprite=1
{
  cR=0
  cG=64
  cB=128
}
if newSprite=3 or newSprite=4
  bFilled=choose(0,1)
if newSprite=7 and variable_local_exists("xSize")
  image_xscale=1+(xSize*0.5)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character stands on the platform, move the platform continuously
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  if isCollisionCharacterTop(1) and moving=false
  {
    xVel=moveSpeedX
    yVel=moveSpeedY
    moving=true
  }
  if x<-128
    instance_destroy()
  else if x>room_width+128
    instance_destroy()
  else if y<-128
    instance_destroy()
  else if y>room_height+128
    instance_destroy()
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
  if newSprite=0 //normal
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //3-3 room 2, elevator
  {
    draw_background_part(tileCVMine,0,112,96,16,x,y)
  }
}
