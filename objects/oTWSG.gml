#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Quadradic Wall Shifting Golem"
maxLife=800
life=maxLife
atkPower=3
atkDefense=0
FIREresist=75
WATERresist=90
WINDresist=100
EARTHresist=0
bIsBoss=true
barAmount=1
questType=1
bCanDealDamage=false
activateBoss=0
bossProgress=0

xCenter=320
roomSpan=256

for(i=0;i<4;i+=1)
{
  armTime[i]=-i*10
  wallTarget[i]=0
  wallSpikeTime[i]=i*30
}
armAtkTime=180
armAtkDelay=190
wallSpikeDelay=180
wallSpikePrompt=60

//----- Create Arms -----
arms[0]=instance_create(x,y,oTWSG_Leg)
arms[0].type=0; arms[0].arm=0; arms[0].angleSet=35
arms[1]=instance_create(x,y,oTWSG_Leg)
arms[1].type=1; arms[1].arm=1
arms[2]=instance_create(x,y,oTWSG_Leg)
arms[2].type=2; arms[2].arm=2
arms[3]=instance_create(x,y,oTWSG_Leg)
arms[3].type=3; arms[3].arm=3

arms[4]=instance_create(x,y,oTWSG_Leg)
arms[4].type=0; arms[4].arm=4; arms[4].angleSet=305
arms[5]=instance_create(x,y,oTWSG_Leg)
arms[5].type=1; arms[5].arm=5
arms[6]=instance_create(x,y,oTWSG_Leg)
arms[6].type=2; arms[6].arm=6
arms[7]=instance_create(x,y,oTWSG_Leg)
arms[7].type=3; arms[7].arm=7

arms[8]=instance_create(x,y,oTWSG_Leg)
arms[8].type=0; arms[8].arm=8; arms[8].angleSet=125
arms[9]=instance_create(x,y,oTWSG_Leg)
arms[9].type=1; arms[9].arm=9
arms[10]=instance_create(x,y,oTWSG_Leg)
arms[10].type=2; arms[10].arm=10
arms[11]=instance_create(x,y,oTWSG_Leg)
arms[11].type=3; arms[11].arm=11

arms[12]=instance_create(x,y,oTWSG_Leg)
arms[12].type=0; arms[12].arm=12; arms[12].angleSet=215
arms[13]=instance_create(x,y,oTWSG_Leg)
arms[13].type=1; arms[13].arm=13
arms[14]=instance_create(x,y,oTWSG_Leg)
arms[14].type=2; arms[14].arm=14
arms[15]=instance_create(x,y,oTWSG_Leg)
arms[15].type=3; arms[15].arm=15

//----- Create Walls -----
wall[0]=instance_create(576,144,oTWSG_Wall)
wall[0].image_xscale=12; wall[0].image_yscale=4; wall[0].drawType=0; wall[0].depth=999997
wall[1]=instance_create(576,208,oTWSG_Wall)
wall[1].image_xscale=12; wall[1].image_yscale=4; wall[1].drawType=0; wall[1].depth=999997
wall[2]=instance_create(576,272,oTWSG_Wall)
wall[2].image_xscale=12; wall[2].image_yscale=4; wall[2].drawType=0; wall[2].depth=999997

wall[3]=instance_create(-128,144,oTWSG_Wall)
wall[3].image_xscale=12; wall[3].image_yscale=4; wall[3].drawType=1; wall[3].depth=999997
wall[4]=instance_create(-128,208,oTWSG_Wall)
wall[4].image_xscale=12; wall[4].image_yscale=4; wall[4].drawType=1; wall[4].depth=999997
wall[5]=instance_create(-128,272,oTWSG_Wall)
wall[5].image_xscale=12; wall[5].image_yscale=4; wall[5].drawType=1; wall[5].depth=999997

wall[6]=instance_create(64,336,oTWSG_Wall)
wall[6].image_xscale=5; wall[6].image_yscale=12; wall[6].drawType=2
wall[7]=instance_create(144,336,oTWSG_Wall)
wall[7].image_xscale=5; wall[7].image_yscale=12; wall[7].drawType=3

wall[8]=instance_create(416,336,oTWSG_Wall)
wall[8].image_xscale=5; wall[8].image_yscale=12; wall[8].drawType=2
wall[9]=instance_create(496,336,oTWSG_Wall)
wall[9].image_xscale=5; wall[9].image_yscale=12; wall[9].drawType=3

