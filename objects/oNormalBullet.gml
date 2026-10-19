#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

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
    if type=1
    {
      explosion=instance_create(x,y,oDamageExplosion)
      explosion.sprite_index=sTBBurstEffect
      explosion.image_speed=0.65
      explosion.image_xscale=0.75
      explosion.image_yscale=0.75
      explosion.atkPower=atkPower
      explosion.decayTime=-100
    }
    else if type=2
    {
      fireMgr=instance_create(x,y,oSkellyBatFireManager)
      fireMgr.atkPower=atkPower
    }
    instance_destroy()
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
