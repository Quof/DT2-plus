#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-1,-1,1,1)
//find the correct sprite for effect and collision
currentSpell=oPlayer1.spellEffect
damageType="SPIRIT"
atkPower=oPlayer1.atkPower

if oPlayer1.image_xscale=-1
  image_xscale=-1

if currentSpell="EARTH SLAM"
{
  sprite_index=sSpellRockSmash
  setCollisionBounds(-10,-10,10,10)
  elementType=4
  skillPower=10
  yVel=-11
  lifeTime=15
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if currentSpell="EARTH SLAM"
{
  effect=instance_create(x,y,oEffect)
  effect.sprite_index=sRobotExplosion
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if currentSpell="EARTH SLAM"
  {
    //yVel+=0.6
    yVel=scrGravAcc(yVel,0.6,1) //60fps change: gravity (accelerate, then move) spread over the frames so the arc matches 30fps (see scrGravAcc)
    if isCollisionTop(1)
      instance_destroy()
  }

  if gDeltaDoTicks //60fps change (added): one trail effect per 30fps tick (every frame made 2x/4x as many)
  {
  var tEffect,tScale;
  tScale=1+((16-lifeTime)/10)
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sXshotEffect2; tEffect.image_speed=0.2; tEffect.image_alpha=0.35
  tEffect.image_xscale=tScale; tEffect.image_yscale=tScale
  } //60fps change (added)

  //if lifeTime<=0
  //  instance_destroy()
  //else
  //  lifeTime-=1
  //60fps change: counts 30fps ticks; checked before it's counted down, so the end is lower by the frame's share (see oSpell)
  if lifeTime<=gDeltaTime-1
    instance_destroy()
  else
    lifeTime-=1*gDeltaTime
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
}
