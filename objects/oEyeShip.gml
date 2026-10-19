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

maxLife=150
life=maxLife
pointWorth=20
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=3.5

bullet_Delay=50
bullet_Speed=6
bullet_Time=30
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
    if progTimer>=20
    {
      if x<304
      {
        if y<shooterFieldMidY
          //direction=305
          _direction=305 //60fps change: see the shooter note in oShipEnemyBase's Create
        else
          //direction=55
          _direction=55 //60fps change: see the shooter note in oShipEnemyBase's Create
        enemyProg+=1
      }
    }
  }
  else if enemyProg=1 //arc back
  {
    if x>400
    {
      //direction=180
      _direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      enemyProg+=1
    }
  }

  //---------- bullet pattern ----------
  //bullet_Time+=1
  bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if bullet_Time>=bullet_Delay
  {
    var bulDir;
    if bulletPat=0
    {
      bulDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)
      newBullet=instance_create(x,y,oEnemyShipBulletNormal)
      newBullet.bDestroyIfOffScreen=true
      newBullet.bulletSpeed=bullet_Speed
      //newBullet.direction=bulDir
      newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
      bulletPat=1
    }
    else if bulletPat=1
    {
      bulDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)-20
      for(i=0;i<3;i+=1)
      {
        newBullet=instance_create(x,y,oEnemyShipBulletNormal)
        newBullet.bDestroyIfOffScreen=true
        newBullet.bulletSpeed=bullet_Speed
        //newBullet.direction=bulDir
        newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
        bulDir+=20
      }
      bulletPat=0
    }
    bullet_Time=0
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
