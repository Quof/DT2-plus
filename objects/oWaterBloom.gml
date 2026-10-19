#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-42,14,-1)
bShowHealthBar=false
image_speed=0.16

//Enemy base statistics
eName="Water Bloom"
maxLife=1000
life=maxLife
atkPower=3
atkDefense=0
FIREresist=0
WATERresist=100
WINDresist=75
EARTHresist=75
questType=1
activateBoss=1

currentAttack=0
bossProgress=0
hitsTillHide=0
hideTime=0
hideThreshold=6

seedBurstTime=80
seedBurstAtk=0
seedBurstProg=0
teleportTime=0
hyperBeamCharge=0

seedBurstDelay=180
seedBurstAmt=6
seedBurstSpd=9
teleportDelay=250
hyperBeamDelay=1400

teleView=0

xCenter=352
yGround=304
roomSpan=320
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
    bActive=true
    scanText="It stays on the right platform and shoots seeds that explode into spike-tipped logs. It has the same hiding behavior as the Fire Bloom, its super attack is a bit different though as well as its timing. You may want to force one into a defensive position to make sure they don't both use their super attack at the same time."
    activateBoss=2
  }

  if bActive=true and dieFade=0
  {
    if sprite_index=sWBloomIdle
    {
      if x>oCharacter.x
        image_xscale=-1
      else
        image_xscale=1
    }

    if sprite_index=sWBloomHide
    {
      FIREresist=80
      WATERresist=100
      WINDresist=90
      EARTHresist=90
    }
    else
    {
      FIREresist=0
      WATERresist=100
      WINDresist=75
      EARTHresist=75
    }

    //60fps change: hyperBeamCharge, hideTime and seedBurstTime count 30fps ticks (+=N*gDeltaTime; the "mod" spawn times
    //only land on whole numbers, as at 30fps). Something done every tick in ticks N-M runs from right after tick N-1
    //(>N-1). The beam's shots and flashing colour happen once per tick (gDeltaDoTicks). teleportTime (Draw) is the same
    if teleportTime<teleportDelay
    {
      if currentAttack=0
      {
        //hyperBeamCharge+=1
        hyperBeamCharge+=1*gDeltaTime
      }
      else
      {
        if hyperBeamCharge<hyperBeamDelay-5
          //hyperBeamCharge+=1
          hyperBeamCharge+=1*gDeltaTime
      }

      if hitsTillHide>=hideThreshold and currentAttack=0
      {
        sprite_index=sWBloomHide

        if hyperBeamCharge<hyperBeamDelay-5
        {
          //hyperBeamCharge+=4
          //hideTime+=1
          hyperBeamCharge+=4*gDeltaTime
          hideTime+=1*gDeltaTime
        }

        if hideTime>=180
        {
          hideTime=0
          hitsTillHide=0
          sprite_index=sWBloomIdle
        }
      }
      else
      {
        if hitsTillHide>0
        {
          //hideTime+=1
          hideTime+=1*gDeltaTime
          if hideTime>=60
          {
            hideTime=0
            hitsTillHide-=1
          }
        }
      }

      //---------- ATTACK: SEED BURST ----------
      if (hitsTillHide<hideThreshold or currentAttack=1) and hyperBeamCharge<hyperBeamDelay
        //seedBurstTime+=1
        seedBurstTime+=1*gDeltaTime

      if seedBurstTime>=seedBurstDelay
      {
        if seedBurstTime<1000
        {
          currentAttack=1
          seedBurstAtk+=1
          if seedBurstAtk=4
            seedBurstAtk=1
          seedBurstTime=1000
          sprite_index=sWBloomAtk
          if image_xscale=1
            xOffset=16
          else
            xOffset=-16
        }

        if seedBurstAtk=1 //log seeds
        {
          if seedBurstTime>=1025 and seedBurstTime mod seedBurstSpd=0
          {
            newAttack=instance_create(x+xOffset,y-36,oTBSeed)
            newAttack.image_blend=c_orange
            newAttack.type=3
            newAttack.atkPower=atkPower
            if image_xscale=1
              newAttack.xVel=3+(seedBurstProg/3)
            else
              newAttack.xVel=-(3+(seedBurstProg/3))
            newAttack.yVel=-(3+(seedBurstProg/3.5))
            newAttack.explodeDelay=1000

            seedBurstProg+=1
            if seedBurstProg>=seedBurstAmt //end attack
            {
              sprite_index=sWBloomIdle
              currentAttack=0
              seedBurstProg=0
              seedBurstTime=0
            }
          }
        }
        else if seedBurstAtk=2 //instant log seeds
        {
          if seedBurstTime>=1035
          {
            for(i=0;i<seedBurstAmt;i+=1)
            {
              newAttack=instance_create(x+xOffset,y-36,oTBSeed)
              newAttack.image_blend=c_orange
              newAttack.type=3
              newAttack.atkPower=atkPower
              if image_xscale=1
                newAttack.xVel=1+(i/2.5)
              else
                newAttack.xVel=-(1+(i/2.5))
              newAttack.yVel=-(3+(i/2.5))
              newAttack.explodeDelay=1000
            }

            sprite_index=sWBloomIdle
            currentAttack=0
            seedBurstProg=0
            seedBurstTime=0
          }
        }
        else if seedBurstAtk=3 //burst log seeds
        {
          if seedBurstTime>=1025 and seedBurstTime mod seedBurstSpd*2=0
          {
            newAttack=instance_create(x+xOffset,y-36,oTBSeed)
            newAttack.image_blend=c_orange
            newAttack.type=4
            newAttack.atkPower=atkPower
            if image_xscale=1
              newAttack.xVel=1+(seedBurstProg/2.8)
            else
              newAttack.xVel=-(1+(seedBurstProg/2.8))
            newAttack.yVel=-(3+(seedBurstProg/3.5))
            newAttack.explodeDelay=30+seedBurstProg

            seedBurstProg+=2
            if seedBurstProg>=seedBurstAmt //end attack
            {
              sprite_index=sWBloomIdle
              currentAttack=0
              seedBurstProg=0
              seedBurstTime=0
            }
          }
        }
      }
      //---------- SPECIAL ATTACK: HYPER BEAM ----------
      if hyperBeamCharge>=hyperBeamDelay
      {
        if teleportTime>=teleportDelay
        {
          teleView=0
          teleportTime=0
        }
        if seedBurstTime>=seedBurstDelay
        {
          currentAttack=0
          seedBurstProg=0
          seedBurstTime=0
        }

        //image_blend=make_color_rgb(random(255),random(255),random(255))
        if gDeltaDoTicks {image_blend=make_color_rgb(random(255),random(255),random(255))}
        if hyperBeamCharge<10000
        {
          sprite_index=sWBloomHide
          hyperBeamDir1=90
          hyperBeamDir2=90
          hyperBeamCharge=10000
        }
        //else if hyperBeamCharge>=10001 and hyperBeamCharge<=10060
        //  y-=1
        //else if hyperBeamCharge>=10081 and hyperBeamCharge<=10190
        else if hyperBeamCharge>10000 and hyperBeamCharge<=10060
          y-=1*gDeltaTime
        else if hyperBeamCharge>10080 and hyperBeamCharge<=10190 and gDeltaDoTicks
        {
          newAttack=instance_create(x,y-24,oNormalBullet)
          newAttack.type=1
          newAttack.sprite_index=sTBSeed
          newAttack.image_blend=image_blend
          newAttack.image_xscale=0.75
          newAttack.image_yscale=0.75
          //newAttack.direction=hyperBeamDir1
          newAttack._direction=hyperBeamDir1 //60fps change: _direction (it moves by _speed/_direction)
          newAttack.image_speed=0.4
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=5

          newAttack=instance_create(x,y-24,oNormalBullet)
          newAttack.type=1
          newAttack.sprite_index=sTBSeed
          newAttack.image_blend=image_blend
          newAttack.image_xscale=0.75
          newAttack.image_yscale=0.75
          //newAttack.direction=hyperBeamDir2
          newAttack._direction=hyperBeamDir2 //60fps change: _direction (it moves by _speed/_direction)
          newAttack.image_speed=0.4
          newAttack.atkPower=atkPower
          newAttack.bulletSpeed=5

          hyperBeamDir1+=6
          hyperBeamDir2-=6
        }
        //else if hyperBeamCharge>=10191 and hyperBeamCharge<=10250
        //  y+=1
        else if hyperBeamCharge>10190 and hyperBeamCharge<=10250
          y+=1*gDeltaTime
        else if hyperBeamCharge>=10251
        {
          y=yGround
          image_blend=baseColor
          sprite_index=sWBloomIdle
          hyperBeamCharge=0
        }
      }
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

    if hitsTillHide<hideThreshold and other.elementType=1
    {
      hitsTillHide+=1
      hideTime=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//---------- ACTION: TELEPORT ----------
if global.gamePaused=false
{
  //60fps change: teleportTime counts 30fps ticks (see Step); each part of the teleport runs on all the frames of its ticks
  //(>N-1), and the hiding at its start happens on that tick's first frame (the same checks as before at 30fps)
  if currentAttack=0 and hyperBeamCharge<hyperBeamDelay
    //teleportTime+=1
    teleportTime+=1*gDeltaTime

  if teleportTime>=teleportDelay
  {
    if teleportTime<1000
      teleportTime=1000
    //else if teleportTime>=1001 and teleportTime<=1015
    //  teleView+=1.5
    //else if teleportTime>=1031 and teleportTime<=1050
    else if teleportTime>1000 and teleportTime<=1015
      teleView+=1.5*gDeltaTime
    else if teleportTime>1030 and teleportTime<=1050
    {
      //if teleportTime=1031
      if teleportTime=1030+gDeltaTime
      {
        bCanDealDamage=false
        bCanTakeDamage=false
      }
      //y-=2
      //image_alpha-=0.05
      y-=2*gDeltaTime
      image_alpha-=0.05*gDeltaTime
    }
    //else if teleportTime>=1061 and teleportTime<=1075
    //  teleView-=1.5
    else if teleportTime>1060 and teleportTime<=1075
      teleView-=1.5*gDeltaTime
    else if teleportTime=1080
      x=irandom_range(400,592)
    //else if teleportTime>=1091 and teleportTime<=1105
    //  teleView+=1.5
    //else if teleportTime>=1111 and teleportTime<=1130
    else if teleportTime>1090 and teleportTime<=1105
      teleView+=1.5*gDeltaTime
    else if teleportTime>1110 and teleportTime<=1130
    {
      if teleportTime=1130
      {
        bCanDealDamage=true
        bCanTakeDamage=true
      }
      //y+=2
      //image_alpha+=0.05
      y+=2*gDeltaTime
      image_alpha+=0.05*gDeltaTime
    }
    //else if teleportTime>=1131 and teleportTime<=1145
    //  teleView-=1.5
    else if teleportTime>1130 and teleportTime<=1145
      teleView-=1.5*gDeltaTime
    else if teleportTime>=1146
      teleportTime=0

    draw_set_alpha(0.3)
    draw_set_color(c_red)
    draw_rectangle(x-teleView,0,x+teleView,yGround,0)
  }
}
