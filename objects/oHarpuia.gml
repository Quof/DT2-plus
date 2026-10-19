#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-12,-42,12,-1)
baseSpeed=0.33
image_speed=baseSpeed
//Enemy base statistics
eName="Harpuia"
maxLife=820
life=maxLife
atkPower=3
atkDefense=0
FIREresist=0
WATERresist=50
WINDresist=100
EARTHresist=50
bIsBoss=true
barAmount=1
questType=1

attackDelay=25
specialAttack=0
currentAction=0
currentAttack=0
attackNum=0 //number of attacks
tempVar=0
atkProg=0
chargeTime=0
bFricOn=0
topAtk=0
prevAttack=0

wallTrap=0

waitTime=45 //idle time between attacks
bladeCombo2=30
bladeCombo3=60
tornadoSizeMod=1
topLife=4
diveDetectY=48

inactiveDist=100000
bossProgress=0
xCenter=256
yGround=336
roomSpan=208

activateBoss=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay)
    showBossHP.bossID=id
    scanText="He moves so fast, it's hard for me to read his moves. I've noticed that every 5 attacks used from his ready pose are those tops he throws out. He alternates between homing and those ceiling spark versions. The main attack you should watch out for is that charge. He sneaks in a blade swing at the end and that has a lot more range than you might think. Try to make sure you always have an air dash ready. I don't know how else to help here, maybe my brother knows more about this than I do."
    jeremyText="Just focus and you can beat him. Carefully observe his movements and you will understand his limitations. Trust me, he has them. The biggest attack flaw he has is his uppercut. He can't follow up with any other attacks after using that so use that against him. Also be careful during his super attack. During this, note that all his defenses increase, but he becomes somewhat vulnerable to Wind. He will only have enough energy to perform this once. Focus, besides, I'm sure you don't want to look bad in front of " +string(global.mainCharacters[0]) +string(".")
    activateBoss=2
  }
  //60fps change: attackDelay counts 30fps ticks (+=1*gDeltaTime): the "=N" steps land on the tick's last frame, and
  //the per-tick parts of the charge, dive and Ether Strike run on those frames (frac(attackDelay)=0, every frame at
  //30fps), so they see the same positions as at 30fps. Moves, gravity and growths are spread over the frames; the
  //momentum stops run once per 30fps tick (gDeltaDoTicks), as their snapping to 0 needs the whole tick's step
  if bActive=true and dieFade=0
  {
    if sprite_index=sHarpuiaFlyingSlash
      image_speed=0
    else
      image_speed=baseSpeed

    if sprite_index=sHarpuiaStandIdle or sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly
    {
      if x>oCharacter.x
        image_xscale=-1
      else
        image_xscale=1
    }
    //========================= choose next action =========================
    if currentAction=0 //on ground - ready
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay>=waitTime
      {
        if sprite_index=sHarpuiaStandReady
        {
          if specialAttack=1 //special attack override
          {
            specialAttack+=1
            currentAction=90
          }
          else
          {
            attackNum+=1 //Remote Beam
            if attackNum>=5
            {
              currentAction=40
              attackNum=0
            }
            else //normal behavior
            {
              var nextAction,behaviorArc,tempXfind,atkToUse;
              behaviorArc=0
              atkToUse=prevAttack
              if findTargetX>roomSpan //player is far
                behaviorArc=60
              else if findTargetX>roomSpan/2 and findTargetX<roomSpan //player is mid range
                behaviorArc=45
              else //player is close
                behaviorArc=15

              tempXfind=abs(oPlayer1.x-xCenter)
              if tempXfind<48
                behaviorArc=30

              while atkToUse=prevAttack
              {
                nextAction=irandom(60)+behaviorArc
                if nextAction>=0 and nextAction<=50
                  atkToUse=30 ////Plasma Cyclone
                else if nextAction>=51 and nextAction<=70
                  atkToUse=20 //Flying Slash
                else if nextAction>=71 and nextAction<=90
                  atkToUse=50 //Charge
                else if nextAction>=91
                  atkToUse=10 //Combo Attack
              }

              currentAction=atkToUse
              prevAttack=atkToUse
            }
            //currentAction=30 //DELETE AFTER TESTING PHASE
          }
          attackDelay=0
        }
      }
    } //========================= actions =========================
    else if currentAction>=10 and currentAction<=19 //--------------- Slice/Slash/Sonic Boom Combo ---------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //First Attack: Slice
      {
        if oPlayer1.y<yGround-16 //jump chance
        {
          var jumpChance;
          jumpChance=round((yGround-oPlayer1.y)/3)
          if irandom(100)+jumpChance>90
          {
            y-=4
            if oPlayer1.y<yGround/2
              yVel=-11
            else
              yVel=-7
          }
        }
        currentAttack=10
      }
      if attackDelay>=bladeCombo2 and currentAction=11 //Second Attack: Slash
      {
        currentAction=12
        currentAttack=20
      }
      if attackDelay>=bladeCombo3 and currentAction=13 //Third Attack: Sonic Boom
      {
        currentAction=14
        currentAttack=30
      }
      if attackDelay>=bladeCombo2+bladeCombo3 and currentAction=15 //end attack sequence
      {
        currentAction=0
        attackDelay=0
      }
    }
    else if currentAction>=20 and currentAction<=29 //-------------------- Flying Slash --------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //jump
      {
        y-=4
        yVel=-10
      }
      else if attackDelay=15 //find fly speed
      {
        var tXspd;
        tXspd=round(abs(x-xCenter))
        if tXspd>=0 and tXspd<=32
          xVel=3
        else if tXspd>=33 and tXspd<=64
          xVel=3.6
        else if tXspd>=65 and tXspd<=96
          xVel=4.2
        else if tXspd>=97 and tXspd<=128
          xVel=4.8
        else
          xVel=5.4

        if x>xCenter //right side
        {
          image_xscale=-1
          xVel*=-1
        }
        else
          image_xscale=1
        sprite_index=sHarpuiaFlyingSlash
        image_index=0
      }
      else if attackDelay=22
      {
        yVel=2
        image_index=1
      }
      else if attackDelay=29 //first wave
      {
        image_index=2
        var offsetX,tDir;
        if x<oPlayer1.x
        {
          offsetX=12
          tDir=300
        }
        else
        {
          offsetX=-12
          tDir=240
        }
        playSound(global.snd_SpellFireball,0,1)
        atkBlade=instance_create(x+offsetX,y-22,oHarpuiaBladeAtk)
        atkBlade.sprite_index=sHarpuiaAtkFlySlash
        atkBlade.type=40
        atkBlade.atkPower=atkPower
        atkBlade.bulletSpeed=10
        //atkBlade.direction=tDir
        atkBlade._direction=tDir //60fps change: _direction (it moves by _speed/_direction)
        atkBlade.image_angle=tDir
      }
      else if attackDelay=36
        image_index=3
      else if attackDelay=43
      {
        image_index=4
        yVel=-8
      }
      else if attackDelay=50 //second wave
      {
        image_index=5
        if bossProgress>=4
        {
          var offsetX,tDir;
          if x<oPlayer1.x
          {
            offsetX=12
            tDir=300
          }
          else
          {
            offsetX=-12
            tDir=240
          }
          playSound(global.snd_SpellFireball,0,1)
          atkBlade=instance_create(x+offsetX,y-22,oHarpuiaBladeAtk)
          atkBlade.sprite_index=sHarpuiaAtkFlySlash
          atkBlade.type=40
          atkBlade.atkPower=atkPower
          atkBlade.bulletSpeed=10
          //atkBlade.direction=tDir
          atkBlade._direction=tDir //60fps change: _direction (it moves by _speed/_direction)
          atkBlade.image_angle=tDir
        }
      }
      else if attackDelay=57
        image_index=6
      else if attackDelay=64
      {
        if y<yGround-96 and findTargetX<diveDetectY //smash down if player is close enough
        {
          xVel=0
          currentAction=70
          attackDelay=0
        }
        else //normal attack end
        {
          if random(10)<3+(bossProgress/1.75) //randomly smash down
          {
            xVel=0
            currentAction=70
            attackDelay=0
          }
          else
          {
            xVel=0
            sprite_index=sHarpuiaFly
            image_index=0
            image_xscale*=-1
          }
        }
      }
      else if attackDelay=70 //end attack
      {
        currentAction=0
        attackDelay=0
      }
    }
    else if currentAction>=30 and currentAction<=39 //-------------------- Plasma Cyclone --------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //jump chance
      {
        if random(10)>4
        {
          y-=4
          yVel=-(5+irandom(2))
        }
        sprite_index=sHarpuiaPlasmaCyclone
        image_index=0
        atkProg+=1
      }
      if image_index>=4 and image_index<4.6 and atkProg=1 //attack
      {
        effect=instance_create(x,y,oEffect)
        effect.sprite_index=sHarpuiaPowerUp
        effect.image_alpha=0.8
        effect.image_speed=0.7
        effect.depth=26
        effect.followID=id
        effect.xFollow=0
        effect.yFollow=0

        atkBlade=instance_create(x+12,yGround,oHarpuiaBladeAtk)
        atkBlade.sprite_index=sHarpuiaTornado
        atkBlade.type=50
        atkBlade.atkPower=atkPower
        atkBlade.bulletSpeed=8
        atkBlade.image_alpha=0.8
        atkBlade.image_xscale=0.75+(tornadoSizeMod/4)
        atkBlade.image_yscale=1*tornadoSizeMod
        //atkBlade.direction=0
        atkBlade._direction=0 //60fps change: _direction (it moves by _speed/_direction)
        atkBlade=instance_create(x+12,yGround,oHarpuiaBladeAtk)
        atkBlade.sprite_index=sHarpuiaTornado
        atkBlade.type=50
        atkBlade.atkPower=atkPower
        atkBlade.bulletSpeed=8
        atkBlade.image_alpha=0.8
        atkBlade.image_xscale=0.75+(tornadoSizeMod/4)
        atkBlade.image_yscale=1*tornadoSizeMod
        //atkBlade.direction=180
        atkBlade._direction=180 //60fps change: _direction (it moves by _speed/_direction)
        atkProg+=1
      }
      if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly //end attack
      {
        if y<yGround-72 //chance to dive
        {
          if random(10)<2+(bossProgress/2)
            tempVar=2
          else
            tempVar=0
        }
        else //chance to charge
        {
          if random(10)<3.5+(bossProgress/2)
            tempVar=1
          else
            tempVar=0
        }

        if tempVar=0 //ready
        {
          atkProg=0
          currentAction=0
          currentAttack=0
        }
        else if tempVar=1 //charge
        {
          if x>oCharacter.x
            image_xscale=-1
          else
            image_xscale=1
          xVel=0
          currentAction=50
        }
        else if tempVar=2 //dive
        {
          xVel=0
          currentAction=70
        }
        attackDelay=0
        tempVar=0
      }
    }
    else if currentAction>=40 and currentAction<=49 //-------------------- Remote Beam --------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //jump
      {
        y-=4
        yVel=-(7+irandom(1))
      }
      else if attackDelay=7 //start animation
      {
        sprite_index=sHarpuiaRemoteBeam
        image_index=0
        atkProg+=1
      }
      if image_index>=5 and image_index<5.6 and atkProg=1 //attack
      {
        if topAtk=0
        {
          topAtk=1
          tempVar=0
        }
        else
        {
          if instance_number(oHarpuiaTop)>=4
            tempVar=0
          else
          {
            topAtk=0
            tempVar=1
          }
        }

        if tempVar=0
        {
          bFricOn=1
          if image_xscale=1
            xVel=-3
          else
            xVel=3
          yVel=-3

          var offsetX;
          if image_xscale=1
            offsetX=12
          else
            offsetX=-12
          atkBlade=instance_create(x+offsetX,y-22,oHarpuiaTop)
          atkBlade.type=1
          atkBlade.atkPower=atkPower-1
          atkBlade.bulletSpeed=4
          atkBlade.spdDown=0.2+random(0.1)
          atkBlade.lifeLine=topLife
          var pDir;
          if image_xscale=1
            pDir=330
          else
            pDir=210
          //atkBlade.direction=pDir
          atkBlade._direction=pDir //60fps change: _direction (it moves by _speed/_direction)
          atkBlade.image_angle=pDir
        }
        else
        {
          for(i=0;i<4;i+=1)
          {
            var xPlace;
            if i=0
              xPlace=96
            else if i=1
              xPlace=208
            else if i=2
              xPlace=304
            else if i=3
              xPlace=416
            atkBlade=instance_create(xPlace,-8,oHarpuiaTop)
            atkBlade.type=2
            atkBlade.atkPower=atkPower
            atkBlade.lifeLine=topLife*40
            atkBlade.image_angle=270
            atkBlade.atkSpd=45
          }
        }

        atkProg+=1
      }
      if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly and atkProg=2 //end attack
      {
        if random(10)<2+(bossProgress/2) //dive
        {
          xVel=0
          currentAction=70
        }
        else //ready
        {
          atkProg=0
          currentAction=0
        }
        attackDelay=0
      }
    }
    else if currentAction>=50 and currentAction<=59 //------------------------- Charge -------------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //charge start, find min/max dist
      {
        sprite_index=sHarpuiaCharge
        var xDistMin,xDistMax;
        xDistMin=abs(x-oPlayer1.x)-8
        if image_xscale=1
          xDistMax=abs(x-(xCenter+roomSpan))-16
        else
          xDistMax=abs(x-(xCenter-roomSpan))-16
        chargeTime=round(irandom_range(xDistMin,xDistMax)/14)
        if chargeTime<8
          chargeTime=8
        else if chargeTime>32
          chargeTime=32
      }
      else if attackDelay>=7 and attackDelay<900
      {
        if attackDelay=7
        {
          if image_xscale=1
            xVel=14
          else
            xVel=-14
        }
        if frac(attackDelay)=0 //60fps change (added): once per 30fps tick (see above)
        {
        chargeTime-=1

        for(i=0;i<abs(xVel);i+=1)
        {
          afterImage=instance_create(x+i,y,oEnemyAfterImage)
          afterImage.image_alpha=1
          afterImage.sprite_index=sHarpuiaImage
          afterImage.image_xscale=image_xscale
          afterImage.imageFade=0.08-(0.002*i)
        }

        if (findTargetX<40+bossProgress and oPlayer1.y>yGround-144-bossProgress) //check dist to player for uppercut
        {
          chargeTime=0
          tempVar=1
        }
        if chargeTime<=0 //end charge
        {
          xVel=0
          sprite_index=sHarpuiaChargeEnd
          image_index=0
          attackDelay=1000
        }
        } //60fps change (added)
      }
      else if attackDelay>=1000
      {
        if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly
        {
          atkProg=0
          if tempVar=1 //uppercut
            currentAction=60
          else //ready
            currentAction=0
          attackDelay=0
          tempVar=0
        }
      }
    }
    else if currentAction>=60 and currentAction<=69 //------------------------- Uppercut -------------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //charge attack
      {
        sprite_index=sHarpuiaUppercut
        image_index=0
        y-=4
        yVel=-10
        bFricOn=1
        if image_xscale=1
          xVel=4
        else
          xVel=-4
      }

      if sprite_index=sHarpuiaFly
      {
        yVel=-1
        currentAction=0
      }
    }
    else if currentAction>=70 and currentAction<=79 //------------------------- Dive/Shockwave -------------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //start dive
      {
        baseSpeed=0
        sprite_index=sHarpuiaPlasmaCyclone
        image_index=0
        yVel=13
      }
      else if attackDelay>=2
      {
        if frac(attackDelay)=0 //60fps change (added): one afterimage per 30fps tick (see above)
        {
        afterImage=instance_create(x,y,oEnemyAfterImage)
        afterImage.image_alpha=1
        afterImage.sprite_index=sprite_index
        afterImage.image_index=image_index
        afterImage.image_xscale=image_xscale
        afterImage.imageFade=0.1
        } //60fps change (added)

        if y>=yGround-1 //hit the ground
        {
          effect=instance_create(x,y,oEffect)
          effect.sprite_index=sHarpuiaPowerUp
          effect.image_alpha=0.8
          effect.image_yscale=0.5

          for(i=0;i<2;i+=1)
          {
            if i=0
              lDir=0
            else if i=1
              lDir=180
            groundLightning=instance_create(x,y,oHarpuiaBladeAtk)
            groundLightning.sprite_index=sHarpuiaGroundLightning
            groundLightning.type=1
            groundLightning.atkPower=atkPower-1
            groundLightning.bulletSpeed=7
            //groundLightning.direction=lDir
            groundLightning._direction=lDir //60fps change: _direction (it moves by _speed/_direction)
            groundLightning.image_speed=0.4
            groundLightning.image_xscale=1+(bossProgress*0.1)
            groundLightning.image_yscale=1.5
          }
          baseSpeed=0.33

          if oPlayer1.y>yGround-120 and findTargetX>64 //charge if player is far away
            tempVar=1
          else
          {
            if random(10)<3+(bossProgress/2) //charge randomly
              tempVar=1
            else
              tempVar=0
          }

          if tempVar=0 //ready state
          {
            sprite_index=sHarpuiaStandReady
            currentAction=0
          }
          else if tempVar=1 //charge state
          {
            if x>oCharacter.x
              image_xscale=-1
            else
              image_xscale=1
            xVel=0
            currentAction=50
          }
          attackDelay=0
          tempVar=0
        }
      }
    }
    else if currentAction>=90 and currentAction<=99 //------------------------- Special Attack -------------------------
    {
      //attackDelay+=1
      attackDelay+=1*gDeltaTime
      if attackDelay=1 //animation 1
      {
        with oHarpuiaTop
          lifeLine=0
        FIREresist=90
        WATERresist=90
        WINDresist=60
        EARTHresist=90
        y-=4
        yVel=-10
        sprite_index=sHarpuiaEtherStrike1
        image_index=0
      }
      else if attackDelay>=2 and attackDelay<90 //animation 2
      {
        if image_index>=3 and image_index<3.6
        {
          yVel=0
          attackDelay=100
          sprite_index=sHarpuiaEtherStrike2
        }
      }
      else if attackDelay>=100 and attackDelay<300
      {
        if x>xCenter
          //x-=4
          x-=4*gDeltaTime //60fps change: per 30fps tick
        else
          //x+=4
          x+=4*gDeltaTime
        //tempXfind=abs(x-xCenter)
        //if tempXfind<4
        //  attackDelay=1000
        if frac(attackDelay)=0 //60fps change: checked once per 30fps tick (see above), so it stops on the 30fps spot
        {
          tempXfind=abs(x-xCenter)
          if tempXfind<4
            attackDelay=1000
        }
      }

      if attackDelay>=1010 and attackDelay<1450 and attackDelay mod 16=0 //primary attack
      {
        for(i=0;i<2;i+=1)
        {
          etherAtk=instance_create(x,y-67,oHarpuiaEtherStrike)
          etherAtk.type=1
          etherAtk.atkPower=atkPower
          etherAtk.bulletSpeed=5
          //etherAtk.direction=(attackDelay*2)+(i*180)
          etherAtk._direction=(attackDelay*2)+(i*180) //60fps change: _direction (it moves by _speed/_direction)
          etherAtk.image_speed=0.5
        }
      }
      if attackDelay>=1010 and attackDelay<1450 and attackDelay mod 143=0 //secondary attack
      {
        for(i=0;i<4;i+=1)
        {
          etherAtk=instance_create(x,y-67,oHarpuiaEtherStrike)
          etherAtk.type=1
          etherAtk.atkPower=atkPower
          etherAtk.bulletSpeed=7
          if i=0
            //etherAtk.direction=35
            etherAtk._direction=35 //60fps change: _direction (it moves by _speed/_direction)
          else if i=1
            //etherAtk.direction=145
            etherAtk._direction=145 //60fps change: _direction (it moves by _speed/_direction)
          else if i=2
            //etherAtk.direction=215
            etherAtk._direction=215 //60fps change: _direction (it moves by _speed/_direction)
          else if i=3
            //etherAtk.direction=325
            etherAtk._direction=325 //60fps change: _direction (it moves by _speed/_direction)
          etherAtk.image_speed=0.5
        }
      }

      if attackDelay>=1460 //end attack
      {
        FIREresist=0
        WATERresist=50
        WINDresist=100
        EARTHresist=50
        sprite_index=sHarpuiaStandReady
        currentAction=0
        attackDelay=0
        attackNum=5
        topAtk=1
      }
    }
    //========================= attacks =========================
    if currentAttack=10 //---------- Attack: Slice ----------
    {
      if atkProg=0
      {
        sprite_index=sHarpuiaSlice
        image_index=0
        atkProg+=1
      }
      if image_index>=3 and image_index<3.6 and atkProg=1
      {
        var offsetX;
        if image_xscale=1
          offsetX=12
        else
          offsetX=-12
        playSound(global.snd_SpellFireball,0,1)
        atkBlade=instance_create(x+offsetX,y-22,oHarpuiaBladeAtk)
        atkBlade.type=10
        atkBlade.atkPower=atkPower-1
        atkBlade.bulletSpeed=10
        if bossProgress>5
        {
          var pDir;
          pDir=point_direction(x,y-22,oPlayer1.x,oPlayer1.y-22)
          //atkBlade.direction=pDir
          atkBlade._direction=pDir //60fps change: _direction (it moves by _speed/_direction)
          atkBlade.image_angle=pDir
        }
        else
        {
          if image_xscale=1
          {
            //atkBlade.direction=0
            atkBlade._direction=0 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=0
          }
          else
          {
            //atkBlade.direction=180
            atkBlade._direction=180 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=180
          }
        }
        atkProg+=1
      }
      if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly
      {
        atkProg=0
        currentAction=11
        currentAttack=0
      }
    }
    else if currentAttack=20 //---------- Attack: Slash ----------
    {
      if atkProg=0
      {
        sprite_index=sHarpuiaSlash
        image_index=0
        atkProg+=1
      }
      if image_index>=2 and image_index<2.6 and atkProg=1
      {
        var offsetX;
        if image_xscale=1
          offsetX=12
        else
          offsetX=-12
        playSound(global.snd_SpellFireball,0,1)
        atkBlade=instance_create(x+offsetX,y-22,oHarpuiaBladeAtk)
        atkBlade.sprite_index=sHarpuiaAtkSlash
        atkBlade.type=20
        atkBlade.atkPower=atkPower-1
        atkBlade.bulletSpeed=7
        if bossProgress>4
        {
          var pDir;
          pDir=point_direction(x,y-22,oPlayer1.x,oPlayer1.y-22)
          //atkBlade.direction=pDir
          atkBlade._direction=pDir //60fps change: _direction (it moves by _speed/_direction)
          atkBlade.image_angle=pDir
        }
        else
        {
          if image_xscale=1
          {
            //atkBlade.direction=0
            atkBlade._direction=0 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=0
          }
          else
          {
            //atkBlade.direction=180
            atkBlade._direction=180 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=180
          }
        }
        atkProg+=1
      }
      if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly
      {
        atkProg=0
        currentAction=13
        currentAttack=0
      }
    }
    else if currentAttack=30 //---------- Attack: Sonic Boom ----------
    {
      if atkProg=0
      {
        sprite_index=sHarpuiaSonicBoom
        image_index=0
        atkProg+=1
      }
      if image_index>=1 and image_index<1.6 and atkProg=1
      {
        var offsetX;
        if image_xscale=1
          offsetX=12
        else
          offsetX=-12
        playSound(global.snd_SpellFireball,0,1)
        atkBlade=instance_create(x+offsetX,y-22,oHarpuiaBladeAtk)
        atkBlade.sprite_index=sHarpuiaAtkSonicBoom
        atkBlade.type=30
        atkBlade.atkPower=atkPower
        atkBlade.bulletSpeed=6
        if bossProgress>3
        {
          var pDir;
          pDir=point_direction(x,y-22,oPlayer1.x,oPlayer1.y-22)
          //atkBlade.direction=pDir
          atkBlade._direction=pDir //60fps change: _direction (it moves by _speed/_direction)
          atkBlade.image_angle=pDir
        }
        else
        {
          if image_xscale=1
          {
            //atkBlade.direction=0
            atkBlade._direction=0 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=0
          }
          else
          {
            //atkBlade.direction=180
            atkBlade._direction=180 //60fps change: _direction (it moves by _speed/_direction)
            atkBlade.image_angle=180
          }
        }
        atkProg+=1
      }
      if sprite_index=sHarpuiaStandReady or sprite_index=sHarpuiaFly
      {
        atkProg=0
        currentAction=15
        currentAttack=0
      }
    }

    if wallTrap=1 //create wall lightning
    {
      var trapPlace;
      trapPlace=48
      for(i=0;i<9;i+=1)
      {
        trapLightningL[i]=instance_create(-16,trapPlace,oZapTrap)
        trapLightningL[i].sprite_index=sHarpuiaGroundLightning
        trapLightningL[i].image_angle=270
        trapLightningL[i].image_xscale=1.1
        trapLightningR[i]=instance_create(room_width+16,trapPlace,oZapTrap)
        trapLightningR[i].sprite_index=sHarpuiaGroundLightning
        trapLightningR[i].image_angle=90
        trapLightningR[i].image_xscale=1.1
        trapPlace+=34
      }
      wallTrap=2
    }
    else if wallTrap=2 //move wall lightning
    {
      for(i=0;i<9;i+=1)
      {
        //trapLightningL[i].x+=1
        //trapLightningR[i].x-=1
        trapLightningL[i].x+=1*gDeltaTime //60fps change: per 30fps tick
        trapLightningR[i].x-=1*gDeltaTime
      }
      if trapLightningL[0].x>=32
        wallTrap=3
    }

    //revert animation to idle/jump after attacking
    if (sprite_index=sHarpuiaSlice or sprite_index=sHarpuiaSlash) and image_index>=4.6
    {
      if yVel=0
        sprite_index=sHarpuiaStandReady
      else
        sprite_index=sHarpuiaFly
      image_index=0
    }
    else if sprite_index=sHarpuiaSonicBoom and image_index>=3.6
    {
      if yVel=0
        sprite_index=sHarpuiaStandReady
      else
        sprite_index=sHarpuiaFly
      image_index=0
    }
    else if (sprite_index=sHarpuiaRemoteBeam or sprite_index=sHarpuiaPlasmaCyclone) and image_index>=5.6
    {
      if yVel=0
        sprite_index=sHarpuiaStandReady
      else
        sprite_index=sHarpuiaFly
      image_index=0
    }
    else if sprite_index=sHarpuiaChargeEnd and image_index>=1.6
    {
      sprite_index=sHarpuiaStandReady
      image_index=0
    }
    else if sprite_index=sHarpuiaUppercut and image_index>=4.6
    {
      sprite_index=sHarpuiaFly
      image_index=0
    }

    //animation fix while in the air or on the ground while not attacking
    if y>=yGround-1
    {
      if currentAttack=0 and sprite_index=sHarpuiaFly
        sprite_index=sHarpuiaStandReady
    }
    else
    {
      if currentAttack=0 and sprite_index=sHarpuiaStandReady
        sprite_index=sHarpuiaFly
    }
    //stop momentum on ground
    //if sprite_index=sHarpuiaStandReady
    if sprite_index=sHarpuiaStandReady and gDeltaDoTicks //60fps change: once per 30fps tick (see above)
    {
      if xVel>0
        xVel-=0.75
      else if xVel<0
        xVel+=0.75

      if xVel<1.5 and xVel>0
        xVel=0
      else if xVel>-1.5 and xVel<0
        xVel=0
    }
    //stop momentum in air if pushed by attack
    //if bFricOn=1
    if bFricOn=1 and gDeltaDoTicks //60fps change: once per 30fps tick (see above)
    {
      if xVel>0
        xVel-=0.2
      else if xVel<0
        xVel+=0.2

      if xVel<0.4 and xVel>0
      {
        xVel=0
        bFricOn=0
      }
      else if xVel>-0.4 and xVel<0
      {
        xVel=0
        bFricOn=0
      }
    }

    //scale difficulty
    //waitTime=25
    //bladeCombo=18/36
    //tornadoSizeMod=1.5
    //topLife=9
    //diveDetectY=120
    if lifePercent<=0.9 and lifePercent>=0.81 and bossProgress=0
    {
      waitTime-=3
      bladeCombo2-=2
      bladeCombo3-=4
      tornadoSizeMod+=0.1
      diveDetectY+=8
      bossProgress+=1
    }
    else if lifePercent<=0.8 and lifePercent>=0.71 and bossProgress=1
    {
      waitTime-=3
      bladeCombo2-=2
      bladeCombo3-=4
      topLife+=1
      diveDetectY+=8
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.61 and bossProgress=2
    {
      waitTime-=2
      bladeCombo2-=2
      bladeCombo3-=4
      tornadoSizeMod+=0.1
      diveDetectY+=16
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=3
    {
      waitTime-=2
      bladeCombo2-=2
      bladeCombo3-=4
      topLife+=1
      diveDetectY+=8
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=4
    {
      waitTime-=2
      bladeCombo2-=2
      bladeCombo3-=4
      tornadoSizeMod+=0.1
      diveDetectY+=8
      specialAttack=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=5
    {
      waitTime-=2
      topLife+=1
      diveDetectY+=8
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.21 and bossProgress=6
    {
      waitTime-=2
      bladeCombo2-=2
      bladeCombo3-=4
      tornadoSizeMod+=0.1
      diveDetectY+=8
      wallTrap=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=7
    {
      waitTime-=2
      tornadoSizeMod+=0.1
      diveDetectY+=8
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=8
    {
      waitTime-=2
      topLife+=1
      bossProgress+=1
    }
  }
  if sprite_index!=sHarpuiaEtherStrike2
    //yVel+=0.3
    yVel=scrGravAcc(yVel,0.3,1) //60fps change: gravity spread over the frames (scrGravAcc; accelerates, then moves)

  if isCollisionBottom(1)
    yVel=0
  if isCollisionLeft(1)
  {
    xVel=1
    if sprite_index=sHarpuiaCharge
      chargeTime=0
  }
  if isCollisionRight(1)
  {
    xVel=-1
    if sprite_index=sHarpuiaCharge
      chargeTime=0
  }
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
  enemyStepEvent()
}
else
  image_speed=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if currentAction=90
{
  //draw_sprite_ext(sVirusFaceImage,0,room_width/2,room_height/2,5,5,oGame.time,c_white,0.15)
  //draw_sprite_ext(sVirusFaceImage,0,room_width/2,room_height/2,3,3,-oGame.time,c_white,0.3)
  //60fps change: a degree per 30fps tick (oGame.time counts frames)
  draw_sprite_ext(sVirusFaceImage,0,room_width/2,room_height/2,5,5,oGame.time*gDeltaTime,c_white,0.15)
  draw_sprite_ext(sVirusFaceImage,0,room_width/2,room_height/2,3,3,-oGame.time*gDeltaTime,c_white,0.3)
}
event_inherited()
