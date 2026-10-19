#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-8,8,8)
bShowHealthBar=false
bActive=true
image_speed=0.2
image_xscale=1.5
image_yscale=1.5

//Enemy base statistics
eName="Chaser Virus"
maxLife=1000
life=maxLife
atkPower=8
atkDefense=0
FIREresist=0
WATERresist=0
WINDresist=0
EARTHresist=0

xPos=24
yPos=0
vSpin=0
moveSpeed=0.9
pulsate=0
backOffTime=0
pulseDist=0
spinSpd=6

eventProg=0
eventTime=0
backBlend=255

scanText="It seems to recover its life energy too fast for you to beat it. If it gets too close, you can hit it to knock it back. Be sure you do that periodically, it has a lot of power."
jeremyText="This is a chaser. All it's trying to do is keep you from escaping. Don't try to fight it, just run."

for(i=0;i<8;i+=1)
{
  virusSpin[i]=instance_create(x,y,oMisc)
  virusSpin[i].sprite_index=sVirusShot
  virusSpin[i].image_speed=0.45
  virusSpin[i].type=1
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<8;i+=1)
{
  with virusSpin[i]
    instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if eventProg=0 //---------- Chasing Claire ----------
  {
    //x movement
    //60fps change: the chase, back-off and bobbing are per 30fps tick, and backOffTime counts 30fps ticks (<=0: the same as
    //=0 at 30fps, where it never goes below 0, and it still ends if the frame rate changed mid-count)
    //if backOffTime=0
    if backOffTime<=0
    {
      if x<oPlayer1.x
        //xPos+=moveSpeed
        xPos+=moveSpeed*gDeltaTime
    }
    else
    {
      //backOffTime-=1
      //xPos-=moveSpeed*5
      backOffTime-=1*gDeltaTime
      xPos-=moveSpeed*5*gDeltaTime
    }
    x=view_xview[0]+xPos

    //y movement
    if y<oPlayer1.y-22
      //y+=1
      y+=1*gDeltaTime
    else
      //y-=1
      y-=1*gDeltaTime

    //yPos+=0.05
    //y+=cos(yPos)
    yPos+=0.05*gDeltaTime
    y+=cos(yPos)*gDeltaTime
  }
  else if eventProg=1 //---------- Getting to position: 6352,320 ----------
  {
    var tPosChk;
    tPosChk=0
    //60fps change: per 30fps tick
    if x>6353 {x-=1*gDeltaTime}
    else if x<6351 {x+=1*gDeltaTime}
    else {tPosChk+=1}

    if y>321 {y-=1*gDeltaTime}
    else if y<319 {y+=1*gDeltaTime}
    else {tPosChk+=1}

    if tPosChk=2 {eventProg=2}
  }
  else if eventProg=2 //---------- Bring in pulsating virus effect - 24-28 pixel base size ----------
  {
    //60fps change: per 30fps tick
    if spinSpd>1 {spinSpd-=0.1*gDeltaTime}

    for(i=0;i<8;i+=1)
    {
      virusSpin[i].image_xscale-=0.0125*gDeltaTime
      virusSpin[i].image_yscale-=0.0125*gDeltaTime
    }

    pulseDist-=0.5*gDeltaTime
    if pulseDist<=-48
    {
      for(i=0;i<8;i+=1)
      {
        with virusSpin[i] {instance_destroy()}
      }
      eventProg=3
    }
  }
  else if eventProg=3 //---------- Create screen tint ----------
  {
    instance_create(0,0,oEvTintScreenRed)
    //instance_create(0,0,oBackFaces)
    for(i=0;i<7;i+=1)
    {
      for(ii=0;ii<4;ii+=1)
      {
        instance_create(6272+(84*i),72+(78*ii),oBackFaces)
        //draw_sprite_ext(sVH_MainBody,image_index+(i/20),6272+(84*i),64+(78*ii),1,1,0,image_blend,image_alpha)
      }
    }
    for(i=0;i<6;i+=1)
    {
      for(ii=0;ii<3;ii+=1)
      {
        instance_create(6319+(84*i),113+(78*ii),oBackFaces)
        //draw_sprite_ext(sVH_MainBody,image_index+(i/10),6319+(84*i),105+(78*ii),1,1,0,image_blend,image_alpha)
      }
    }

    bCanDealDamage=false
    bCanTakeDamage=false
    eventProg=4
  }
  else if eventProg=4 //---------- Set background color - 85 frames ----------
  {
    //backBlend-=2
    //background_blend[0]=make_color_rgb(255,backBlend,backBlend)
    //image_xscale-=0.0075; image_yscale-=0.0075
    backBlend-=2*gDeltaTime //60fps change: per 30fps tick
    background_blend[0]=make_color_rgb(255,backBlend,backBlend)
    image_xscale-=0.0075*gDeltaTime; image_yscale-=0.0075*gDeltaTime
    if backBlend<=0
    {
      background_blend[0]=make_color_rgb(255,0,0)
      eventProg=5
    }
  }
  else if eventProg=5 //---------- Bring out hands ----------
  {
    //eventTime+=1
    eventTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if eventTime=45
    {
      rightHand=instance_create(x+24,y,oVH_ArmReachingUp)
      leftHand=instance_create(x-24,y,oVH_ArmReachingUp); leftHand.image_xscale=-1
    }
  }

  //if eventProg=4 or eventProg=5
  if (eventProg=4 or eventProg=5) and gDeltaDoTicks //60fps change: one pool puff per 30fps tick
  {
    var tEffect,tRanScl;
    tRanScl=1+random(0.66)
    tEffect=instance_create(x-48+random(96),y-2+random(4),oEffect)
    tEffect.sprite_index=sVH_PoolGrowth; tEffect.image_speed=0.2; tEffect.decay=25
    tEffect.image_xscale=tRanScl; tEffect.image_yscale=tRanScl; tEffect.depth=8
  }

  if eventProg<=2
  {
    //--- Virus pulsate ---
      //pulsate+=1
      //if pulsate>=1 and pulsate<=25
      //60fps change: counts 30fps ticks; the pulse runs on all the frames of ticks 1-25 and 26-50 (>0, >25), and the spin
      //is per 30fps tick
      pulsate+=1*gDeltaTime
      if pulsate>0 and pulsate<=25
      {
        //image_xscale+=0.01
        //image_yscale+=0.01
        image_xscale+=0.01*gDeltaTime
        image_yscale+=0.01*gDeltaTime
      }
      //else if pulsate>=26 and pulsate<=50
      else if pulsate>25 and pulsate<=50
      {
        //image_xscale-=0.01
        //image_yscale-=0.01
        image_xscale-=0.01*gDeltaTime
        image_yscale-=0.01*gDeltaTime
        if pulsate=50
          pulsate=0
      }

    //--- Virus spin effect ---
    //vSpin+=spinSpd
    vSpin+=spinSpd*gDeltaTime
    var vDir; vDir=0
    for(i=0;i<8;i+=1)
    {
      virusSpin[i].x=x+lengthdir_x(sprite_width+8+pulseDist,vDir+vSpin)
      virusSpin[i].y=y+lengthdir_y(sprite_height+8+pulseDist,vDir+vSpin)
      vDir+=360/8
    }
  }

  //--- Life recovery ---
  //life+=2
  if gDeltaDoTicks {life+=2} //60fps change: 2 per 30fps tick, on the tick's last frame, so life stays a whole number as at 30fps (the scan window shows it; 2*gDeltaTime a frame gave it decimals)
  if life>maxLife {life=maxLife}

  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bTakingDamage=false {backOffTime=30}
event_inherited()
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
    backOffTime+=5
  }
}
