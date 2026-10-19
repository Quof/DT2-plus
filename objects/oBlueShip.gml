#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1

maxLife=410
life=maxLife
pointWorth=40
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=2

bullet_Delay=60
bullet_Speed=6.5
bullet_Time=50
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
  if progTimer>=12
    bDestroyIfOffScreen=1

  //---------- bullet pattern ----------
  //bullet_Time+=1
  bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if bullet_Time>=bullet_Delay and bullet_Time mod 3=0
  {
    if bulletPat=0
      bulDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)-30

    newBullet=instance_create(x,y,oEnemyShipBulletNormal)
    newBullet.sprite_index=sShipShot2
    newBullet.bDestroyIfOffScreen=true
    newBullet.bulletSpeed=bullet_Speed
    //newBullet.direction=bulDir
    newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
    bulDir+=15

    bulletPat+=1
    if bulletPat=5
    {
      bulletPat=0
      bullet_Time=0
    }
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
