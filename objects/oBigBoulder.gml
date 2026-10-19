#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-28,-28,28,28)

//Enemy base statistics
spiritPower=450
damageType="SPIRIT"
elementType=4
moveSpeed=3
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
initDir=0
bTargetFound=false
detectDistX=160
detectDistY=368
difficultyAdjustments(global.difficulty)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true
  {
    if bTargetFound=false
      yVel=6
    bTargetFound=true
  }

  if bTargetFound=true
  {
    //yVel+=0.3
    yVel=scrGravAcc(yVel,0.3,1) //60fps change: gravity (accelerate, then move) spread over the frames so falls match 30fps (see scrGravAcc)
    if initDir=1
    {
      if xVel<0
        //image_angle+=5
        image_angle+=5*gDeltaTime //60fps change: per 30fps tick
      else
        //image_angle-=5
        image_angle-=5*gDeltaTime //60fps change: per 30fps tick
    }
  }
  if isCollisionBottom(1)
  {
    yVel=0
    if initDir=0
    {
      effect=instance_create(x,y+(sprite_height/2),oEffect)
      effect.sprite_index=sGroundDust
      effect.image_xscale=1.75
      effect.image_speed=0.33
      effect.image_alpha=0.75
      if oPlayer1.x>=x
        xVel=moveSpeed
      else
        xVel=-moveSpeed
      initDir=1
    }
  }
  if isCollisionLeft(1) and xVel<0
    instance_destroy()
  if isCollisionRight(1) and xVel>0
    instance_destroy()
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
  if y>room_height+24
    instance_destroy()
}
