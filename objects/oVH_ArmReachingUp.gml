#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.09
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

eventProg=0
eventTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if eventProg=0 //Drops lots of worms
  {
    for(i=0;i<8;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x+(34*image_xscale)-4+random(8),y-34-4+random(8),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.2+random(0.1); tEffect.ySpd=1+random(1.5)
    }
    eventProg=1
  }
  else if eventProg=1 //Wait and slam ground while spawning main body
  {
    //if oGame.time mod 6=0
    if oGame.time mod (6/gDeltaTime)=0 //60fps change: every 6 30fps ticks (oGame.time counts frames)
    {
      var tEffect;
      tEffect=instance_create(x+(34*image_xscale)-4+random(8),y-34-4+random(8),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.2+random(0.1); tEffect.ySpd=1+random(1.5)
    }
    //eventTime+=1
    //60fps change: counts 30fps ticks; the shake steps once per tick (on its whole numbers), as at 30fps
    eventTime+=1*gDeltaTime
    if eventTime>=65 and eventTime<=90
    {
      if frac(eventTime)=0
      {
      if eventTime mod 2=0 {x+=1}
      else {x-=1}
      }
    }
    else if eventTime>=91
    {
      y-=38
      var tEffect;
      tEffect=instance_create(x+(34*image_xscale),320,oEffect)
      tEffect.sprite_index=sGroundBlast; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      sprite_index=sVH_LegArmsDown
      if image_xscale=1 {instance_create(x-20,y,oHorrorVirus)}
      eventTime=0
      eventProg=2
    }
  }
  else if eventProg=2 //Remove Chaser
  {
    with oChaserVirus {instance_destroy()}
    eventProg=3
  }
  else if eventProg=3 //Shrink Leg arms
  {
    //eventTime+=1
    //if eventTime>=81
    //{
    //  if image_xscale>0 {image_xscale-=0.01; oHorrorVirus.y-=1}
    //  else {image_xscale+=0.01}
    //  image_yscale-=0.01
    //60fps change: counts 30fps ticks; the arms shrink (and lift the body) on all the frames of the ticks from 81 on
    eventTime+=1*gDeltaTime
    if eventTime>80
    {
      if image_xscale>0 {image_xscale-=0.01*gDeltaTime; oHorrorVirus.y-=1*gDeltaTime}
      else {image_xscale+=0.01*gDeltaTime}
      image_yscale-=0.01*gDeltaTime
      if image_xscale>0 and image_xscale<=0.02
      {
        with oVH_ArmReachingUp {instance_destroy()}
      }
    }
    y=oHorrorVirus.y
  }
  enemyStepEvent()
}
