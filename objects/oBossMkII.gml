#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bBoss=true

maxLife=14000
life=maxLife
pointWorth=1000
enemyProg=0
progTimer=0
moveSpeed=5

bullet_Speed=6
spinDir=0
spinSpd=9
shotSpd=10
shotAmt=8

missileSpd=20
missileAmt=1

superAtk=0
coolDown=0
diffArc=0

mkShell=instance_create(x,y,oBossMkShell)
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oBossMkShell
  instance_destroy()
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
    //coolDown-=1
    coolDown-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if coolDown<=0
    {
      //if oGame.time mod shotSpd=0 //---------- spin attack ----------
      if oGame.time mod (shotSpd/gDeltaTime)=0 //---------- spin attack ---------- //60fps change: see the shooter note in oShipEnemyBase's Create
      {
        for(i=0;i<shotAmt;i+=1)
        {
          newBullet=instance_create(x,y,oEnemyShipBulletNormal)
          newBullet.sprite_index=sShipShot4
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=bullet_Speed
          //newBullet.direction=spinDir+(i*(360/shotAmt))
          newBullet._direction=spinDir+(i*(360/shotAmt)) //60fps change: see the shooter note in oShipEnemyBase's Create
        }
        spinDir+=spinSpd
      }

      if superAtk=0
      {
        //if oGame.time mod missileSpd=0 //---------- missile attack ----------
        if oGame.time mod (missileSpd/gDeltaTime)=0 //---------- missile attack ---------- //60fps change: see the shooter note in oShipEnemyBase's Create
        {
          for(i=0;i<missileAmt;i+=1) //top
          {
            newBullet=instance_create(x,y,oMkMissile)
            newBullet.type=1
            newBullet.bDestroyIfOffScreen=true
            newBullet.bulletSpeed=bullet_Speed-2
            newBullet.arcDir=1.1+random(1.5)
            //newBullet.direction=90
            newBullet._direction=90 //60fps change: see the shooter note in oShipEnemyBase's Create
          }

          for(i=0;i<missileAmt;i+=1) //bottom
          {
            newBullet=instance_create(x,y,oMkMissile)
            newBullet.type=2
            newBullet.bDestroyIfOffScreen=true
            newBullet.bulletSpeed=bullet_Speed-2
            newBullet.arcDir=1.1+random(1.5)
            //newBullet.direction=270
            newBullet._direction=270 //60fps change: see the shooter note in oShipEnemyBase's Create
          }
        }

        //if oGame.time mod 40=0 //---------- back laser ----------
        if oGame.time mod (40/gDeltaTime)=0 //---------- back laser ---------- //60fps change: see the shooter note in oShipEnemyBase's Create
        {
          newBullet=instance_create(16,32,oMkBackBeam)
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=bullet_Speed
          //newBullet.direction=270
          newBullet._direction=270 //60fps change: see the shooter note in oShipEnemyBase's Create
          newBullet=instance_create(16,room_height+8,oMkBackBeam)
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=bullet_Speed
          //newBullet.direction=90
          newBullet._direction=90 //60fps change: see the shooter note in oShipEnemyBase's Create
        }
      }
      else //super attack
      {
        //superAtk+=1
        superAtk+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
        if superAtk=2 //init attack
        {
          prevSpd=shotSpd
          prevAmt=shotAmt
          bullet_Speed=2
          shotSpd=3
          shotAmt=20
          spinSpd=7
          mkShell.rotSpd=15
        }
        //else if superAtk=900
        else if superAtk>=900 //60fps change: see the shooter note in oShipEnemyBase's Create (>=: the same at 30fps)
        {
          bullet_Speed=6
          spinSpd=8
          shotSpd=prevSpd
          shotAmt=prevAmt
          shotAmt+=1
          mkShell.rotSpd=1
          coolDown=90
          superAtk=0
        }
      }
    }
  }

  if life/maxLife<0.8 and diffArc=0
  {
    shotSpd-=1
    shotAmt+=1
    missileSpd-=3
    diffArc+=1
  }
  else if life/maxLife<0.5 and diffArc=1
  {
    shotSpd-=1
    shotAmt+=1
    missileSpd-=3
    diffArc+=1
  }
  else if life/maxLife<0.3 and diffArc=2
  {
    superAtk=1
    diffArc+=1
  }

  if instance_exists(mkShell)
  {
    mkShell.x=x
    mkShell.y=y
  }
}
