#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-16,16,16)
image_speed=0.2

//Enemy base statistics
eName="Virus Core"
maxLife=1040
life=maxLife
atkPower=3
atkDefense=0
FIREresist=80
WATERresist=100
WINDresist=100
EARTHresist=100
bIsBoss=true
barAmount=2
questType=1
bossProgress=0
currentAttack=0
bSpecialUse=false
specialAttack=0
specAtkTime=0

mainAtkDelay=340
vSpinShotDelay=470
vSpinShotAmt=6

mainAtkTime=120
vSpinShotTime=vSpinShotDelay-30

hitsTillStun=0
stunResist=0
stunThreshold=5

blendFire=make_color_rgb(255,125,125)
blendWater=make_color_rgb(129,171,224)
blendWind=make_color_rgb(33,225,33)
blendEarth=make_color_rgb(220,104,53)
shellBlend=blendFire
shellCurrent=blendFire
shellSize=1
shellSizeProg=0
shellPulsate=0.01
shellChange=0

eyeDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
prevEyeDir=0
eyeFrame=0
eyeSize=1
eyeTarget=oPlayer1
reTargetTime=0
eyeTickDir=eyeDir //60fps change (added): the eye's direction on the last 30fps tick (see Step)
dizzyThreshold=0

xCenter=384
yCenter=256
yGround=480
roomSpan=224

