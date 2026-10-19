#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(-24,-42,24,-1)
animSpeed=0.26
image_speed=animSpeed

//Enemy base statistics
eName="Shroud"
inactiveDist=room_width
baseItemChance=90
dropInd=-5
moneyWorth=250
dieSound=global.snd_DemonDeath
if global.difficulty=1
{
  runAcc=2.7
  lungeWait=75
  diamondWait=70
  diveBombs=3
}
else if global.difficulty=2
{
  runAcc=3
  lungeWait=70
  diamondWait=65
  diveBombs=4
}
else if global.difficulty=3
{
  runAcc=3.3
  lungeWait=65
  diamondWait=60
  diveBombs=5
}
else if global.difficulty=4
{
  runAcc=3.6
  lungeWait=60
  diamondWait=50
  diveBombs=6
}
changeWait=270
lungeTime=irandom(30)
diamondTime=irandom(30)
changeTime=irandom(20)
transformTime=0

TYPE_GROUND=1
TYPE_AIR=2
TYPE_DIVE=3
TYPE_FORM_GROUND=4
TYPE_FORM_AIR=5
attackMode=TYPE_GROUND

maxProximity=112
yScaleGlow=1.01
scaleGlowTime=0
doubleTeam=0
dtTime=0

combatText="These always travel in packs with one taking the lead most of the time. There are a few minor differences between them, the lead one will behave slightly different. They have 2 distinct attack modes, a ground and flying. The ground one is able to lunge at you, while the flyer is able to launch danmaku diamonds at you. They can freely change between the 2 forms, with the flyer diving into the ground to change back into the ground type. Their most notable quality is that they will coordinate their attacks in order to get their prey. Be sure to periodically glance at the one you are not directing attacking as it is most definitely trying to find a way to pin you."
sideText="One of The Darkness' most skilled combatants. They are made of pure evil and dark energy. Their base stats will somewhat reflect your power level. When their lunge attack connects, it will inflict Spirit Drain. Once they have their target, they never stop and will continue hunting them down forever.#One more thing, watch their movement closely, it will tell you what they are doing next."
cripplePointText=">Thrust Attack#>Downward Strike#>Full Swing#>Any Physical Attack"
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxLife=3500+(oPlayer1.level*15)
life=maxLife
expWorth=6000+(round(oPlayer1.level*25))
physicalPower=310+(round(oPlayer1.level*2))
physicalDefense=125+(round(oPlayer1.level*1.25))
spiritPower=300+(round(oPlayer1.level*1.5))
spiritDefense=175+(round(oPlayer1.level*1.15))
difficultyAdjustments(global.difficulty)

