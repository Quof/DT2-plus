#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bBoss=true
image_xscale=-1
image_speed=0
frameNum=0
frameSpd=9

maxLife=29000
life=maxLife
pointWorth=500
enemyProg=0
progTimer=0
bulletPat=0
moveSpeed=5

bullet_Delay=60
bullet_Speed=7
bullet_Time=35

spinDir=180

diffArc=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //---------- animation ----------
  //if oGame.time mod frameSpd=0
  if oGame.time mod (frameSpd/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
  {
    frameNum+=1
    if frameNum=1
      image_index=1
    else if frameNum=2
      image_index=2
    else if frameNum=3
      image_index=1
    else if frameNum=4
    {
      image_index=0
      image_yscale=-1
    }
    else if frameNum=5
      image_index=1
    else if frameNum=6
      image_index=2
    else if frameNum=7
      image_index=1
    else if frameNum=8
    {
      image_index=0
      image_yscale=1
      frameNum=0
    }
  }

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
    //if oGame.time mod round(frameSpd/2)=0 //---------- spin attack ----------
    if oGame.time mod (round(frameSpd/2)/gDeltaTime)=0 //---------- spin attack ---------- //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      for(i=0;i<diffArc;i+=1)
      {
        newBullet=instance_create(x,y,oEnemyShipBulletNormal)
        newBullet.sprite_index=sShipShot3
        newBullet.bDestroyIfOffScreen=true
        newBullet.bulletSpeed=bullet_Speed
        //newBullet.direction=spinDir+(i*90)
        newBullet._direction=spinDir+(i*90) //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      spinDir+=9
    }

    //bullet_Time+=1
    bullet_Time+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if bullet_Time>=bullet_Delay //---------- tri attack ----------
    {
      if bullet_Time mod 10=0
      {
        var yPos; yPos=y-38
        for(i=0;i<2;i+=1)
        {
          newBullet=instance_create(x,yPos,oEnemyShipBulletNormal)
          newBullet.sprite_index=sShipShot3
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=2
          //newBullet.direction=180
          newBullet._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
          yPos+=76
        }
        bulletPat+=1
      }

      if bulletPat>=1+diffArc
      {
        bulletPat=0
        bullet_Time=0
      }
    }
  }

  if life/maxLife<0.8 and diffArc=1
  {
    bullet_Delay=round(bullet_Delay/1.25)
    frameSpd-=2
    diffArc+=1
  }
  else if life/maxLife<0.6 and diffArc=2
  {
    bullet_Delay=round(bullet_Delay/1.5)
    frameSpd-=2
    diffArc+=1
  }
  else if life/maxLife<0.4 and diffArc=3
  {
    bullet_Delay=round(bullet_Delay/1.5)
    frameSpd-=2
    diffArc+=1
  }
}
