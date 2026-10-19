#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1

maxLife=400
life=maxLife
pointWorth=60
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=1.75

bullet_Delay=95
bullet_Speed=8
bullet_Time=55
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //---------- move pattern ----------
  //speed=moveSpeed
  _speed=moveSpeed //60fps change: see the shooter note in oShipEnemyBase's Create
  //progTimer+=1
  progTimer+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if progTimer>=16
    bDestroyIfOffScreen=1

  //---------- bullet pattern ----------
  //bullet_Time+=1
  bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if bullet_Time>=bullet_Delay and bullet_Time mod 9=0
  {
    newBullet=instance_create(x-18,y,oBeetleMissile)
    newBullet.bDestroyIfOffScreen=true
    newBullet.bulletSpeed=bullet_Speed
    //newBullet.direction=180
    newBullet._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create

    bulletPat+=1
    if bulletPat=2
    {
      bulletPat=0
      bullet_Time=0
    }
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
