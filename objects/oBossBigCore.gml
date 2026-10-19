#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bBoss=true

maxLife=40000
life=maxLife
pointWorth=2000
enemyProg=0
progTimer=0
moveSpeed=2
moveDelay=0

wingLaser=0
laserWeb=45
webProg=0
bulletPat=0
targetDelay=45
seekerDelay=120
seekerAmt=3

diffArc=0
wingSpreadTop=0 //40 max spread
wingSpreadBottom=0
bcWingTop=instance_create(x,y,oBossBCWing)
bcWingBottom=instance_create(x,y,oBossBCWing)
bcWingBottom.image_yscale=-1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oBossBCWing
  instance_destroy()
with oBCLaser
  instance_destroy()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false and life>0
{
  //---------- move pattern ----------
  if enemyProg=0 //move forward
  {
    //x-=moveSpeed
    x-=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if x<384
      enemyProg+=1
  }
  else if enemyProg=1 //wings inside
  {
    //progTimer+=1
    progTimer+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //if moveDelay=0
    if moveDelay<=0 //60fps change: see the shooter note in oShipEnemyBase's Create (moveDelay counts down 30fps ticks; the same as =0 at 30fps)
    {
      if point_distance(0,y,0,oClaireShip.y)>moveSpeed
      {
        if y<oClaireShip.y //move down
          //y+=moveSpeed
          y+=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
        else //move up
          //y-=moveSpeed
          y-=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      }
    }
    else
      //moveDelay-=1
      moveDelay-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create

    //if oGame.time mod 30=0 //straight laser
    if oGame.time mod (30/gDeltaTime)=0 //straight laser //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      if progTimer>=50 //open wings
      {
        progTimer=0
        if diffArc>=1
          enemyProg=11
        else
          enemyProg=2
      }
      else
      {
        for(i=0;i<5;i+=1)
        {
          if i=0
            newBullet=instance_create(x-55,y,oEnemyShipBulletNormal)
          else if i=1
            newBullet=instance_create(x-42,y-5,oEnemyShipBulletNormal)
          else if i=2
            newBullet=instance_create(x-42,y+5,oEnemyShipBulletNormal)
          else if i=3
            newBullet=instance_create(bcWingTop.x-36,bcWingTop.y-35,oEnemyShipBulletNormal)
          else if i=4
            newBullet=instance_create(bcWingBottom.x-36,bcWingBottom.y+35,oEnemyShipBulletNormal)
          newBullet.sprite_index=sShipShot4
          newBullet.bDestroyIfOffScreen=true
          newBullet.bulletSpeed=8
          //newBullet.direction=180
          newBullet._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        }
      }
      moveDelay=5
    }
  }
  else if enemyProg=2 //wing spread attack
  {
    //progTimer+=1
    progTimer+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //if progTimer>=1 and progTimer<=10 //spread wings
    if progTimer>0 and progTimer<=10 //spread wings //60fps change: see the shooter note in oShipEnemyBase's Create (all the frames of ticks 1-10)
    {
      //wingSpreadTop+=4
      wingSpreadTop+=4*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      //wingSpreadBottom+=4
      wingSpreadBottom+=4*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    }
    else if progTimer=11 //fire
    {
      for(i=0;i<13;i+=1)
      {
        if i=0
          newBullet=instance_create(x-55,y,oEnemyShipBulletNormal)
        else if i=1
          newBullet=instance_create(x-42,y-5,oEnemyShipBulletNormal)
        else if i=2
          newBullet=instance_create(x-42,y+5,oEnemyShipBulletNormal)
        else if i=3
          newBullet=instance_create(x-32,y-12,oEnemyShipBulletNormal)
        else if i=4
          newBullet=instance_create(x-32,y+12,oEnemyShipBulletNormal)
        else if i=5
          newBullet=instance_create(x-20,y-23,oEnemyShipBulletNormal)
        else if i=6
          newBullet=instance_create(x-20,y+23,oEnemyShipBulletNormal)
        else if i=7
          newBullet=instance_create(x-11,y-29,oEnemyShipBulletNormal)
        else if i=8
          newBullet=instance_create(x-11,y+29,oEnemyShipBulletNormal)
        else if i=9
          newBullet=instance_create(x-6,y-37,oEnemyShipBulletNormal)
        else if i=10
          newBullet=instance_create(x-6,y+37,oEnemyShipBulletNormal)
        else if i=11
          newBullet=instance_create(bcWingTop.x-36,bcWingTop.y-35,oEnemyShipBulletNormal)
        else if i=12
          newBullet=instance_create(bcWingBottom.x-36,bcWingBottom.y+35,oEnemyShipBulletNormal)
        newBullet.sprite_index=sShipShot4
        newBullet.bDestroyIfOffScreen=true
        newBullet.bulletSpeed=13
        //newBullet.direction=180
        newBullet._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
    }
    //else if progTimer>=12 and progTimer<=51 //close wings
    else if progTimer>11 and progTimer<=51 //close wings //60fps change: see the shooter note in oShipEnemyBase's Create (all the frames of ticks 12-51)
    {
      //wingSpreadTop-=1
      wingSpreadTop-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      //wingSpreadBottom-=1
      wingSpreadBottom-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    }
    //else if progTimer=52 //end
    else if progTimer>=52 //end //60fps change: see the shooter note in oShipEnemyBase's Create (>=: the same at 30fps)
    {
      progTimer=0
      enemyProg=1
    }
  }
  else if enemyProg=11 //-------------------- wings out + laser phase --------------------
  {
    if point_distance(0,y,0,shooterFieldMidY)>moveSpeed
    {
      if y<shooterFieldMidY //move down
        //y+=moveSpeed
        y+=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      else //move up
        //y-=moveSpeed
        y-=moveSpeed*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    }

    if wingLaser=0
      wingLaser=1
    //wingSpreadTop+=0.5
    wingSpreadTop+=0.5*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //wingSpreadBottom+=0.5
    wingSpreadBottom+=0.5*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //if wingSpreadTop=40
    if wingSpreadTop>=40 //60fps change: see the shooter note in oShipEnemyBase's Create (>=: the same at 30fps)
      enemyProg=12
  }
  else if enemyProg=12 //slight wait
  {
    //progTimer+=1
    progTimer+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if progTimer>=25
    {
      progTimer=0
      enemyProg=13
    }
  }
  else if enemyProg=13 //attack sequence
  {
    //if oGame.time mod 2=0 //web laser
    if oGame.time mod (2/gDeltaTime)=0 //web laser //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      newBullet=instance_create(x-24,y,oBCBounceLaser)
      newBullet.bulletSpeed=6
      //newBullet.direction=180-laserWeb
      newBullet._direction=180-laserWeb //60fps change: see the shooter note in oShipEnemyBase's Create

      newBullet=instance_create(x-24,y,oBCBounceLaser)
      newBullet.bulletSpeed=6
      //newBullet.direction=180+laserWeb
      newBullet._direction=180+laserWeb //60fps change: see the shooter note in oShipEnemyBase's Create

      if webProg=0
      {
        laserWeb+=0.5
        if laserWeb>=60
          webProg=1
      }
      else if webProg=1
      {
        laserWeb-=0.5
        if laserWeb<=30
          webProg=0
      }
    }

    //if oGame.time mod targetDelay=0 //target bullet
    if oGame.time mod (targetDelay/gDeltaTime)=0 //target bullet //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      newBullet=instance_create(x,y,oEnemyShipBulletNormal)
      newBullet.sprite_index=sShipShot5
      newBullet.bDestroyIfOffScreen=true
      newBullet.bulletSpeed=4
      //newBullet.direction=point_direction(x,y,oClaireShip.x,oClaireShip.y)
      newBullet._direction=point_direction(x,y,oClaireShip.x,oClaireShip.y) //60fps change: see the shooter note in oShipEnemyBase's Create
    }

    //if oGame.time mod seekerDelay=0 //delayed seeker bullet
    if oGame.time mod (seekerDelay/gDeltaTime)=0 //delayed seeker bullet //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      for(i=0;i<seekerAmt;i+=1)
      {
        newBullet=instance_create(x,y,oBCSideBullet)
        newBullet.bulletSpeed=4+(i*0.5)
        newBullet.bulletDelay=round(20+(i*3))
        //newBullet.direction=irandom_range(70,110)
        newBullet._direction=irandom_range(70,110) //60fps change: see the shooter note in oShipEnemyBase's Create

        newBullet=instance_create(x,y,oBCSideBullet)
        newBullet.bulletSpeed=4+(i*0.5)
        newBullet.bulletDelay=round(20+(i*3))
        //newBullet.direction=irandom_range(250,290)
        newBullet._direction=irandom_range(250,290) //60fps change: see the shooter note in oShipEnemyBase's Create
      }
    }

    if oClaireShip.x>=330 or oClaireShip.y<=154 or oClaireShip.y>=266 //keep player inside lasers
    {
      //if oGame.time mod 4=0
      if oGame.time mod (4/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
      {
        var antiCheat; antiCheat=point_direction(x,y,oClaireShip.x,oClaireShip.y)-15
        for(i=0;i<seekerAmt;i+=1)
        {
          for(ii=0;ii<3;ii+=1)
          {
            newBullet=instance_create(x,y,oEnemyShipBulletNormal)
            newBullet.sprite_index=sShipShot3
            newBullet.bDestroyIfOffScreen=true
            //newBullet.direction=antiCheat
            newBullet._direction=antiCheat //60fps change: see the shooter note in oShipEnemyBase's Create
            newBullet.bulletSpeed=7+(ii*2)
          }
          antiCheat+=15
        }
      }
    }
  }

  //fire big wing laser
  if wingLaser=1
  {
    topLaser=instance_create(bcWingTop.x-40,bcWingTop.y-21,oBCLaser)
    bottomLaser=instance_create(bcWingBottom.x-40,bcWingBottom.y+20,oBCLaser)
    wingLaser=2
  }
  else if wingLaser=2
  {
    topLaser.x=bcWingTop.x-40
    topLaser.y=bcWingTop.y-21
    bottomLaser.y=bcWingBottom.x-40
    bottomLaser.y=bcWingBottom.y+20
    //topLaser.image_xscale+=3
    topLaser.image_xscale+=3*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //bottomLaser.image_xscale+=3
    bottomLaser.image_xscale+=3*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }

  if life/maxLife<0.9 and diffArc=0
    diffArc+=1
  else if life/maxLife<0.7 and diffArc=1
  {
    targetDelay-=3
    seekerDelay-=3
    diffArc+=1
  }
  else if life/maxLife<0.6 and diffArc=2
  {
    targetDelay-=3
    seekerDelay-=3
    seekerAmt+=1
    diffArc+=1
  }
  else if life/maxLife<0.5 and diffArc=3
  {
    targetDelay-=3
    seekerDelay-=3
    diffArc+=1
  }
  else if life/maxLife<0.4 and diffArc=4
  {
    targetDelay-=3
    seekerDelay-=3
    diffArc+=1
  }
  else if life/maxLife<0.3 and diffArc=5
  {
    targetDelay-=3
    seekerDelay-=3
    seekerAmt+=1
    diffArc+=1
  }
  else if life/maxLife<0.2 and diffArc=6
  {
    targetDelay-=3
    seekerDelay-=3
    diffArc+=1
  }

  bcWingTop.x=x+1
  bcWingTop.y=y+6-wingSpreadTop
  bcWingBottom.x=x+1
  bcWingBottom.y=y-6+wingSpreadBottom
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sBossBCWingExt,0,x-1,y+6-wingSpreadTop,1,1,0,c_white,1)
draw_sprite_ext(sBossBCWingExt,0,x-1,y-6+wingSpreadBottom,1,-1,0,c_white,1)
event_inherited()
