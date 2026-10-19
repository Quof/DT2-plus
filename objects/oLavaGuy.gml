#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
visible=false

//Enemy base statistics
damageType="SPIRIT"
spiritPower=200
elementType=1
bCanTakeDamage=false
bShowHealthBar=false
detectDistX=96
detectDistY=304
rising=0
difficultyAdjustments(global.difficulty)
yVel=0
if global.location="Distortion Reckoning"
  image_blend=c_black
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and rising>=0
  {
    if rising=0
    {
      yVel-=10
      visible=true
      rising=1
    }
    if yVel<0
      image_yscale=1
    else
      image_yscale=-1
    //yVel+=0.3
    //y+=yVel
    yVel=scrGravAcc(yVel,0.3,1) //60fps change: gravity (accelerate, then move) spread over the frames so the arc matches 30fps (see scrGravAcc)
    y+=yVel*gDeltaTime //60fps change: per 30fps tick
    if yVel>1 and y>ystart
    {
      yVel=0
      y=ystart
      bActive=false
      visible=false
      rising=-50
    }
  }
  if rising<0
    //rising+=1
    rising+=1*gDeltaTime //Cooldown //60fps change: counts 30fps ticks
}