activateBoss=0
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
    scanText="I found out something cool about its second super attack. You need to use fire or wind to hurt it. But it looks like it will desperately try to keep you from being able to effectively use them. If you need me to distract it, just let me know. Maybe I can make it dizzy. As my brother would say, I'm sure you can figure it out."
    jeremyText="Pay close attention to its shell color, this will indicate which element you need to attack with in order to drop its defenses. Repeated attacking will make it change the color. Once you do, you can blast away with all of them. Its attack pattern will change according to the color of its shell as well."
    activateBoss=2
  }

  //---------- Stun Control ----------
  if hitsTillStun<stunThreshold //need to stun Virus Core
  {
    //---------- Eye direction and frame ----------
    //prevEyeDir=eyeDir
    //eyeDir=point_direction(x,y,eyeTarget.x,eyeTarget.y)
    //eyeFrame+=1
    //if eyeFrame=16
    //  eyeFrame=0
    //60fps change: prevEyeDir is the direction on the last 30fps tick, so the dizzy check (once per tick) sees a whole
    //tick's turn as at 30fps. The eye's frame counts 30fps ticks
    eyeDir=point_direction(x,y,eyeTarget.x,eyeTarget.y)
    if gDeltaDoTicks {prevEyeDir=eyeTickDir; eyeTickDir=eyeDir}
    eyeFrame+=1*gDeltaTime
    if eyeFrame>=16
      eyeFrame=0

    if bSpecialUse=false
    {
      //---------- Shell Resist/Color ----------
      if shellBlend=blendFire
      {
        FIREresist=80
        WATERresist=100
        WINDresist=100
        EARTHresist=100
      }
      else if shellBlend=blendWater
      {
        FIREresist=100
        WATERresist=80
        WINDresist=100
        EARTHresist=100
      }
      else if shellBlend=blendWind
      {
        FIREresist=100
        WATERresist=100
        WINDresist=80
        EARTHresist=100
      }
      else if shellBlend=blendEarth
      {
        FIREresist=100
        WATERresist=100
        WINDresist=100
        EARTHresist=80
      }

      //---------- Shell Color Change ----------
      //60fps change: the counts below count 30fps ticks (+=1*gDeltaTime)
      if mainAtkTime<mainAtkDelay
        //shellChange+=1
        shellChange+=1*gDeltaTime
      if shellChange>=400
      {
        if shellBlend=blendFire
        {
          shellBlend=blendWater
          shellCurrent=blendWater
        }
        else if shellBlend=blendWater
        {
          shellBlend=blendWind
          shellCurrent=blendWind
        }
        else if shellBlend=blendWind
        {
          shellBlend=blendEarth
          shellCurrent=blendEarth
        }
        else if shellBlend=blendEarth
        {
          shellBlend=blendFire
          shellCurrent=blendFire
        }

        for(i=0;i<12;i+=1)
        {
          effect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
          effect.direction=i*30
        }
        shellChange=0
      }

      if hitsTillStun>0
      {
        //stunResist+=1
        stunResist+=1*gDeltaTime
        if stunResist>=50
        {
          stunResist=0
          hitsTillStun-=1
        }
      }
    }
    else
      hitsTillStun=0
  }
  else //Virus Core stunned
  {
    background_hspeed[0]=-4
    background_vspeed[0]=4
    //---------- Eye Rotation ----------
    //eyeDir+=25
    eyeDir+=25*gDeltaTime //60fps change: per 30fps tick
    if eyeDir>=360
      eyeDir-=360

    //---------- Shell Resist/Color ----------
    FIREresist=0
    WATERresist=0
    WINDresist=0
    EARTHresist=0
    //shellBlend=make_color_rgb(random(190)+65,random(190)+65,random(190)+65)
    if gDeltaDoTicks {shellBlend=make_color_rgb(random(190)+65,random(190)+65,random(190)+65)} //60fps change: flashes once per 30fps tick

    if hitsTillStun<stunThreshold+10 //stun start and effect
    {
      hitsTillStun=100
    }
    //hitsTillStun+=1
    hitsTillStun+=1*gDeltaTime //60fps change: the stun counts 30fps ticks
    if hitsTillStun>=250 //end stun
    {
      background_hspeed[0]=-0.5
      background_vspeed[0]=0.5
      hitsTillStun=0
      shellBlend=shellCurrent
    }
  }

  //---------- Shell pulsate ----------
  //shellSizeProg+=1
  //if shellSizeProg>=1 and shellSizeProg<=25
  //  shellSize+=shellPulsate
  //else if shellSizeProg>=26 and shellSizeProg<=50
  //60fps change: counts 30fps ticks; the pulse runs on all the frames of ticks 1-25 and 26-50 (>0, >25)
  shellSizeProg+=1*gDeltaTime
  if shellSizeProg>0 and shellSizeProg<=25
    shellSize+=shellPulsate*gDeltaTime
  else if shellSizeProg>25 and shellSizeProg<=50
  {
    //shellSize-=shellPulsate
    shellSize-=shellPulsate*gDeltaTime
    if shellSizeProg=50
      shellSizeProg=0
  }

  //---------- Normal Behavior ----------
  if bActive=true and dieFade=0
  {
    if bSpecialUse=false
    {
      if hitsTillStun<stunThreshold
        //mainAtkTime+=1
        mainAtkTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      if mainAtkTime>=mainAtkDelay
      {
        if hitsTillStun-2>stunThreshold //keep virus from being stunned during main attack
        {
          hitsTillStun=stunThreshold-2
          shellBlend=shellCurrent
        }

        if mainAtkTime<1000
        {
          afterImage=instance_create(x,y,oEnemyAfterImage)
          afterImage.image_alpha=1
          afterImage.sprite_index=sVirusSpikeShell
          //afterImage.image_blend=shellBlend
          afterImage.imageFade=0.05
          afterImage.xScalingSet=0.18
          afterImage.yScalingSet=0.18

          if shellBlend=blendFire
            currentAttack=1
          else if shellBlend=blendWater
            currentAttack=2
          else if shellBlend=blendWind
            currentAttack=3
          else if shellBlend=blendEarth
            currentAttack=4
          mainAtkTime=1000
        }

        if mainAtkTime>=1025
        {
          if currentAttack=1 //-------------------- Fire Attack: Fire Circle --------------------
          {
            var newAttack,tSpinDir; tSpinDir=0
            for(i=0;i<round(vSpinShotAmt*1.25);i+=1)
            {
              newAttack=instance_create(x,y,oVirusFire)
              newAttack.x=x+lengthdir_x(roomSpan*1.6,tSpinDir)
              newAttack.y=y+lengthdir_y(roomSpan*1.6,tSpinDir)
              //newAttack.direction=tSpinDir-180
              newAttack._direction=tSpinDir-180 //60fps change: _direction (it moves by _speed/_direction)
              newAttack.atkPower=atkPower
              newAttack.bulletSpeed=4.5
              tSpinDir+=360/round(vSpinShotAmt*1.25)
            }
          }
          else if currentAttack=2 //-------------------- Water Attack: Bubble Pop --------------------
          {
            var newAttack,tSpinDir; tSpinDir=45
            for(i=0;i<4;i+=1)
            {
              newAttack=instance_create(x,y,oVirusBubble)
              newAttack.x=x+lengthdir_x(roomSpan*1.7,tSpinDir)
              newAttack.y=y+lengthdir_y(roomSpan*1.7,tSpinDir)
              //newAttack.direction=tSpinDir-180
              newAttack._direction=tSpinDir-180 //60fps change: _direction (it moves by _speed/_direction)
              newAttack.type=1
              newAttack.atkPower=atkPower
              newAttack.bulletSpeed=3
              newAttack.popTime=40
              tSpinDir+=360/4
            }
          }
          else if currentAttack=3 //-------------------- Wind Attack: Twister --------------------
          {
            var newAttack;
            newAttack=instance_create(16,yGround,oVirusTwister)
            //newAttack.direction=0
            newAttack._direction=0 //60fps change: _direction (oVirusTwister moves by _speed/_direction)
            newAttack.atkPower=atkPower
            newAttack=instance_create(752,yGround,oVirusTwister)
            //newAttack.direction=180
            newAttack._direction=180 //60fps change: _direction (oVirusTwister moves by _speed/_direction)
            newAttack.atkPower=atkPower
          }
          else if currentAttack=4 //-------------------- Earth Attack: Earth Spike --------------------
            instance_create(0,0,oVirusESControl)
          mainAtkTime=0
        }
      }
    }

    //-------------------- Normal Attack: Spin Shot --------------------
    if hitsTillStun<stunThreshold
      //vSpinShotTime+=1
      vSpinShotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if vSpinShotTime>=vSpinShotDelay
    {
      if specialAttack=1
      {
        var tSpinDir; tSpinDir=0
        for(i=0;i<4;i+=1)
        {
          newAttack=instance_create(x,y,oVirusShotSpin)
          newAttack.atkPower=atkPower-1
          newAttack.direction=tSpinDir
          tSpinDir+=360/4
        }
        vSpinShotTime=0
      }
      else
      {
        var tSpinDir; tSpinDir=0
        for(i=0;i<vSpinShotAmt;i+=1)
        {
          newAttack=instance_create(x,y,oVirusShotSpin)
          newAttack.atkPower=atkPower-1
          newAttack.direction=tSpinDir
          tSpinDir+=360/vSpinShotAmt
        }
        vSpinShotTime=0
      }
    }

    if specialAttack=1 //attack chasing player
    {
      if bSpecialUse=false
      {
        background_hspeed[0]=-0.5
        background_vspeed[0]=0.5
        FIREresist=75
        WATERresist=75
        WINDresist=75
        EARTHresist=75
        shellBlend=c_ltgray
        oPlayer1.x=xCenter
        oPlayer1.y=yGround
        msgCreate("Don't try dashing through these.",0,oMessagePerson,global.mainCharacters[1],0,128,128)
        newMessage.fadingTime=135
        with oEProjectileBase
          instance_destroy()

        newSpikeCircle=instance_create(xCenter,yCenter,oSpikeCircle)
        newSpikeCircle.image_xscale=2
        newSpikeCircle.image_yscale=2
        newSpikeCircle=instance_create(xCenter,yCenter,oSpikeCircle)
        newSpikeCircle.image_xscale=2
        newSpikeCircle.image_yscale=2
        newSpikeCircle.image_angle=180

        newChaser=instance_create(192,64,oVirusChaser)
        //newChaser.direction=270
        newChaser._direction=270 //60fps change: _direction (it moves by _speed/_direction)
        newChaser=instance_create(192,448,oVirusChaser)
        //newChaser.direction=0
        newChaser._direction=0 //60fps change: _direction (it moves by _speed/_direction)
        newChaser=instance_create(576,448,oVirusChaser)
        //newChaser.direction=90
        newChaser._direction=90 //60fps change: _direction (it moves by _speed/_direction)
        newChaser=instance_create(576,64,oVirusChaser)
        //newChaser.direction=180
        newChaser._direction=180 //60fps change: _direction (it moves by _speed/_direction)

        newTrap=instance_create(256,144,oMarioSpikeFloor)
        newTrap=instance_create(272,128,oMarioSpikeFloor)
        newTrap=instance_create(288,112,oMarioSpikeFloor)
        newTrap=instance_create(464,112,oMarioSpikeFloor)
        newTrap=instance_create(480,128,oMarioSpikeFloor)
        newTrap=instance_create(496,144,oMarioSpikeFloor)

        for(i=0;i<room_width;i+=64)
        {
          for(ii=0;ii<room_height;ii+=64)
          {
            effect_create_above(ef_firework,i,ii,1,make_color_rgb(50+i,50+ii,50+(i+ii)))
          }
        }
        hitsTillStun=0
        bSpecialUse=true
      }
      vSpinShotTime=vSpinShotDelay-90

      //specAtkTime+=1
      //if specAtkTime=910 //end special attack
      specAtkTime+=1*gDeltaTime //60fps change: counts 30fps ticks (>=: it still ends if the frame rate changed mid-count)
      if specAtkTime>=910 //end special attack
      {
        with oMarioSpikeFloor
          instance_destroy()
        with oVirusChaser
          instance_destroy()
        with oSpikeCircle
          instance_destroy()
        bSpecialUse=false
        shellBlend=shellCurrent
        specialAttack+=1
      }
    }
    else if specialAttack=3 //keeps player away
    {
      if bSpecialUse=false
      {
        background_hspeed[0]=-2
        background_vspeed[0]=2
        FIREresist=0
        WATERresist=100
        WINDresist=0
        EARTHresist=100
        shellBlend=c_black
        oPlayer1.x=xCenter
        oPlayer1.y=yGround
        with oEProjectileBase
          instance_destroy()
        for(i=0;i<room_width;i+=64)
        {
          for(ii=0;ii<room_height;ii+=64)
          {
            effect_create_above(ef_firework,i,ii,1,make_color_rgb(50+i,50+ii,50+(i+ii)))
          }
        }

        newTrap=instance_create(352,104,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=205
        newTrap=instance_create(416,104,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=335
        newTrap=instance_create(352,408,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=155
        newTrap=instance_create(416,408,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=25
        newTrap=instance_create(232,224,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=65
        newTrap=instance_create(232,288,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=295
        newTrap=instance_create(536,224,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=115
        newTrap=instance_create(536,288,oZapTrap)
        newTrap.sprite_index=sZapTrap2
        newTrap.image_xscale=1.7
        newTrap.image_angle=245

        shellSizeProg=0
        shellSize=1
        shellPulsate=0.02
        eyeSize=1.25
        hitsTillStun=0
        bSpecialUse=true
      }

      //check if player is in sight
      if hitsTillStun<stunThreshold
      {
        //if !collision_line(x,y,eyeTarget.x,eyeTarget.y-22,oSolid,1,1) and oGame.time mod 2=0
        if !collision_line(x,y,eyeTarget.x,eyeTarget.y-22,oSolid,1,1) and oGame.time mod (2/gDeltaTime)=0 //60fps change: every 2 30fps ticks (oGame.time counts frames)
        {
          var yOffset;
          if eyeTarget=oPlayer1
            yOffset=22
          else
            yOffset=0
          var playerDir; playerDir=point_direction(x,y,eyeTarget.x,eyeTarget.y-yOffset)
          playerDir-=2.5
          for(i=0;i<3;i+=1)
          {
            newAttack=instance_create(x,y,oNormalBullet)
            newAttack.type=0
            newAttack.sprite_index=sVirusShot
            //newAttack.direction=playerDir
            newAttack._direction=playerDir //60fps change: _direction (oNormalBullet moves by _speed/_direction)
            newAttack.image_speed=0.4
            newAttack.atkPower=atkPower
            newAttack.bulletSpeed=12
            playerDir+=2.5
          }
        }
      }

      //find distance for player and Chao
      var distPlayer,distChao;
      distPlayer=distance_to_object(oPlayer1)
      distChao=distance_to_object(oIdentifier)
      if eyeTarget=oPlayer1
      {
        if distChao<distPlayer
          //reTargetTime+=1
          reTargetTime+=1*gDeltaTime //60fps change: counts 30fps ticks
        else
          reTargetTime=0
        if reTargetTime>=90
          eyeTarget=oIdentifier
      }
      else
      {
        if distChao>distPlayer
          //reTargetTime+=1
          reTargetTime+=1*gDeltaTime //60fps change: counts 30fps ticks
        else
          reTargetTime=0
        if reTargetTime>=300
          eyeTarget=oPlayer1
      }

      //check eye spin if Chao is the target
      //if eyeTarget=oIdentifier
      if eyeTarget=oIdentifier and gDeltaDoTicks //60fps change: once per 30fps tick, with prevEyeDir from the last tick (see the top)
      {
        if dizzyThreshold<0
          dizzyThreshold=0
        var rotation; rotation=abs(eyeDir-prevEyeDir)
        if rotation>9
          dizzyThreshold+=1
        else
          dizzyThreshold-=2

        if dizzyThreshold>=50
          hitsTillStun=120
      }
    }

    //scale difficulty
    if lifePercent<=0.9 and lifePercent>=0.81 and bossProgress=0
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      bossProgress+=1
    }
    else if lifePercent<=0.8 and lifePercent>=0.71 and bossProgress=1
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      vSpinShotAmt+=1
      stunThreshold+=1
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.61 and bossProgress=2
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.51 and bossProgress=3
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      vSpinShotAmt+=1
      stunThreshold+=1
      specialAttack+=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.41 and bossProgress=4
    {
      mainAtkDelay-=30
      vSpinShotDelay-=30
      stunThreshold+=1
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.31 and bossProgress=5
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      vSpinShotAmt+=1
      bossProgress+=1
    }
    else if lifePercent<=0.3 and lifePercent>=0.19 and bossProgress=6
    {
      mainAtkDelay-=5
      vSpinShotDelay-=5
      vSpinShotAmt+=1
      stunThreshold+=1
      bossProgress+=1
    }
    else if lifePercent<=0.18 and bossProgress=7
    {
      specialAttack+=1
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

    //special damage properties
    if hitsTillStun<100
    {
      if shellBlend=blendFire and other.elementType=1
      {
        hitsTillStun+=1
        stunResist=0
        shellChange+=35
      }
      else if shellBlend=blendWater and other.elementType=2
      {
        hitsTillStun+=1
        stunResist=0
        shellChange+=35
      }
      else if shellBlend=blendWind and other.elementType=3
      {
        hitsTillStun+=1
        stunResist=0
        shellChange+=35
      }
      else if shellBlend=blendEarth and other.elementType=4
      {
        hitsTillStun+=1
        stunResist=0
        shellChange+=35
      }
    }

    if eyeTarget=oIdentifier and hitsTillStun<stunThreshold
      eyeTarget=oPlayer1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sVirusSpikeShell,0,x,y,shellSize,shellSize,image_angle,shellBlend,image_alpha)
draw_sprite_ext(sVirusEye,eyeFrame,x,y,eyeSize,eyeSize,eyeDir,image_blend,image_alpha)

//DELETE AFTER DEBUGGING
/*
xSet=view_xview[0]+4
ySet=view_yview[0]+80
draw_set_color(c_black)
draw_set_alpha(1)
draw_set_halign(fa_left)
draw_set_font(fnt_DamageNotice)
draw_text(xSet,ySet,"Eye Direction:"); draw_text(xSet+80,ySet,eyeDir)
draw_text(xSet,ySet+10,"Atk Time:"); draw_text(xSet+80,ySet+10,mainAtkTime)
draw_text(xSet,ySet+20,"Hits:"); draw_text(xSet+80,ySet+20,hitsTillStun)
draw_text(xSet,ySet+30,"Resist:"); draw_text(xSet+80,ySet+30,stunResist)
draw_text(xSet,ySet+40,"Blend:"); draw_text(xSet+80,ySet+40,shellBlend)
draw_text(xSet,ySet+50,"Current:"); draw_text(xSet+80,ySet+50,shellCurrent)
draw_text(xSet,ySet+60,"Eye Target:"); draw_text(xSet+80,ySet+60,eyeTarget)*/
