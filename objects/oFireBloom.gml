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
eName="Fire Bloom"
maxLife=1000
life=maxLife
atkPower=3
atkDefense=0
FIREresist=100
WATERresist=0
WINDresist=75
EARTHresist=75
questType=1
activateBoss=1

currentAttack=0
bossProgress=0
hitsTillHide=0
hideTime=0
hideThreshold=6

seedBurstTime=120
seedBurstAtk=0
seedBurstProg=0
teleportTime=0
hyperBeamCharge=0

seedBurstDelay=160
seedBurstAmt=6
seedBurstSpd=9
teleportDelay=240
hyperBeamDelay=1200

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
    scanText="It stays on the left platform and shoots seeds that explode. After it has been hit enough times, it will hide and boost its defenses. If you don't want it to do this, you will need to slow down your attacks on it. There is also a super attack that you should be aware of. It will flash rapidly and float, so you'll know when it is about to do that. It constantly charges power for this attack, but when in its defensive state, it charges much faster."
    activateBoss=2
  }

  if bActive=true and dieFade=0
  {
    if sprite_index=sFBloomIdle
    {
      if x>oCharacter.x
        image_xscale=-1
      else
        image_xscale=1
    }

    if sprite_index=sFBloomHide
    {
      FIREresist=100
      WATERresist=80
      WINDresist=90
      EARTHresist=90
    }
    else
    {
      FIREresist=100
      WATERresist=0
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
        sprite_index=sFBloomHide

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
          sprite_index=sFBloomIdle
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
          sprite_index=sFBloomAtk
          if image_xscale=1
            xOffset=16
          else
            xOffset=-16
        }

        if seedBurstAtk=1 //line burst
        {
          if seedBurstTime>=1025 and seedBurstTime mod seedBurstSpd=0
          {
            newAttack=instance_create(x+xOffset,y-36,oTBSeed)
            newAttack.type=1
            newAttack.atkPower=atkPower
            if image_xscale=1
              newAttack.xVel=2.5+(seedBurstProg/3)
            else
              newAttack.xVel=-(2.5+(seedBurstProg/3))
            newAttack.yVel=-(3.1+(seedBurstProg/3.5))
            newAttack.explodeDelay=35+seedBurstProg

            seedBurstProg+=1
            if seedBurstProg>=seedBurstAmt //end attack
            {
              sprite_index=sFBloomIdle
              currentAttack=0
              seedBurstProg=0
              seedBurstTime=0
            }
          }
        }
        else if seedBurstAtk=2 //arc seed
        {
          if seedBurstTime>=1025 and seedBurstTime mod seedBurstSpd=0
          {
            newAttack=instance_create(x+xOffset,y-36,oTBSeed)
            newAttack.type=1
            newAttack.atkPower=atkPower
            if image_xscale=1
              newAttack.xVel=1+(seedBurstProg/3)
            else
              newAttack.xVel=-(1+(seedBurstProg/3))
            newAttack.yVel=-(3+(seedBurstProg/10))
            newAttack.explodeDelay=60+seedBurstProg

            seedBurstProg+=1
            if seedBurstProg>=seedBurstAmt //end attack
            {
              sprite_index=sFBloomIdle
              currentAttack=0
              seedBurstProg=0
              seedBurstTime=0
            }
          }
        }
        else if seedBurstAtk=3 //big seed
        {
          if seedBurstTime>=1025 and seedBurstTime mod 15=0
          {
            for(i=0;i<7;i+=1)
            {
              newAttack=instance_create(x+xOffset,y-36,oTBSeed)
              newAttack.spreadDir=i
              if i>0
              {
                newAttack.x=x+xOffset+lengthdir_x(20,i*60-120)
                newAttack.y=y-36+lengthdir_y(20,i*60-120)
              }
              newAttack.type=2
              newAttack.atkPower=atkPower
              if image_xscale=1
                newAttack.xVel=3+(seedBurstProg/5)
              else
                newAttack.xVel=-(3+(seedBurstProg/5))
              newAttack.yVel=-(5+(seedBurstProg/8))
              newAttack.explodeDelay=30+seedBurstProg
            }

            seedBurstProg+=4
            if seedBurstProg>=seedBurstAmt //end attack
            {
              sprite_index=sFBloomIdle
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
          sprite_index=sFBloomHide
          hyperBeamDir=90
          hyperBeamCharge=10000
        }
        //else if hyperBeamCharge>=10001 and hyperBeamCharge<=10060
        //  y-=1
        //else if hyperBeamCharge>=10081 and hyperBeamCharge<=10190
        else if hyperBeamCharge>10000 and hyperBeamCharge<=10060
          y-=1*gDeltaTime
        else if hyperBeamCharge>10080 and hyperBeamCharge<=10190 and gDeltaDoTicks
        {
          for(i=0;i<2;i+=1)
          {
            newAttack=instance_create(x,y-24,oNormalBullet)
            newAttack.type=1
            newAttack.sprite_index=sTBSeed
            newAttack.image_blend=image_blend
            newAttack.image_xscale=0.75
            newAttack.image_yscale=0.75
            //newAttack.direction=hyperBeamDir+(i*180)
            newAttack._direction=hyperBeamDir+(i*180) //60fps change: _direction (it moves by _speed/_direction)
            newAttack.image_speed=0.4
            newAttack.atkPower=atkPower
            newAttack.bulletSpeed=7
          }
          hyperBeamDir+=5
        }
        //else if hyperBeamCharge>=10191 and hyperBeamCharge<=10250
        //  y+=1
        else if hyperBeamCharge>10190 and hyperBeamCharge<=10250
          y+=1*gDeltaTime
        else if hyperBeamCharge>=10251
        {
          y=yGround
          image_blend=baseColor
          sprite_index=sFBloomIdle
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

    if hitsTillHide<hideThreshold and other.elementType=2
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
      x=irandom_range(112,304)
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
