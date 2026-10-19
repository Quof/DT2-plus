#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(0,0,sprite_width,sprite_height)

//variables for the break platform
bBreaking=0          //is the platform breaking
timeUntilBreak=20    //time till platform falls
newSprite=0
effectXscale=0.4
effectYscale=0.4
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.lvlCurrent="1-3"
  newSprite=1
else if global.lvlCurrent="4-2"
{
  newSprite=2
  image_xscale=2
}
else if global.lvlCurrent="Final"
{
  newSprite=2
  image_xscale=2
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character's falling
if global.gamePaused=false
{
  if bBreaking
  {
    //timeUntilBreak-=1
    timeUntilBreak-=1*gDeltaTime //60fps change: counts 30fps ticks
    if timeUntilBreak<=0
    {
      effect=instance_create(x+(sprite_width/2),y+(sprite_height/2),oEffect)
      effect.sprite_index=sDustCloud
      effect.image_xscale=effectXscale
      effect.image_yscale=effectYscale
      instance_destroy()
    }
  }
  else
  {
    //if the character touches the platform, start the timer
    if isCollisionCharacterTop(1)
      bBreaking=1
    if isCollisionCharacterBottom(1)
      bBreaking=1
    if isCollisionCharacterLeft(1)
      bBreaking=1
    if isCollisionCharacterRight(1)
      bBreaking=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if newSprite=0
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if newSprite=1 //1-3
  draw_background_part(tileIntermediaryCaves,80,32,16,16,x,y)
else if newSprite=2 //4-2
  draw_background_part(tileDataSegment,64,32,32,16,x,y)
else if newSprite=3 //Final - Section ?
  draw_background_part(tileDataSegment,64,32,32,16,x,y)
