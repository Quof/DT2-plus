#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bBoss=true
image_xscale=-1
image_speed=0.3

maxLife=11500
life=maxLife
pointWorth=400
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=5

bullet_Delay=55
bullet_Speed=7
bullet_Time=35

diffArc=0
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
  if enemyProg=0 //move forward
  {
    //x-=moveSpeed
    x-=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if x<384
    {
      moveSpeed=3.5
      enemyProg+=1
    }
  }
  else if enemyProg=1 //move up
  {
    //y-=moveSpeed/2
    y-=moveSpeed/2*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if y<shooterFieldMidY-shooterFieldMidY/2
      enemyProg=2
  }
  else if enemyProg=2 //move down
  {
    //y+=moveSpeed/2
    y+=moveSpeed/2*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if y>shooterFieldMidY+shooterFieldMidY/2
      enemyProg=1
  }

  //---------- bullet pattern ----------
  if enemyProg>=1
  {
    //bullet_Time+=1
    bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if bullet_Time>=bullet_Delay //---------- tri attack ----------
    {
      var bulDir;
      bulDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)-20
      for(i=0;i<3;i+=1)
      {
        newBullet=instance_create(x,y,oEnemyShipBulletNormal)
        newBullet.sprite_index=sTataShot
        newBullet.bDestroyIfOffScreen=true
        newBullet.bulletSpeed=bullet_Speed
        //newBullet.direction=bulDir
        newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
        bulDir+=20
      }
      bulletPat+=1

      if bulletPat mod 5=0
      {
        var bulDir;
        bulDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)-42
        for(i=0;i<13;i+=1)
        {
          newBullet=instance_create(x,y,oEnemyShipBulletNormal)
          newBullet.sprite_index=sTataShot
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=bullet_Speed-1
          //newBullet.direction=bulDir
          newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
          bulDir+=7
        }
      }

      if diffArc>=2
      {
        if bulletPat mod 6=0
        {
          arcDir=point_direction(x,y,oClaireShip.x,oClaireShip.y)
          for(i=0;i<2;i+=1)
          {
            newBullet=instance_create(x,y,oEnemyShipBulletCurve)
            newBullet.sprite_index=sTataShot
            newBullet.bDestroyIfOffScreen=true
            newBullet.type=i
            newBullet.bulletSpeed=1.5
            //newBullet.direction=arcDir
            newBullet._direction=arcDir //60fps change: see the shooter note in oShipEnemyBase's Create
            newBullet.dirThreshold=20
            newBullet.changeDir=3.5
            newBullet.changeDirTime=10
          }
        }
      }

      if bulletPat mod 3=0
        bullet_Time=0
    }
  }

  if life/maxLife<0.8 and diffArc=0
  {
    bullet_Delay=round(bullet_Delay/1.5)
    diffArc+=1
  }
  else if life/maxLife<0.5 and diffArc=1
  {
    bullet_Delay=round(bullet_Delay/1.5)
    diffArc+=1
  }
}
