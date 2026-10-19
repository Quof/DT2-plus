#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//direction=180
_direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
image_xscale=-1

maxLife=1500
life=maxLife
pointWorth=100
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=5

bullet_Time=70
bullet_Delay=60
bullet_Speed=5
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
  if enemyProg=0 //move forward
  {
    if x<=400
    {
      moveSpeed=0
      enemyProg+=1
    }
  }
  else if enemyProg=1 //arc back
  {
    if progTimer>=240
    {
      moveSpeed=3.5
      enemyProg+=1
    }
  }

  //---------- bullet pattern 1 - Bullet Arc ----------
  //bullet_Time+=1
  bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if bullet_Time>=bullet_Delay and x<=400
  {
    if bulletPat=0 //start
    {
      arcDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)
      bulletPat=1
    }
    if bullet_Time mod 3=0
    {
      for(i=0;i<2;i+=1)
      {
        newBullet=instance_create(x,y,oEnemyShipBulletCurve)
        newBullet.bDestroyIfOffScreen=true
        newBullet.type=i
        newBullet.bulletSpeed=bullet_Speed
        //newBullet.direction=arcDir
        newBullet._direction=arcDir //60fps change: see the shooter note in oShipEnemyBase's Create
        newBullet.dirThreshold=20
        newBullet.changeDir=4
        newBullet.changeDirTime=10
      }
      bulletPat+=1
    }
    if bulletPat>=20 //end
    {
      bulletPat=0
      bullet_Time=0
    }
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
