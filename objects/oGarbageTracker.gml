#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-76,-26,76,58)
image_speed=0

//Enemy base statistics
eName="Garbage Tracker"
maxLife=760
life=maxLife
atkPower=3
atkDefense=0
FIREresist=100
WATERresist=100
WINDresist=100
EARTHresist=95
bIsBoss=true
barAmount=1
questType=1
bCanDealDamage=false
activateBoss=0
faceImage=0

waitTime=60
spiralShotAmt=8
pierceShotSpd=1
pierceShotSpdInc=1
pierceShotGrow=0.2
pierceShotWait=12

attackDelay=0
attackTime=0
currentAttack=0
nextAttack=1
attackProgress=0
bossProgress=0

hitsTillStun=0
stunThreshold=3
stunTime=190
bStun=0

teleportProgress=0
timeTillTeleport=190
teleportTimer=0
waitBetweenTime=10 //idle time when invisible
teleportNum=0 //number of times teleported
fadeMultiplier=1
teleAttack=0
teleAtkFreq=12
colorBlend=255

roomSpan=320
//teleport positions
psX[0]=268
psX[1]=384 //x center
psX[2]=500
psY[0]=148
psY[1]=192 //y center
psY[2]=336 //y ground
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay)
    showBossHP.bossID=id
    scanText="This has a strong elemental shield, but it looks like Earth can bring it down when it opens its attack port around the face. You may have to bash it a few times with Earth to knock it down. Once you do, it will probably bring up its Earth Resist. I can't tell what it will be vulnerable to after that, but it should give an indication."
    activateBoss=2
  }

  if hitsTillStun>=stunThreshold and bStun=0 //stun boss
  {
    hitsTillStun=100
    bStun=1
    faceImage=3
    teleAttack=0
    EARTHresist=100
    if currentAttack=0
      currentAttack=nextAttack

    if currentAttack=1
    {
      FIREresist=0
      WATERresist=80
      WINDresist=90
      effect_create_above(ef_ring,x,y,2,c_red)
      effect_create_above(ef_ring,x,y,1,c_red)
    }
    else if currentAttack=2
    {
      FIREresist=80
      WATERresist=0
      WINDresist=90
      effect_create_above(ef_ring,x,y,2,c_blue)
      effect_create_above(ef_ring,x,y,1,c_blue)
    }
    else if currentAttack=3
    {
      FIREresist=80
      WATERresist=80
      WINDresist=50
      effect_create_above(ef_ring,x,y,2,c_green)
      effect_create_above(ef_ring,x,y,1,c_green)
    }
  }
  else if bStun=1
  {
    //yVel+=0.2
    yVel=scrGravAcc(yVel,0.2,1) //60fps change: gravity spread over the frames (scrGravAcc; it moves at the end of Step)
    if isCollisionBottom(1)
      yVel=0

    //hitsTillStun+=1
    //if hitsTillStun>=101 and hitsTillStun<=115
    //  image_angle-=1
    //60fps change: the stun counts 30fps ticks (from 100), and the tilt is per tick in ticks 101-115 (from the first
    //frame of tick 101: >100)
    hitsTillStun+=1*gDeltaTime
    if hitsTillStun>100 and hitsTillStun<=115
      image_angle-=1*gDeltaTime

    if hitsTillStun>=stunTime //end stun
    {
      effect_create_above(ef_ring,x,y,2,c_white)
      FIREresist=100
      WATERresist=100
      WINDresist=100
      EARTHresist=95
      image_angle=0
      hitsTillStun=0
      faceImage=0
      currentAttack=0
      attackTime=0
      attackDelay=0
      bStun=0
      yVel=0
      teleportTimer=timeTillTeleport
    }
  }

  if bActive=true and dieFade=0
  {
    if bStun=0
    {
      if teleportProgress=0
      {
        if teleAttack=0
          //attackDelay+=1
          attackDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
        else //---------- teleport attack ----------
        {
          //teleAttack+=1
          //if (teleAttack>=106 and teleAttack<=190) or (teleAttack>=206 and teleAttack<=290)
          //60fps change: counts 30fps ticks (from 100 or 200); the sweep is per tick in ticks 106-190 and 206-290 (from
          //the first frame of tick 106/206), and the shots land on the same whole ticks ("mod teleAtkFreq=0")
          teleAttack+=1*gDeltaTime
          if (teleAttack>105 and teleAttack<=190) or (teleAttack>205 and teleAttack<=290)
          {
            if teleAttack<200
              //x+=8
              x+=8*gDeltaTime
            else
              //x-=8
              x-=8*gDeltaTime

            if x>144 and x<624 //weakness open/close
            {
              EARTHresist=90
              faceImage=2
            }
            else
            {
              EARTHresist=95
              faceImage=0
            }

            if teleAttack mod teleAtkFreq=0 //attack
            {
              teleShot=instance_create(x,y,oGTrackShot1)
              teleShot.atkPower=atkPower
              teleShot.bulletSpeed=5
              teleShot.curveTime=0
              teleShot.curveAmount=0
              //teleShot.direction=270
              teleShot._direction=270 //60fps change: _direction (it moves by _speed/_direction)
              if bossProgress>=1
              {
                teleShot=instance_create(x,y,oGTrackShot1)
                teleShot.atkPower=atkPower
                teleShot.bulletSpeed=2
                teleShot.curveTime=0
                teleShot.curveAmount=0
                //teleShot.direction=270
                teleShot._direction=270 //60fps change: _direction (it moves by _speed/_direction)
              }
              if bossProgress>=3
              {
                teleShot=instance_create(x,y,oGTrackShot1)
                teleShot.atkPower=atkPower
                teleShot.bulletSpeed=4.5
                teleShot.curveTime=20
                teleShot.curveAmount=5
                //teleShot.direction=220
                teleShot._direction=220 //60fps change: _direction (it moves by _speed/_direction)

                teleShot=instance_create(x,y,oGTrackShot1)
                teleShot.atkPower=atkPower
                teleShot.bulletSpeed=4.5
                teleShot.curveTime=20
                teleShot.curveAmount=-5
                //teleShot.direction=320
                teleShot._direction=320 //60fps change: _direction (it moves by _speed/_direction)
              }
            }

            if teleAttack<200 //end attack
            {
              if x>=704
              {
                teleAttack=200
                teleportTimer=timeTillTeleport
              }
            }
            else if teleAttack>200
            {
              if x<=64
              {
                teleAttack=0
                teleportTimer=timeTillTeleport
              }
            }
          }
        }

        if attackDelay>=waitTime
        {
          if currentAttack=0 //choose next attack
          {
            currentAttack=nextAttack
            nextAttack+=1
            if nextAttack=4
              nextAttack=1
          }
          else if currentAttack=1 //spiral shot ==================================================
          {
            //attackTime+=1
            attackTime+=1*gDeltaTime //60fps change: counts 30fps ticks
            if attackTime=1 //open mouth - frame 1
              faceImage=1
            else if attackTime=15 //open mouth - frame 2
            {
              EARTHresist=90
              faceImage=2
            }
            else if attackTime=35 //first wave
            {
              var shotDir;
              shotDir=0
              for(i=0;i<spiralShotAmt;i+=1)
              {
                spiralShot=instance_create(x,y,oGTrackShot1)
                spiralShot.atkPower=atkPower
                spiralShot.bulletSpeed=7
                spiralShot.curveTime=45
                spiralShot.curveAmount=8
                //spiralShot.direction=shotDir
                spiralShot._direction=shotDir //60fps change: _direction (it moves by _speed/_direction)
                shotDir+=360/spiralShotAmt
              }
            }
            else if attackTime=65 //second wave
            {
              var shotDir;
              shotDir=random(360)
              for(i=0;i<spiralShotAmt;i+=1)
              {
                spiralShot=instance_create(x,y,oGTrackShot1)
                spiralShot.atkPower=atkPower
                spiralShot.bulletSpeed=7
                spiralShot.curveTime=45
                spiralShot.curveAmount=-8
                //spiralShot.direction=shotDir
                spiralShot._direction=shotDir //60fps change: _direction (it moves by _speed/_direction)
                shotDir+=360/spiralShotAmt
              }
            }
            if attackTime=85 //close mouth - frame 1
            {
              EARTHresist=95
              faceImage=1
            }
            //else if attackTime=95 //end attack
            else if attackTime>=95 //end attack //60fps change: >=, so it still ends if the frame rate changed mid-count (the same at 30fps)
            {
              if bossProgress>=3
              {
                var shotDir;
                shotDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-24)
                for(i=0;i<spiralShotAmt;i+=1)
                {
                  spiralShot=instance_create(x,y,oGTrackShot1)
                  spiralShot.atkPower=atkPower
                  spiralShot.bulletSpeed=3
                  spiralShot.curveTime=0
                  spiralShot.curveAmount=0
                  //spiralShot.direction=shotDir
                  spiralShot._direction=shotDir //60fps change: _direction (it moves by _speed/_direction)
                  shotDir+=360/spiralShotAmt
                }
              }
              faceImage=0
              currentAttack=0
              attackTime=0
              attackDelay=0
            }
          }
          else if currentAttack=2 //piercing shot ==================================================
          {
            //attackTime+=1
            attackTime+=1*gDeltaTime //60fps change: counts 30fps ticks
            if attackTime=1 //open mouth - frame 1
              faceImage=1
            else if attackTime=15 //open mouth - frame 2
            {
              EARTHresist=90
              faceImage=2
            }
            else if attackTime=35 //send bullets
            {
              var tSpd,tFire,tDir;
              tSpd=pierceShotSpd
              tFire=0
              tDir=0
              for(i=0;i<spiralShotAmt;i+=1)
              {
                pierceShot=instance_create(x,y,oGTrackShot2)
                //pierceShot.direction=90
                pierceShot._direction=90 //60fps change: _direction (it moves by _speed/_direction)
                pierceShot.type=0
                pierceShot.atkPower=atkPower-1
                pierceShot.bulletSpeed=tSpd
                pierceShot.bulletWait=pierceShotWait
                pierceShot.bulletDelay=20
                pierceShot.bulletGrowTime=25
                pierceShot.bulletGrowAmt=pierceShotGrow
                pierceShot.bulletDir=tDir
                pierceShot.fireDelay=tFire

                pierceShot=instance_create(x,y,oGTrackShot2)
                //pierceShot.direction=270
                pierceShot._direction=270 //60fps change: _direction (it moves by _speed/_direction)
                pierceShot.type=0
                pierceShot.atkPower=atkPower-1
                pierceShot.bulletSpeed=tSpd
                pierceShot.bulletWait=pierceShotWait
                pierceShot.bulletDelay=20
                pierceShot.bulletGrowTime=25
                pierceShot.bulletGrowAmt=pierceShotGrow
                pierceShot.bulletDir=tDir
                pierceShot.fireDelay=tFire

                tSpd+=pierceShotSpdInc
                tFire+=4
                if tDir=0
                  tDir=180
                else
                  tDir=0
              }
            }
            if attackTime=85 //close mouth - frame 1
            {
              EARTHresist=95
              faceImage=1
            }
            //else if attackTime=95 //end attack
            else if attackTime>=95 //end attack //60fps change: >=, so it still ends if the frame rate changed mid-count (the same at 30fps)
            {
              faceImage=0
              currentAttack=0
              attackTime=0
              attackDelay=0
            }
          }
          else if currentAttack=3 //vision shot ==================================================
          {
            //attackTime+=1
            attackTime+=1*gDeltaTime //60fps change: counts 30fps ticks
            if attackTime=1 //open mouth - frame 1
              faceImage=1
            else if attackTime=15 //open mouth - frame 2
            {
              EARTHresist=90
              faceImage=2
            }
            else if attackTime=35 //send bullets
            {
              var shotDir,tFire;
              shotDir=random(360)
              tFire=0
              for(i=0;i<spiralShotAmt;i+=1)
              {
                visionShot=instance_create(x,y,oGTrackShot2)
                //visionShot.direction=shotDir
                visionShot._direction=shotDir //60fps change: _direction (it moves by _speed/_direction)
                visionShot.type=1
                visionShot.atkPower=atkPower-1
                visionShot.bulletSpeed=9
                visionShot.bulletWait=round(pierceShotWait/1.5)
                visionShot.bulletDelay=10
                visionShot.bulletGrowTime=15
                visionShot.bulletGrowAmt=pierceShotGrow*2
                visionShot.bulletDir=shotDir+45
                visionShot.fireDelay=tFire
                if bossProgress>=3
                {
                  visionShot=instance_create(x,y,oGTrackShot2)
                  //visionShot.direction=shotDir
                  visionShot._direction=shotDir //60fps change: _direction (it moves by _speed/_direction)
                  visionShot.type=1
                  visionShot.atkPower=atkPower-1
                  visionShot.bulletSpeed=9
                  visionShot.bulletWait=round(pierceShotWait/1.5)
                  visionShot.bulletDelay=10
                  visionShot.bulletGrowTime=15
                  visionShot.bulletGrowAmt=pierceShotGrow*2
                  visionShot.bulletDir=shotDir-45
                  visionShot.fireDelay=tFire
                }
                shotDir+=360/spiralShotAmt
                tFire+=1
              }
            }
            if attackTime=85 //close mouth - frame 1
            {
              EARTHresist=95
              faceImage=1
            }
            //else if attackTime=95 //end attack
            else if attackTime>=95 //end attack //60fps change: >=, so it still ends if the frame rate changed mid-count (the same at 30fps)
            {
              faceImage=0
              currentAttack=0
              attackTime=0
              attackDelay=0
            }
          }
        }

        if currentAttack=0 and bStun=0 and teleportTimer<timeTillTeleport
          //teleportTimer+=1
          teleportTimer+=1*gDeltaTime //60fps change: counts 30fps ticks

        if teleportTimer>=timeTillTeleport //start teleport ==================================================
        {
          bCanTakeDamage=false
          teleportTimer=0
          teleportProgress=1
        }
      }
      else if teleportProgress=1 //teleport away
      {
        //teleportTimer+=1
        //if teleportTimer=1
        //60fps change: counts 30fps ticks (the sound on the first frame), and the fade is per tick
        teleportTimer+=1*gDeltaTime
        if teleportTimer=1*gDeltaTime
        {
          playSound(global.snd_Teleport,0,0.95)
          attackType=0
        }
        //colorBlend-=25*fadeMultiplier
        //image_alpha-=0.1*fadeMultiplier
        colorBlend-=25*fadeMultiplier*gDeltaTime
        image_alpha-=0.1*fadeMultiplier*gDeltaTime
        image_blend=make_color_rgb(colorBlend,colorBlend,colorBlend)
        if image_alpha<=0 //choose new location
        {
          colorBlend=0
          image_alpha=0
          if teleAttack>0
          {
            x=704
            y=80
            teleportTimer=0
            teleportProgress=2
          }
          else
          {
            teleportNum+=1
            if teleportNum mod 3=0
            {
              x=64
              y=80
              teleAttack=100
              teleportTimer=0
              teleportProgress=2
            }
            else //normal attack teleport spot
            {
              x=psX[irandom(2)]
              y=psY[irandom(1)]
              teleportTimer=0
              teleportProgress=2
            }
          }
        }
      }
      else if teleportProgress=2 //slight wait time
      {
        //if teleportTimer>=waitBetweenTime
        //60fps change: counts 30fps ticks, checked before it's counted, so it moves on at waitBetweenTime+1-gDeltaTime
        //(the end of the same tick as at 30fps, where this is the same as before)
        if teleportTimer>=waitBetweenTime+1-gDeltaTime
        {
          teleportTimer=0
          teleportProgress=3
        }
        else
          //teleportTimer+=1
          teleportTimer+=1*gDeltaTime
      }
      else if teleportProgress=3 //teleport in
      {
        //teleportTimer+=1
        //if teleportTimer=1
        teleportTimer+=1*gDeltaTime //60fps change: see teleportProgress 1
        if teleportTimer=1*gDeltaTime
          playSound(global.snd_Teleport,0,0.95)
        //colorBlend+=25*fadeMultiplier
        //image_alpha+=0.1*fadeMultiplier
        colorBlend+=25*fadeMultiplier*gDeltaTime
        image_alpha+=0.1*fadeMultiplier*gDeltaTime
        image_blend=make_color_rgb(colorBlend,colorBlend,colorBlend)
        if image_alpha>=1
        {
          colorBlend=255
          image_blend=c_white
          bCanTakeDamage=true
          teleportProgress=0
        }
      }
    }

    //scale difficulty
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      waitTime-=4
      timeTillTeleport-=15
      teleAtkFreq-=1
      waitBetweenTime-=1
      stunThreshold+=1
      stunTime-=5
      spiralShotAmt+=2
      pierceShotSpd-=0.2
      pierceShotSpdInc-=0.1
      pierceShotGrow+=0.04
      pierceShotWait-=1
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      waitTime-=4
      timeTillTeleport-=15
      teleAtkFreq-=1
      waitBetweenTime-=2
      stunThreshold+=1
      stunTime-=5
      spiralShotAmt+=2
      pierceShotSpd-=0.2
      pierceShotSpdInc-=0.1
      pierceShotGrow+=0.04
      pierceShotWait-=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      fadeMultiplier=2
      waitTime-=4
      timeTillTeleport-=20
      teleAtkFreq-=1
      waitBetweenTime-=1
      stunThreshold+=1
      stunTime-=5
      spiralShotAmt+=2
      pierceShotSpd-=0.2
      pierceShotSpdInc-=0.1
      pierceShotGrow+=0.04
      pierceShotWait-=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and bossProgress=3
    {
      waitTime-=4
      timeTillTeleport-=20
      teleAtkFreq-=1
      waitBetweenTime-=1
      stunThreshold+=2
      stunTime-=5
      spiralShotAmt+=2
      pierceShotSpd-=0.2
      pierceShotSpdInc-=0.1
      pierceShotGrow+=0.04
      pierceShotWait-=2
      bossProgress+=1
    }
  }
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
  enemyStepEvent()
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTakingDamage=false and other.bCanDealDamage=true and bActive=true
{
  var tempCheck;
  tempCheck=0
  for(i=0;i<other.maxAtkId;i+=1)
  {
    if other.atkId[i]=id
      tempCheck=1
  }
  if tempCheck=0
  {
    takeDamage()
    other.atkId[other.maxAtkId]=id
    other.atkIdTime[other.maxAtkId]=0
    other.maxAtkId+=1

    if faceImage=2 and other.elementType=4
      hitsTillStun+=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sGarbageTrackerFace,faceImage,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
