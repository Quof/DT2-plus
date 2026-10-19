#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
viscidTop=1
makeActive()

//variables for the fall platform
grav=0.4             //how fast it falls
shaking=0            //is the platform shaking
timeUntilFall=25     //time till platform falls

xSpace=0
ySpace=0
shakeX=0
drawRangeX=768
drawRangeY=768
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xSpace=(image_xscale-1)*16
ySpace=(image_yscale-1)*16
if newTime>0
  timeUntilFall=newTime
shaking=bStartOn
if shaking=1
  yVel=3

if variable_local_exists("newDrawX")
  drawRangeX=newDrawX
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  if shaking=1
  {
    timeUntilFall-=1
    if timeUntilFall<=0
    {
      shakeX=0
      yAcc=grav
      if yVel>3
        yVel=3
    }
    else
    {
      if shakeX=1
        shakeX=-1
      else
        shakeX=1
    }
  }
  else
  {
    //if the character stands on the platform, start the timer
    if isCollisionCharacterTop(1)
      shaking=1
  }

  if y>=room_height+32
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
  draw_background_part(tileSection6,0,0,16,16,x+shakeX,y) //top left
  draw_background_part(tileSection6,48,0,16,16,x+xSpace+shakeX,y) //top right
  draw_background_part(tileSection6,0,48,16,16,x+shakeX,y+ySpace) //bottom left
  draw_background_part(tileSection6,48,48,16,16,x+xSpace+shakeX,y+ySpace) //bottom right

  for(i=1;i<image_xscale-1;i+=1)
    draw_background_part(tileSection6,16,0,16,16,x+(i*16)+shakeX,y) //top mid
  for(i=1;i<image_xscale-1;i+=1)
    draw_background_part(tileSection6,16,48,16,16,x+(i*16)+shakeX,y+ySpace) //bottom mid
  for(i=1;i<image_yscale-1;i+=1)
    draw_background_part(tileSection6,0,16,16,16,x+shakeX,y+(i*16)) //left mid
  for(i=1;i<image_yscale-1;i+=1)
    draw_background_part(tileSection6,48,16,16,16,x+xSpace+shakeX,y+(i*16)) //right mid

  for(i=1;i<image_xscale-1;i+=1)
  {
    for(ii=1;ii<image_yscale-1;ii+=1)
      draw_background_part(tileSection6,16,16,16,16,x+(i*16)+shakeX,y+(ii*16)) //middle
  }
}
