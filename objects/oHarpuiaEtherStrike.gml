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
//which GameMaker applies in full every frame; whatever fires it sets _direction
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
  //image_angle=direction
  _speed=bulletSpeed //60fps change: see Create
  image_angle=_direction
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
    newAttack=instance_create(x,y,oPassBullet)
    newAttack.sprite_index=sHarpuiaEnergyBall
    newAttack.image_speed=0.5
    newAttack.atkPower=atkPower-1
    newAttack.bulletSpeed=4
    if y<48
      //newAttack.direction=270
      newAttack._direction=270 //60fps change: _direction (it moves by _speed/_direction)
    if y>304
      //newAttack.direction=90
      newAttack._direction=90 //60fps change: _direction (it moves by _speed/_direction)
    if x<48
      //newAttack.direction=0
      newAttack._direction=0 //60fps change: _direction (it moves by _speed/_direction)
    if x>464
      //newAttack.direction=180
      newAttack._direction=180 //60fps change: _direction (it moves by _speed/_direction)

    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sBomberExplosion
    effect.image_speed=0.75
    effect.image_xscale=0.4
    effect.image_yscale=0.4
    effect.newBlend=1
    instance_destroy()
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