if spawnCount>0
{
  spawnCount-=1
  sBuddy[spawnCount]=instance_create(x+xSdist,y+ySdist,oShroud)
  sBuddy[spawnCount].spawnCount=spawnCount
  sBuddy[spawnCount].bActive=true
  sBuddy[spawnCount].xSdist=xSdist
  sBuddy[spawnCount].ySdist=ySdist
  sBuddy[spawnCount].changeTime=changeWait-70+irandom(60)
  sBuddy[spawnCount].spawnerId=id
  sBuddy[spawnCount].dtXpointSelf=dtXpointOther
  sBuddy[spawnCount].dtYpointSelf=dtYpointOther
  sBuddy[spawnCount].dtTele=dtTele
}
else
  playSound(global.snd_DemonLaugh,0,1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and stunnedTime=0 and dieFade=0
  {
    //elemental weakness changes
    if attackMode=TYPE_GROUND
    {
      FIREresist=25
      WATERresist=-10
      WINDresist=-40
      EARTHresist=75
    }
    else if attackMode=TYPE_AIR
    {
      FIREresist=-10
      WATERresist=25
      WINDresist=75
      EARTHresist=-40
    }

    if diamondTime<diamondWait and doubleTeam!=1
      changeTime+=1
    if changeTime>=changeWait //change
    {
      if attackMode=TYPE_GROUND and lungeTime<lungeWait-2 and lungeTime>4 and doubleTeam!=1
      {
        changeTime=irandom(20)
        y-=4
        attackMode=TYPE_FORM_AIR
      }
      else if attackMode=TYPE_AIR and diamondTime<diamondWait-2 and diamondTime>4 and doubleTeam!=1
      {
        changeTime=irandom(20)
        attackMode=TYPE_FORM_GROUND
      }
    }

    if attackMode=TYPE_FORM_AIR //********** CHANGE INTO AIR FORM **********
    {
      transformTime+=1
      if transformTime=1
      {
        bCanTakeDamage=false
        xVel=0
        yVel=-4
        sprite_index=sShroudTransform
        image_speed=0
        image_index=0
      }
      else if transformTime=3
        image_index=1
      else if transformTime=5
        image_index=2
      else if transformTime=7
        image_index=3
      else if transformTime=9
        image_index=4
      else if transformTime=11
        image_index=5
      else if transformTime=13
        image_index=6
      else if transformTime=15
        image_index=5
      else if transformTime=17
        image_index=4
      else if transformTime=19
        image_index=3
      else if transformTime=21
        image_index=2
      else if transformTime=23
        image_index=7
      else if transformTime=25
        image_index=8
      else if transformTime=27
      {
        image_index=0
        image_speed=animSpeed
        transformTime=0
        yVel=0
        sprite_index=sShroudFlyerIdle
        bCanTakeDamage=true
        attackMode=TYPE_AIR
      }
    }
    else if attackMode=TYPE_FORM_GROUND //********** CHANGE INTO GROUND FORM **********
    {
      transformTime+=1
      if transformTime=1
      {
        bCanTakeDamage=false
        xVel=0
        sprite_index=sShroudDive1
        image_speed=0
        image_index=0
      }
      else if transformTime=3
        image_index=1
      else if transformTime=5
        image_index=2
      else if transformTime=7
        image_index=3
      else if transformTime=9
        image_index=4
      else if transformTime=11
        image_index=5
      else if transformTime=13
        image_index=6
      else if transformTime=15
      {
        transformTime=0
        attackMode=TYPE_DIVE
      }
    }
    else if attackMode=TYPE_DIVE //********** DIVE FORM **********
    {
      if transformTime>=2
        transformTime+=1
      if transformTime=0
      {
        if image_xscale=1 //go right
          xVel=3
        else //go left
          xVel=-3
        yVel=9
        transformTime=1
      }
      else if transformTime=3
      {
        xVel=0
        sprite_index=sShroudDive2
        image_index=0
      }
      else if transformTime=5
        image_index=1
      else if transformTime=7
        image_index=2
      else if transformTime=9
        image_index=3
      else if transformTime=11
        image_index=4
      else if transformTime=13
        image_index=5
      else if transformTime=15
      {
        sprite_index=sShroudTransform
        image_index=6
      }
      else if transformTime=17
        image_index=5
      else if transformTime=19
        image_index=4
      else if transformTime=21
        image_index=3
      else if transformTime=23
        image_index=2
      else if transformTime=25
        image_index=1
      else if transformTime=27
        image_index=0
      else if transformTime=29
      {
        image_index=0
        image_speed=animSpeed
        transformTime=0
        sprite_index=sShroudCrawlerIdle
        bCanTakeDamage=true
        attackMode=TYPE_GROUND
      }
    }
    else if attackMode=TYPE_GROUND //********** GROUND FORM **********
    {
      lungeTime+=1
      if lungeTime>=lungeWait
      {
        if lungeTime=lungeWait
        {
          xVel=0
          sprite_index=sShroudCrawlerIdle
          image_speed=0
          image_index=0
        }
        else if lungeTime=lungeWait+15 //start lunge
        {
          bInflictSpiritDrain=true
          sprite_index=sShroudCrawlerAttack
          y-=2
          yVel=-2
          if image_xscale=1 //go right
            xVel=runAcc*3
          else //go left
            xVel=-runAcc*3
        }
        else if lungeTime=lungeWait+30 //stop lunge
        {
          bInflictSpiritDrain=false
          xVel=0
          lungeTime=irandom(10)
          image_speed=animSpeed
        }
      }
      else //not lunging
      {
        if xVel=0
          sprite_index=sShroudCrawlerIdle
        else
          sprite_index=sShroudCrawlerWalk

        if x>oPlayer1.x //face left
          image_xscale=-1
        else //face right
          image_xscale=1

        if variable_local_exists("sBuddy")
        {
          if instance_exists(sBuddy[0])
          {
            if sBuddy[0].attackMode=TYPE_GROUND
              changeTime+=1
            maxProximity=8
          }
        }
        else
          maxProximity=112
        if point_distance(x,0,oPlayer1.x,0)>maxProximity
        {
          if x>oPlayer1.x //go left
            xVel=-runAcc
          else //go right
            xVel=runAcc
        }
        else
        {
          if !variable_local_exists("sBuddy")
          {
            if x>oPlayer1.x //go right (away from player)
              xVel=runAcc/1.5
            else //go left (away from player)
              xVel=-runAcc/1.5
          }
          else
            xVel=0
        }
      }
    }
    else if attackMode=TYPE_AIR //********** AIR FORM **********
    {
      if doubleTeam!=1
        diamondTime+=1
      if diamondTime>=diamondWait
      {
        if diamondTime=diamondWait
        {
          xVel=0
          image_speed=0
          image_index=3
        }
        else if diamondTime=diamondWait+15 //shoot diamond
        {
          image_index=2
          sDiamond=instance_create(x,y-32,oShroudDiamond)
          sDiamond.damageType="SPIRIT"
          sDiamond.spiritPower=spiritPower
          sDiamond.cSize=2
          sDiamond.bulletSpeed=1
          sDiamond.direction=point_direction(x,y-32,oPlayer1.x,oPlayer1.y-26)
        }
        else if diamondTime=diamondWait+25 //revert to normal fly
        {
          diamondTime=irandom(10)
          image_speed=animSpeed
        }
      }
      else //not firing diamond
      {
        if doubleTeam=0 //double team check
        {
          if lifePercent<=0.5
          {
            if variable_local_exists("sBuddy")
            {
              if instance_exists(sBuddy[0])
              {
                if sBuddy[0].attackMode=TYPE_AIR and sBuddy[0].diamondTime<diamondWait-1
                {
                  doubleTeam=1
                  sBuddy[0].doubleTeam=1
                }
              }
            }
            else
            {
              if instance_exists(spawnerId)
              {
                if spawnerId.attackMode=TYPE_AIR and spawnerId.diamondTime<diamondWait-1
                {
                  doubleTeam=1
                  spawnerId.doubleTeam=1
                }
              }
            }
          }
        }
        else if doubleTeam=1
        {
          dtTime+=1
          if dtTime=1
          {
            bCanTakeDamage=false
            sprite_index=sShroudTransform
            image_speed=0
            image_index=0
          }
          else if dtTime=20
          {
            if dtTele=true
            {
              x=dtXpointSelf
              y=dtYpointSelf
            }
          }
          else if dtTime=30
          {
            var dirTemp;
            dirTemp=0
            for(i=0;i<18;i+=1)
            {
              sDiamond=instance_create(x,y-32,oShroudDiamond)
              sDiamond.damageType="SPIRIT"
              sDiamond.spiritPower=spiritPower
              sDiamond.cSize=2
              sDiamond.bulletSpeed=1
              sDiamond.direction=dirTemp
              dirTemp+=20
            }
          }
          else if dtTime=40
          {
            image_index=0
            image_speed=animSpeed
            transformTime-=10
            sprite_index=sShroudFlyerIdle
            bCanTakeDamage=true
            doubleTeam=2
          }
          image_index=irandom_range(3,6)
        }

        if doubleTeam!=1 //no doing double team
        {
          if x>oPlayer1.x //face left
            image_xscale=-1
          else // faceright
            image_xscale=1

          if variable_local_exists("sBuddy")
          {
            if instance_exists(sBuddy[0])
            {
              if sBuddy[0].attackMode=TYPE_AIR
                diamondTime+=1
              maxProximity=128
            }
          }
          else
            maxProximity=96
          if point_distance(x,0,oPlayer1.x,0)>maxProximity
          {
            if x>oPlayer1.x //go left
              xVel=-runAcc/1.8
            else //go right
              xVel=runAcc/1.8
          }
          else
          {
            if variable_local_exists("sBuddy")
            {
              if instance_exists(sBuddy[0])
              {
                if x>oPlayer1.x //go right (away from player)
                  xVel=runAcc/1.2
                else //go left (away from player)
                  xVel=-runAcc/1.2
              }
            }
            else
              xVel=0
          }
        }
      }
    }

    if attackMode=TYPE_GROUND or attackMode=TYPE_DIVE
      yVel+=0.4
    if isCollisionTop(1)
    {
      if attackMode!=TYPE_DIVE
        yVel=0
    }
    if isCollisionBottom(1)
    {
      yVel=0
      if attackMode=TYPE_DIVE and transformTime=1
      {
        var xShoot,yShoot;
        xShoot=1
        yShoot=-4
        for(i=0;i<diveBombs;i+=1)
        {
          newAttack=instance_create(x,y-8,oShotzoBullet)
          newAttack.sprite_index=sMobileSentryGrenade
          newAttack.image_blend=c_purple
          newAttack.damageType="SPIRIT"
          newAttack.spiritPower=spiritPower
          newAttack.xVel=xShoot
          newAttack.yVel=yShoot
          newAttack=instance_create(x,y-8,oShotzoBullet)
          newAttack.sprite_index=sMobileSentryGrenade
          newAttack.image_blend=c_purple
          newAttack.damageType="SPIRIT"
          newAttack.spiritPower=spiritPower
          newAttack.xVel=-xShoot
          newAttack.yVel=yShoot
          xShoot+=0.65
          yShoot-=1.1
        }
        if instance_number(oShroud)=1
        {
          var dirTemp;
          dirTemp=0
          for(i=0;i<18;i+=1)
          {
            sDiamond=instance_create(x,y-32,oShroudDiamond)
            sDiamond.damageType="SPIRIT"
            sDiamond.spiritPower=spiritPower
            sDiamond.cSize=2
            sDiamond.bulletSpeed=1
            sDiamond.direction=dirTemp
            dirTemp+=20
          }
        }
        transformTime=2
        xVel=0
      }
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    moveTo(xVel,yVel)
    if isCollisionSolid()
      y+=2

    if y>room_height+2
    {
      changeTime=irandom(20)
      y-=4
      attackMode=TYPE_FORM_AIR
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_number(oShroud)=1
{
  draw_sprite_ext(sprite_index,image_index,x,y-1,image_xscale*1.025,yScaleGlow,0,c_white,0.2)
  scaleGlowTime+=1
  if scaleGlowTime>=0 and scaleGlowTime<=20
    yScaleGlow+=0.005
  else if scaleGlowTime>=21 and scaleGlowTime<=40
    yScaleGlow-=0.005
  else if scaleGlowTime>=41
    scaleGlowTime=0
}
event_inherited()
