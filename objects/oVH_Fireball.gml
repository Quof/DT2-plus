#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-6,6,6)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
hitWall=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=bulletSpeed
  //image_angle=random(360)
  _speed=bulletSpeed //60fps change: see Create
  if gDeltaDoTicks {image_angle=random(360)} //60fps change: spins once per 30fps tick
  if isCollisionTop(1)
    hitWall=1
  if isCollisionBottom(1)
    hitWall=2
  if isCollisionLeft(1)
    hitWall=3
  if isCollisionRight(1)
    hitWall=4

  if hitWall>=1
  {
    var tEffect;
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x-13+random(26),y-13+random(26),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.depth=8
      tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    }
    instance_destroy()
  }
}
//else {speed=0}
else {_speed=0}
correctSpeedDirection(self) //60fps change (added): see Create
