#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-24,-24,24,24)
image_blend=make_color_rgb(random_range(180,255),random_range(180,255),random_range(180,255))

//Enemy base statistics
bActive=true
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false
fallSpeed=random_range(3,5)
bCollide=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if newSpd>0
  fallSpeed=newSpd
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if gDeltaDoTicks //60fps change: one trail puff per 30fps tick
  {
    effect=instance_create(x-28+irandom(56),y-28+irandom(56),oEffect)
    effect.sprite_index=sS6MetEffect
    effect.image_speed=0.2+random(0.15)
  }

  //60fps change: spin and fall per 30fps tick (direction is only a heading here: its built-in speed is 0)
  if direction<=270
    //image_angle+=2
    image_angle+=2*gDeltaTime
  else
    //image_angle-=2
    image_angle-=2*gDeltaTime
  //moveTo(fallSpeed*cos(degtorad(direction)),-fallSpeed*sin(degtorad(direction)))
  moveTo(fallSpeed*cos(degtorad(direction))*gDeltaTime,-fallSpeed*sin(degtorad(direction))*gDeltaTime)

  if isCollisionBottom(1)
    bCollide=1
  if isCollisionLeft(1)
    bCollide=1
  if isCollisionRight(1)
    bCollide=1
  if y>room_height+sprite_height
    instance_destroy()

  if bCollide=1 //destroy
  {
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sS6MetImpact
    effect.image_speed=0.3+random(0.1)
    instance_destroy()
  }
}
