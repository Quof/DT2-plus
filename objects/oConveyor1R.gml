#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
pushPower=1.25
if variable_local_exists("newPush")
  pushPower=newPush
image_speed=pushPower/4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the character
if global.gamePaused=false
{
  pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
  if pDist<600
  {
    if isCollisionCharacterTop(1)
    {
      with oPlayer1
        //moveTo(oGame.collisionTempId.pushPower,0)
        moveTo(oGame.collisionTempId.pushPower*gDeltaTime,0) //60fps change: pushes every frame, so a frame's share of the 30fps push (moveTo takes this frame's share of the move)
    }
    if isCollisionCharacterTop(1,oEarthShift)
    {
      with oEarthShift
        xVel=oGame.collisionTempId.pushPower
    }
  }
}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the character
if global.gamePaused=false
{
  pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
  if pDist<600
  {
    if isCollisionCharacterTop(1,other)
    {
      with other
        //moveTo(oGame.collisionTempId.pushPower,0)
        moveTo(oGame.collisionTempId.pushPower*gDeltaTime,0) //60fps change: pushes every frame, so a frame's share of the 30fps push (moveTo takes this frame's share of the move)
    }
  }
}
#define Collision_oLevelMovable
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the platform, move the character
if global.gamePaused=false
{
  pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
  if pDist<600
  {
    if isCollisionCharacterTop(1,other)
    {
      with other
        xVel=oGame.collisionTempId.pushPower
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sConveyorLeft1,image_index,x,y)
if image_xscale>2
{
  for(i=2;i<image_xscale;i+=1)
  {
    draw_sprite(sConveyorMid1,image_index,x+(i*16)-16,y)
  }
}
draw_sprite(sConveyorRight1,image_index,x+(image_xscale*16)-16,y)
