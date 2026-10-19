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
image_speed=0.3

maxLife=660
life=maxLife
pointWorth=80
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=1.5

bullet_Delay=80
bullet_Speed=5
bullet_Time=40

shotSpd=5
arcAmt=11
sprayLength=55
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
  if bullet_Time>=bullet_Delay
  {
    if bullet_Time=bullet_Delay
    {
      dir1=180
      dir2=180
    }
    if bullet_Time mod shotSpd=0
    {
      for(i=0;i<3;i+=1)
      {
        newBullet=instance_create(x,y,oEnemyShipBulletNormal)
        newBullet.sprite_index=sShipShot2
        newBullet.bDestroyIfOffScreen=true
        newBullet.bulletSpeed=bullet_Speed+i
        //newBullet.direction=dir1
        newBullet._direction=dir1 //60fps change: see the shooter note in oShipEnemyBase's Create

        if dir2!=90 or dir2!=180
        {
          newBullet=instance_create(x,y,oEnemyShipBulletNormal)
          newBullet.sprite_index=sShipShot2
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=bullet_Speed+i
          //newBullet.direction=dir2
          newBullet._direction=dir2 //60fps change: see the shooter note in oShipEnemyBase's Create
        }
      }
      dir1+=arcAmt
      dir2-=arcAmt
    }
    if bullet_Time>=bullet_Delay+sprayLength
      bullet_Time=0
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
