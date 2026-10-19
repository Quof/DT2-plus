#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-5,-5,5,5)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
weight=50
grav=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if xVel>0
    //image_angle-=5
    image_angle-=5*gDeltaTime //60fps change: per 30fps tick
  else
    //image_angle+=5
    image_angle+=5*gDeltaTime //60fps change: per 30fps tick

  //yVel+=grav
  yVel=scrGravAcc(yVel,grav,1) //60fps change: gravity (accelerate, then move) spread over the frames so the arc matches 30fps (see scrGravAcc)
  if isCollisionTop(1)
  {
    explodeDir=1
    explodeDelay=0
  }
  if isCollisionBottom(1)
  {
    explodeDir=2
    explodeDelay=0
  }
  if isCollisionLeft(1)
  {
    explodeDir=3
    explodeDelay=0
  }
  if isCollisionRight(1)
  {
    explodeDir=4
    explodeDelay=0
  }

  //explodeDelay-=1
  explodeDelay-=1*gDeltaTime //60fps change: counts 30fps ticks
  if explodeDelay<=0
  {
    explosion=instance_create(x,y,oDamageExplosion)
    explosion.sprite_index=sTBBurstEffect
    explosion.image_speed=0.4
    explosion.atkPower=atkPower
    explosion.decayTime=-100
    if type=2
    {
      newAttack=instance_create(x,y,oTBSeed)
      newAttack.type=1
      newAttack.atkPower=atkPower
      if spreadDir=0
        newAttack.xVel=0
      else if spreadDir>=1 and spreadDir<=3
        newAttack.xVel=1.5
      else if spreadDir>=4 and spreadDir<=6
        newAttack.xVel=-1.5
      newAttack.yVel=-9
      newAttack.explodeDelay=120
    }
    else if type=3
    {
      explosion=instance_create(x,y,oTBSpike)
      explosion.atkPower=atkPower
      if explodeDir=3
        explosion.image_angle=270
      else if explodeDir=4
        explosion.image_angle=90
      else if explodeDir=1
        explosion.image_angle=180
    }
    else if type=4
    {
      newAttack=instance_create(x,y,oTBSeed)
      newAttack.image_blend=c_orange
      newAttack.type=3
      newAttack.atkPower=atkPower
      newAttack.xVel=0
      newAttack.yVel=-9
      newAttack.explodeDelay=1000
    }
    instance_destroy()
  }

  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move

  if y>room_height+32
    instance_destroy()
}
