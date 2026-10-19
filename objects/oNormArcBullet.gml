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
//which GameMaker applies in full every frame; whatever fires it sets _direction. arcTickTime counts this shot's 30fps ticks
_speed=0
_direction=0
arcTickTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=bulletSpeed
  //direction+=arcAmt
  //image_angle=direction
  //if arcAmt<0.2 and arcAmt>-0.2
  //  arcAmt=0
  //arcAmt-=falloff
  //60fps change: the turn is spread over the frames (arcAmt is a 30fps tick's turn), and arcAmt itself changes once per
  //30fps tick of this shot (counted from when it was fired), after that tick's turn, as at 30fps. (Changed every frame,
  //the snap to 0 followed by the falloff would also have halved/quartered the slow drift it leaves the shot with)
  _speed=bulletSpeed
  if arcTickTime>=1
  {
    arcTickTime-=1
    if arcAmt<0.2 and arcAmt>-0.2
      arcAmt=0
    arcAmt-=falloff
  }
  _direction+=arcAmt*gDeltaTime
  image_angle=_direction
  arcTickTime+=gDeltaTime
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
