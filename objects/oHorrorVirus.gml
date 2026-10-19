#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.1
bShowHealthBar=false
bCanTakeDamage=false

//Enemy base statistics
eName="Suffering"
maxLife=6000
life=maxLife
atkPower=3
atkDefense=0
FIREresist=0
WATERresist=0
WINDresist=0
EARTHresist=0
bIsBoss=true
bossProgress=0

eventProg=0
eventTime=0
backExtTime=0

phase=0
phaseAmp=1
phaseTime=0

bigHandTime=0
bigHandDelay=310

fireUse=0
waterUse=0
windUse=0
earthUse=0
elementRemoval=0
buttonAttempt=0
elementString=""

for(i=0;i<50;i+=1)
{
  var tEffect;
  tEffect=instance_create(x-28+random(56),y-28+random(36),oEffect)
  tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5)
}

scanText="Nearly everything is blocked and all the data keeps changing rapidly. The only consistent piece of data I found is that snake head will try to track you. All I can think to tell you on this is you need to stay away."
jeremyText="It has me locked out of everything. Chao says she can access a few things, but I'm completely locked out. It's like it... knows me."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()

  //Phase effect when hit
  //phase+=0.025
  //if phaseTime>0
  //60fps change: the wave moves per 30fps tick, and the hit wobble's count and size step once per 30fps tick
  //(gDeltaDoTicks; it's drawn as normal when phaseTime is 0)
  phase+=0.025*gDeltaTime
  if phaseTime>0 and gDeltaDoTicks
  {
    phaseTime-=1
    if phaseTime>15
    {
      if phaseAmp<10 {phaseAmp+=1}
    }
    else if phaseTime<20
    {
      if phaseAmp>1 {phaseAmp-=1}
    }
  }

  //Power scale
  if bossProgress=28
  {
    if oPlayer1.life<=12
    {
      with oDamagableBase {atkPower=2}
    }
    {
      with oDamagableBase {atkPower=3}
    }
  }
  else
  {
    if oPlayer1.life<=12
    {
      with oDamagableBase {atkPower=4}
    }
    else
    {
      with oDamagableBase {atkPower=6}
    }
  }

  //if oGame.time mod 4=0 //Worms dropping
  if oGame.time mod (4/gDeltaTime)=0 //Worms dropping //60fps change: every 4 30fps ticks (oGame.time counts frames)
  {
    var tEffect;
    tEffect=instance_create(x-28+random(56),y+random(8),oEffect)
    tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5)
  }

  if eventProg=0 //Wait for arms to shrink back
  {
    if !instance_exists(oVH_ArmReachingUp)
    {
      oEvEscape.sceneProgress=0
      global.currentBoss="Horror"
      global.gameProgress=34
      bCanTakeDamage=true
      bShowHealthBar=true
      showBossHP=instance_create(0,0,oBossLifeDisplay)
      showBossHP.bossID=id
      eventProg=1
    }
  }
  else if eventProg=1 //Grow extends
  {
    for(i=0;i<6;i+=1)
    {
      extend[i]=instance_create(x,y,oVH_Extend)
      extend[i].myPart=i
      if i=0 {extend[i].type=0}
      else if i=5 {extend[i].type=2; extend[i].sprite_index=sVH_EndFace}
      else {extend[i].type=1}
    }
    eventProg=2
  }
  else if eventProg=2 //Normal Attack Sequence
  {
    //Back extends
    //backExtTime+=1
    backExtTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if backExtTime=1
    {
      tBackExt=instance_create(x-36,y,oVH_BackExtend); tBackExt.yOffset=-29
      tBackExt=instance_create(x-22,y,oVH_BackExtend); tBackExt.yOffset=5
    }
    else if backExtTime=11
    {
      tBackExt=instance_create(x-51,y,oVH_BackExtend); tBackExt.yOffset=-42
      tBackExt=instance_create(x-35,y,oVH_BackExtend); tBackExt.yOffset=14
    }
    else if backExtTime=21
    {
      tBackExt=instance_create(x-73,y,oVH_BackExtend); tBackExt.yOffset=-55
      tBackExt=instance_create(x-57,y,oVH_BackExtend); tBackExt.yOffset=21
    }
    else if backExtTime=31
    {
      tBackExt=instance_create(x-96,y,oVH_BackExtend); tBackExt.yOffset=-62
      tBackExt=instance_create(x-77,y,oVH_BackExtend); tBackExt.yOffset=27
    }
    else if backExtTime=41
    {
      tBackExt=instance_create(x-118,y,oVH_BackExtend); tBackExt.yOffset=-53
      tBackExt=instance_create(x-98,y,oVH_BackExtend); tBackExt.yOffset=31
    }
    else if backExtTime=51 {tBackExt=instance_create(x-115,y,oVH_BackExtend); tBackExt.yOffset=28}

    //Big Hand attack
    //bigHandTime+=1
    bigHandTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if bigHandTime>=bigHandDelay
    {
      newAttack=instance_create(oPlayer1.x,320,oVH_BigHand)
      newAttack.atkPower=atkPower
      bigHandTime=0
    }
  }

  //---------------------------------------- BATTLE SEQUENCE ----------------------------------------
  //60fps change: eventTime counts 30fps ticks (+=1*gDeltaTime), and the life it regains is per 30fps tick. The checks
  //that end a part use >= (the same as = at 30fps), so the fight still goes on if the frame rate changed mid-count
  if life<=5300 and bossProgress=0 //Send Ability Steal
  {
    instance_create(x,y,oVH_StealAbility)
    bossProgress+=1
  }
  else if bossProgress=2 //First elemental ability removal
  {
    event_user(1)
    bossProgress+=1
  }
  else if bossProgress=3 //Check for button attempts
  {
    //if life<5200 {life+=2}
    if life<5200 and gDeltaDoTicks {life+=2} //60fps change: 2 per 30fps tick, so life stays a whole number as at 30fps (2*gDeltaTime a frame gave it decimals)
    if buttonAttempt>=3
    {
      msgCreate(string("What the heck is going on? Why can't I use ") +string(elementString) +string("?#I've tried it a few times."),0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=140
      bossProgress+=1
    }
  }
  else if life<=5000 and bossProgress=4 //Send Ability Steal
  {
    instance_create(x,y,oVH_StealAbility)
    bossProgress+=1
  }
  else if life<=5000 and bossProgress=6 //Air dash removal
  {
    event_user(0)
    global.hasSuaveToken=0
    bossProgress+=1
  }
  else if bossProgress=7 //Jeremy speaks about abilities being taken away
  {
    //if life<4800 {life+=2}
    if life<4800 and gDeltaDoTicks {life+=2} //60fps change: see bossProgress 3
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime=60
    {
      msgCreate("It's taking away your abilities... How the heck?",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=110
    }
    else if eventTime=170
    {
      msgCreate("It just took away your air dash.",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=80
    }
    else if eventTime=250
    {
      msgCreate("What do I do?",0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=60
    }
    else if eventTime=310
    {
      msgCreate("Just do the best you can. I'm sorry Claire,#I don't know how it's doing this.",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=140
    }
    //else if eventTime=450 //Bring in side hands
    else if eventTime>=450 //Bring in side hands
    {
      event_user(2)
      eventTime=0
      bossProgress+=1
    }
  }
  else if life<=4700 and bossProgress=8 //Send Ability Steal
  {
    instance_create(x,y,oVH_StealAbility)
    bossProgress+=1
  }
  else if life<=4700 and bossProgress=10 //Second elemental ability removal
  {
    event_user(0)
    if global.canUseFire=1 {global.canUseFire=0}
    else if global.canUseWater=1 {global.canUseWater=0}
    else if global.canUseEarth=1 {global.canUseEarth=0}
    else if global.canUseWind=1 {global.canUseWind=0}
    bigHandDelay-=60
    oVH_Extend.fireDelay-=30
    bossProgress+=1
  }
  else if bossProgress=11 //Speak about another element taken away
  {
    //if life<4500 {life+=2}
    if life<4500 and gDeltaDoTicks {life+=2} //60fps change: see bossProgress 3
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime=60
    {
      msgCreate("There went another element...",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=80
    }
    else if eventTime=140
    {
      msgCreate("The Virus is draining away all your abilities!",0,oMessagePerson,global.mainCharacters[4])
      newMessage.fadingTime=110
    }
    else if eventTime=250
    {
      msgCreate("Keep it up Claire.#Jerry should be here soon to help you out.",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=140
    }
    //else if eventTime=390
    else if eventTime>=390
    {
      eventTime=0
      bossProgress+=1
    }
  }
  else if life<=4300 and bossProgress=12 //Send Ability Steal
  {
    instance_create(x,y,oVH_StealAbility)
    bossProgress+=1
  }
  else if life<=4300 and bossProgress=14 //Wall jump removal
  {
    event_user(0)
    global.hasWallGrinder=0
    bigHandDelay-=30
    oVH_Extend.fireDelay-=10
    bossProgress+=1
  }
  else if life<=4100 and bossProgress=15 //Send Ability Steal
  {
    instance_create(x,y,oVH_StealAbility)
    bossProgress+=1
  }
  else if life<=4100 and bossProgress=17 //Third elemental ability removal
  {
    event_user(0)
    if global.canUseFire=1 {global.canUseFire=0}
    else if global.canUseWater=1 {global.canUseWater=0}
    else if global.canUseEarth=1 {global.canUseEarth=0}
    else if global.canUseWind=1 {global.canUseWind=0}
    bossProgress+=1
  }
  else if bossProgress=18 //Send Ability Steal
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    //if eventTime=150
    if eventTime>=150
    {
      instance_create(x,y,oVH_StealAbility)
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=20 //Claire complains
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime=1
    {
      event_user(0)
      global.hasAwesomeShoes=0
      bigHandDelay-=30
      oVH_Extend.fireDelay-=10
    }
    else if eventTime=30
    {
      msgCreate("Oh come on! Even my dash!",0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=70
    }
    //else if eventTime=100
    else if eventTime>=100
    {
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=21 //Send Ability Steal
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    //if eventTime=60
    if eventTime>=60
    {
      instance_create(x,y,oVH_StealAbility)
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=23 //Fourth elemental ability removal
  {
    event_user(0)
    global.canUseFire=0; global.canUseWater=0; global.canUseEarth=0; global.canUseWind=0
    bossProgress+=1
  }
  else if bossProgress=24 //Claire speaks about no offensive abilities
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime=100
    {
      msgCreate("Jeremy, I can't even fight back anymore.",0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=80
    }
    else if eventTime=180
    {
      msgCreate("I know. I... I'm trying, but the Virus knows everything I'm doing.#It just cuts me off at everything I try.",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=170
    }
    //else if eventTime=350
    else if eventTime>=350
    {
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=25 //Send Ability Steal
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    //if eventTime=70
    if eventTime>=70
    {
      instance_create(x,y,oVH_StealAbility)
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=27 //Jump taken
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime=1
    {
      event_user(0)
      global.hasWindBoots=0
    }
    else if eventTime=40
    {
      msgCreate("I CAN'T EVEN JUMP!",0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=60
    }
    else if eventTime=100
    {
      msgCreate("Hold on Claire, I'll be there in just a second!#I still have my abilities.",0,oMessagePerson,global.mainCharacters[0])
      newMessage.fadingTime=150
    }
    //else if eventTime=230
    else if eventTime>=230
    {
      for(i=0;i<5;i+=1)
      {
        tSideArms=instance_create(room_width+120,64+(i*64),oVH_OuterArms)
        tSideArms.type=6
        tSideArms.image_angle=90
        tSideArms.atkPower=atkPower
      }
      bigHandDelay-=30
      oVH_Extend.fireDelay-=20
      eventTime=0
      bossProgress+=1
    }
  }
  else if bossProgress=28 //Boost difficulty
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime
    if eventTime mod 90=0
    {
      if bigHandDelay>50 {bigHandDelay-=10}
      if oVH_Extend.fireDelay>20 {oVH_Extend.fireDelay-=10}
    }
  }

  //if life<3000 {life+=2}
  if life<3000 and gDeltaDoTicks {life+=2} //60fps change: 2 per 30fps tick, so life stays a whole number as at 30fps (see bossProgress 3)
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
    if other.elementType=1 {fireUse+=1}
    else if other.elementType=2 {waterUse+=1}
    else if other.elementType=3 {windUse+=1}
    else if other.elementType=4 {earthUse+=1}

    if (other.elementType=1 or other.elementType=4) and phaseTime=0
      phaseTime=30
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<12;i+=1)
{
  var tEffect;
  tEffect=instance_create(oPlayer1.x,oPlayer1.y-26,oEffect)
  tEffect.sprite_index=sVirusShot; tEffect.image_speed=0.1+random(0.1); tEffect.decay=20
  tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
elementRemoval=1
if waterUse>fireUse {elementRemoval=2}
if windUse>fireUse {elementRemoval=3}
if earthUse>fireUse {elementRemoval=4}

if elementRemoval=2
{
  if windUse>waterUse {elementRemoval=3}
  if earthUse>waterUse {elementRemoval=4}
}
else if elementRemoval=3
{
  if waterUse>windUse {elementRemoval=2}
  if earthUse>windUse {elementRemoval=4}
}
else if elementRemoval=4
{
  if waterUse>earthUse {elementRemoval=2}
  if windUse>earthUse {elementRemoval=3}
}

if elementRemoval=1 {global.canUseFire=0; elementString="Fire"}
else if elementRemoval=2 {global.canUseWater=0; elementString="Water"}
else if elementRemoval=3 {global.canUseWind=0; elementString="Wind"}
else if elementRemoval=4 {global.canUseEarth=0; elementString="Earth"}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tSideArms;
for(i=0;i<3;i+=1)
{
  tSideArms=instance_create(6272+(i*64),room_height+120,oVH_OuterArms)
  tSideArms.type=0
  tSideArms.atkPower=atkPower
}
for(i=0;i<5;i+=1)
{
  tSideArms=instance_create(6464+(i*64),room_height+120,oVH_OuterArms)
  tSideArms.type=4
  tSideArms.atkPower=atkPower
}

for(i=0;i<3;i+=1)
{
  tSideArms=instance_create(6272+(i*64),-120,oVH_OuterArms)
  tSideArms.type=1
  tSideArms.image_angle=180
  tSideArms.atkPower=atkPower
}
for(i=0;i<5;i+=1)
{
  tSideArms=instance_create(6464+(i*64),-120,oVH_OuterArms)
  tSideArms.type=5
  tSideArms.image_angle=180
  tSideArms.atkPower=atkPower
}

for(i=0;i<6;i+=1)
{
  tSideArms=instance_create(6120,32+(i*64),oVH_OuterArms)
  tSideArms.type=2
  tSideArms.image_angle=270
  tSideArms.atkPower=atkPower
}

for(i=0;i<6;i+=1)
{
  tSideArms=instance_create(room_width+120,32+(i*64),oVH_OuterArms)
  tSideArms.type=3
  tSideArms.image_angle=90
  tSideArms.atkPower=atkPower
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if phaseTime=0
  event_inherited()
else
  draw_sprite_wave(sprite_index,image_index,x,y,1,phaseAmp,2,phase)

/*draw_set_alpha(1)
draw_set_color(c_white)
draw_text(x-32,y-80,life)
draw_text(x+32,y-120,fireUse)
draw_text(x+32,y-100,waterUse)
draw_text(x+32,y-80,windUse)
draw_text(x+32,y-60,earthUse)
