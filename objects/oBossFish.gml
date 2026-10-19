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

maxLife=13500
life=maxLife
pointWorth=200
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
    if bullet_Time>=bullet_Delay
    {
      if bulletPat>=0 and bulletPat<=9 //---------- wave attack ----------
      {
        if bullet_Time mod 9=0
        {
          var bulDir;
          bulDir=point_direction(x-40,y+6,oClaireShip.x,oClaireShip.y)-30
          for(i=0;i<7;i+=1)
          {
            newBullet=instance_create(x-40,y+6,oEnemyShipBulletNormal)
            newBullet.sprite_index=sShipShot2
            newBullet.bDestroyIfOffScreen=true
            newBullet.bulletSpeed=bullet_Speed
            //newBullet.direction=bulDir
            newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
            bulDir+=10
          }
          bulletPat+=1
        }
        if bulletPat=3
        {
          bullet_Time=0
          bulletPat+=1
        }
        else if bulletPat=7
        {
          bullet_Time=0
          bulletPat=10
        }
      }
      else if bulletPat>=10 and bulletPat<=19 //---------- circle attack ----------
      {
        if bullet_Time mod 15=0
        {
          var bulDir;
          bulDir=point_direction(x-40,y+6,oClaireShip.x,oClaireShip.y)
          for(i=0;i<28;i+=1)
          {
            newBullet=instance_create(x-40,y+6,oEnemyShipBulletNormal)
            newBullet.sprite_index=sShipShot2
            newBullet.bDestroyIfOffScreen=true
            newBullet.bulletSpeed=bullet_Speed/3
            //newBullet.direction=bulDir
            newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
            bulDir+=360/28
          }
          bulletPat+=1
        }
        else if bulletPat=12
        {
          bullet_Time=0
          bulletPat=0
        }
      }
    }
  }

  if life/maxLife<0.6 and diffArc=0
  {
    bullet_Delay=round(bullet_Delay/2)
    diffArc+=1
  }
  else if life/maxLife<0.3 and diffArc=1
  {
    bullet_Delay=round(bullet_Delay/2)
    diffArc+=1
  }
}
