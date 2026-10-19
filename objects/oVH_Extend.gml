#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.05+random(0.05)
bShowHealthBar=false
bCanTakeDamage=false

//Enemy base statistics
eName="Suffering"
maxLife=10000
life=maxLife
atkPower=3
atkDefense=0
FIREresist=0
WATERresist=100
WINDresist=0
EARTHresist=100
bIsBoss=true

extendDist=1
faceDir=0

wobble=0
wobTime=0
pulsate=pi/2

bWaveUp=0
wave=0

phase=0
phaseAmp=1
phaseTime=0

fireTime=90
fireDelay=300

bSetup=0
var tI;
for(tI=0;tI<4;tI+=1) {dirHist[tI]=0} //60fps change (added): see the Step

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
  //if extendDist<25 {extendDist+=0.2}
  if extendDist<25 {extendDist+=0.2*gDeltaTime} //60fps change: per 30fps tick

  //60fps change (added): the base and the middle parts go by the direction of a part that's updated after them (the face,
  //extend[5], or the next part, extend[myPart+1]), so they use the direction it had on the last step: a turn of the face
  //takes a step per part to reach the base. At 30fps that's a tick per part; above 30fps it was a frame, so the neck
  //followed the face 2x/4x as fast. That direction is kept for a 30fps tick (dirHist) and the one from a tick ago is used
  //(at 30fps it's still the last step's), as for the Wall Shifting Golem's legs (oTWSG_Leg)
  var tNextDir;
  if type<2
  {
    var tN, tI, tFrom;
    if type=0 {tFrom=5} else {tFrom=myPart+1}
    tN=round(1/gDeltaTime)
    for(tI=tN-1;tI>0;tI-=1) {dirHist[tI]=dirHist[tI-1]}
    dirHist[0]=oHorrorVirus.extend[tFrom].faceDir
    tNextDir=dirHist[tN-1]
  }

  if type=0 //Contact Point (Base)
  {
    x=oHorrorVirus.x
    y=oHorrorVirus.y
    //x=oHorrorVirus.x+lengthdir_x(extendDist,oHorrorVirus.extend[5].faceDir)
    //y=oHorrorVirus.y+lengthdir_y(extendDist,oHorrorVirus.extend[5].faceDir)
    x=oHorrorVirus.x+lengthdir_x(extendDist,tNextDir) //60fps change: see above
    y=oHorrorVirus.y+lengthdir_y(extendDist,tNextDir)
  }
  else if type=1 //Mid
  {
    //if oGame.time mod 22=0 //Worms dropping
    if oGame.time mod (22/gDeltaTime)=0 //Worms dropping //60fps change: every 22 30fps ticks (oGame.time counts frames)
    {
      var tEffect;
      tEffect=instance_create(x-13+random(26),y-13+random(26),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5); tEffect.depth=30
    }

    //wobTime+=1
    //if wobTime>=81 and wobTime<=100
    //60fps change: wobTime counts 30fps ticks, and the wobble steps once per tick (on its whole numbers), so it adds up
    //the same sines as at 30fps; the wave sways per 30fps tick
    wobTime+=1*gDeltaTime
    if wobTime>=81 and wobTime<=100 and frac(wobTime)=0
    {
      pulsate+=0.25
      wobble+=sin(pulsate)
    }
    else if wobTime=101 {wobTime=0}

    if bWaveUp=0
    {
      //wave+=0.5
      wave+=0.5*gDeltaTime
      if wave>=10 {bWaveUp=1}
    }
    else if bWaveUp=1
    {
      //wave-=0.5
      wave-=0.5*gDeltaTime
      if wave<=-10 {bWaveUp=0}
    }

    //faceDir=oHorrorVirus.extend[myPart+1].faceDir+wave+wobble
    //x=oHorrorVirus.extend[myPart-1].x+lengthdir_x(extendDist,oHorrorVirus.extend[myPart+1].faceDir)
    //y=oHorrorVirus.extend[myPart-1].y+lengthdir_y(extendDist,oHorrorVirus.extend[myPart+1].faceDir)
    faceDir=tNextDir+wave+wobble //60fps change: see above
    x=oHorrorVirus.extend[myPart-1].x+lengthdir_x(extendDist,tNextDir)
    y=oHorrorVirus.extend[myPart-1].y+lengthdir_y(extendDist,tNextDir)
  }
  else if type=2 //Face
  {
    if bSetup=0
    {
      bCanTakeDamage=true
      bSetup=1
    }

    //Phase effect when hit
    //phase+=0.025
    //if phaseTime>0
    //60fps change: see oHorrorVirus
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

    //Point face to player
    //if point_distance(oHorrorVirus.x,oHorrorVirus.y,oPlayer1.x,oPlayer1.y-26)>150
    //60fps change: it aims once per 30fps tick (from where it is then), as at 30fps. It aims from its own position, and the
    //neck follows its direction a tick later (see the top of the Step), so aiming every frame against that tick's lag
    //overshot: the face flew back and forth between two places 100-200 pixels apart every frame (checked with a simulation:
    //aiming per tick it moves as at 30fps)
    if point_distance(oHorrorVirus.x,oHorrorVirus.y,oPlayer1.x,oPlayer1.y-26)>150 and gDeltaDoTicks
      faceDir=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)

    if faceDir>40 and faceDir<180 {faceDir=40}
    else if faceDir>180 and faceDir<290 {faceDir=290}
    x=oHorrorVirus.extend[myPart-1].x+lengthdir_x(extendDist,faceDir)
    y=oHorrorVirus.extend[myPart-1].y+lengthdir_y(extendDist,faceDir)

    //fireTime+=1
    //60fps change: counts 30fps ticks; the worms come once per tick (gDeltaDoTicks) in ticks 10001-10035
    fireTime+=1*gDeltaTime
    if fireTime>=fireDelay
    {
      if fireTime>=fireDelay and fireTime<=fireDelay+1000 {fireTime=10000}
      //else if fireTime>=10001 and fireTime<=10035
      else if fireTime>10000 and fireTime<=10035 and gDeltaDoTicks
      {
        var tEffect;
        for(i=0;i<2;i+=1)
        {
          tEffect=instance_create(x+random(8),y+random(8),oEffect)
          tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5)
        }
      }
      //else if fireTime=10060
      else if fireTime>=10060 //60fps change: >=, so it still fires if the frame rate changed mid-count
      {
        newAttack=instance_create(x,y,oVH_Fireball)
        //newAttack.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
        newAttack._direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26) //60fps change: _direction (oVH_Fireball moves by _speed/_direction)
        newAttack.atkPower=atkPower
        newAttack.bulletSpeed=6
        fireTime=0
      }
    }
  }

  //--- Life recovery ---
  life=maxLife
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

    if type=2 //special damage properties
    {
      if other.elementType=1
      {
        oHorrorVirus.life-=20
        oHorrorVirus.fireUse+=1
      }
      if other.elementType=3
      {
        oHorrorVirus.life-=20
        oHorrorVirus.windUse+=1
      }

      if (other.elementType=2 or other.elementType=3) and phaseTime=0
        phaseTime=30
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=2
{
  if phaseTime=0
    event_inherited()
  else
    draw_sprite_wave(sprite_index,image_index,x,y,1,phaseAmp,2,phase)
}
else
{
  event_inherited()
}