wall[10]=instance_create(224,304,oTWSG_Wall)
wall[10].image_xscale=4; wall[10].image_yscale=12; wall[10].drawType=4
wall[11]=instance_create(352,304,oTWSG_Wall)
wall[11].image_xscale=4; wall[11].image_yscale=12; wall[11].drawType=4
wall[12]=instance_create(288,272,oTWSG_Wall)
wall[12].image_xscale=4; wall[12].image_yscale=12; wall[12].drawType=4
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with oTWSG_Leg {instance_destroy()}
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
    scanText="This is from 'Maui Mallard in Cold Shadow.'"
    activateBoss=2
  }

  if bActive=true and dieFade=0
  {
    //60fps change: the timers below count 30fps ticks (+=1*gDeltaTime; reset to whole numbers, so the "=N" checks land
    //on their ticks). The arm resets use >= (the same as = at 30fps), so they still happen if the frame rate changed
    //mid-count. The walls are moving solids: they read xVel/yVel on 30fps ticks (gameStepEvent)
    //---------- Arm/Wall Control 1 ----------
    //armTime[0]+=1
    armTime[0]+=1*gDeltaTime
    if armTime[0]=50 //Choose wall
    {
      wallTarget[0]=choose(0,1,2)
      arms[3].myTarget=wall[wallTarget[0]]
      arms[3].xOffset=0; arms[3].yOffset=32
    }
    else if armTime[0]=70 //Move wall out
    {
      wall[wallTarget[0]].bMoving=1; wall[wallTarget[0]].xVel=-2
      wall[wallTarget[0]].targetX=448; wall[wallTarget[0]].targetY=0
    }
    else if armTime[0]=230 //Move wall in
    {
      wall[wallTarget[0]].bMoving=1; wall[wallTarget[0]].xVel=2
      wall[wallTarget[0]].targetX=576; wall[wallTarget[0]].targetY=0
    }
    //else if armTime[0]=300 //Reset arm
    else if armTime[0]>=300 //Reset arm
    {
      arms[3].myTarget=noone
      armTime[0]=irandom(10)
    }
    //---------- Arm/Wall Control 2 ----------
    //armTime[1]+=1
    armTime[1]+=1*gDeltaTime
    if armTime[1]=60 //Choose wall
    {
      wallTarget[1]=choose(3,4,5)
      arms[11].myTarget=wall[wallTarget[1]]
      arms[11].xOffset=192; arms[11].yOffset=32
    }
    else if armTime[1]=80 //Move wall out
    {
      wall[wallTarget[1]].bMoving=1; wall[wallTarget[1]].xVel=2
      wall[wallTarget[1]].targetX=0; wall[wallTarget[1]].targetY=0
    }
    else if armTime[1]=240 //Move wall in
    {
      wall[wallTarget[1]].bMoving=1; wall[wallTarget[1]].xVel=-2
      wall[wallTarget[1]].targetX=-128; wall[wallTarget[1]].targetY=0
    }
    //else if armTime[1]=310 //Reset arm
    else if armTime[1]>=310 //Reset arm
    {
      arms[11].myTarget=noone
      armTime[1]=irandom(10)
    }
    //---------- Arm/Wall Control 3 ----------
    //armTime[2]+=1
    armTime[2]+=1*gDeltaTime
    if armTime[2]=70 //Choose wall
    {
      wallTarget[2]=choose(6,7,10)
      arms[15].myTarget=wall[wallTarget[2]]
      arms[15].xOffset=40; arms[15].yOffset=0
    }
    else if armTime[2]=90 //Move wall out
    {
      wall[wallTarget[2]].bMoving=1; wall[wallTarget[2]].yVel-=2
      wall[wallTarget[2]].targetX=0
      if wallTarget[2]=6 or wallTarget[2]=7 {wall[wallTarget[2]].targetY=240}
      else if wallTarget[2]=10 {wall[wallTarget[2]].targetY=208}
    }
    else if armTime[2]=250 //Move wall in
    {
      wall[wallTarget[2]].bMoving=1; wall[wallTarget[2]].yVel=2
      wall[wallTarget[2]].targetX=0
      if wallTarget[2]=6 or wallTarget[2]=7 {wall[wallTarget[2]].targetY=336}
      else if wallTarget[2]=10 {wall[wallTarget[2]].targetY=304}
    }
    //else if armTime[2]=320 //Reset arm
    else if armTime[2]>=320 //Reset arm
    {
      arms[15].myTarget=noone
      armTime[2]=irandom(10)
    }
    //---------- Arm/Wall Control 4 ----------
    //armTime[3]+=1
    armTime[3]+=1*gDeltaTime
    if armTime[3]=80 //Choose wall
    {
      wallTarget[3]=choose(8,9,11)
      arms[7].myTarget=wall[wallTarget[3]]
      arms[7].xOffset=40; arms[7].yOffset=0
    }
    else if armTime[3]=90 //Move wall out
    {
      wall[wallTarget[3]].bMoving=1; wall[wallTarget[3]].yVel-=2
      wall[wallTarget[3]].targetX=0
      if wallTarget[3]=8 or wallTarget[3]=9 {wall[wallTarget[3]].targetY=240}
      else if wallTarget[3]=11 {wall[wallTarget[3]].targetY=208}
    }
    else if armTime[3]=260 //Move wall in
    {
      wall[wallTarget[3]].bMoving=1; wall[wallTarget[3]].yVel=2
      wall[wallTarget[3]].targetX=0
      if wallTarget[3]=8 or wallTarget[3]=9 {wall[wallTarget[3]].targetY=336}
      else if wallTarget[3]=11 {wall[wallTarget[3]].targetY=304}
    }
    //else if armTime[3]=330 //Reset arm
    else if armTime[3]>=330 //Reset arm
    {
      arms[7].myTarget=noone
      armTime[3]=irandom(10)
    }

    //----- Normal Attack: Arm Ball -----
    //armAtkTime+=1
    armAtkTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if armAtkTime>=armAtkDelay
    {
      arms[3].circleRad=25
      arms[7].circleRad=25
      arms[11].circleRad=25
      arms[15].circleRad=25
      armAtkTime=-30
    }

    //----- Normal Attack: Wall Spike -----
    for(i=0;i<4;i+=1)
    {
      //wallSpikeTime[i]+=1
      wallSpikeTime[i]+=1*gDeltaTime //60fps change: counts 30fps ticks
      if wallSpikeTime[i]>=wallSpikeDelay
      {
        var tNewSpike;
        if i=0 //Left
        {
          tNewSpike=instance_create(48,oPlayer1.y-26,oTWSG_Spike)
          tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower
          wallSpikeTime[i]=irandom(10)
        }
        else if i=1 //Right
        {
          tNewSpike=instance_create(592,oPlayer1.y-26,oTWSG_Spike)
          //tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike.direction=180; tNewSpike.image_angle=180
          tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike._direction=180; tNewSpike.image_angle=180 //60fps change: _direction (it moves by _speed/_direction)
          wallSpikeTime[i]=irandom(10)
        }
        else if i=2 //Top
        {
          tNewSpike=instance_create(oPlayer1.x,64,oTWSG_Spike)
          //tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike.direction=270; tNewSpike.image_angle=270
          tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike._direction=270; tNewSpike.image_angle=270 //60fps change: _direction (it moves by _speed/_direction)
          wallSpikeTime[i]=irandom(10)
        }
        else if i=3 //Bottom
        {
          tNewSpike=instance_create(oPlayer1.x,352,oTWSG_Spike)
          //tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike.direction=90; tNewSpike.image_angle=90
          tNewSpike.atkPrompt=wallSpikePrompt; tNewSpike.atkPower=atkPower; tNewSpike._direction=90; tNewSpike.image_angle=90 //60fps change: _direction (it moves by _speed/_direction)
          wallSpikeTime[i]=irandom(10)
        }
      }
    }

    //scale difficulty
    if lifePercent<=0.8 and lifePercent>=0.61 and bossProgress=0
    {
      armAtkDelay-=20
      wallSpikeDelay-=20
      wallSpikePrompt-=3
      bossProgress+=1
    }
    else if lifePercent<=0.6 and lifePercent>=0.41 and bossProgress=1
    {
      armAtkDelay-=20
      wallSpikeDelay-=20
      wallSpikePrompt-=3
      bossProgress+=1
    }
    else if lifePercent<=0.4 and lifePercent>=0.21 and bossProgress=2
    {
      armAtkDelay-=20
      wallSpikeDelay-=20
      wallSpikePrompt-=3
      bossProgress+=1
    }
    else if lifePercent<=0.2 and bossProgress=3
    {
      armAtkDelay-=20
      wallSpikeDelay-=20
      wallSpikePrompt-=3
      bossProgress+=1
    }
  }
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

    if other.elementType=4
    {
      oGChainCon.hitEff=1
      oGChainCon.swingSpeed=2
    }
  }
}
