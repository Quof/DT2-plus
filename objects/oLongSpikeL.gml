#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-1,-1,1,1)
sprite_index=sScaledCollision
image_angle=90
y+=15
image_xscale=16

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false

xCheck=x
xSPlace=x
extendDist=0
seekSpeed=4 //how fast it comes out
seekTime=0
seekMax=12 //how long it will extend
waitTime=45 //how long it waits till it retracts and can go back out
bTargetFound=false
detectDistX=128
detectDistY=160

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xSPlace=x

if variable_local_exists("newSpeed")
  seekSpeed=newSpeed
if variable_local_exists("newMax")
  seekMax=newMax
if variable_local_exists("newDetectX")
  detectDistX=newDetectX
if variable_local_exists("newDetectY")
  detectDistY=newDetectY
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true
  {
    if bTargetFound=false
    {
      bTargetFound=true
      seekTime=seekMax
    }
    //seekTime-=1
    seekTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    //if seekTime>0
    if seekTime>=1 //60fps change: the count was just counted down for this frame (it holds fractions between 30fps ticks), so >=1 extends for exactly as many ticks as >0 at 30fps (the same at 30fps)
    {
      //extendDist+=seekSpeed
      extendDist+=seekSpeed*gDeltaTime //60fps change: per 30fps tick
      //xCheck+=seekSpeed
      xCheck+=seekSpeed*gDeltaTime //60fps change: per 30fps tick
    }
    else if seekTime<-waitTime
    {
      if xCheck=xSPlace
      {
        if seekTime<(round(-waitTime*2))
        {
          bTargetFound=false
          bActive=false
        }
      }
      else
      {
        //extendDist-=seekSpeed
        extendDist-=seekSpeed*gDeltaTime //60fps change: per 30fps tick
        //xCheck-=seekSpeed
        xCheck-=seekSpeed*gDeltaTime //60fps change: per 30fps tick
      }
    }
    image_yscale=8+extendDist
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sLongSpikeMid,-1,xSPlace,y,1,extendDist,90,c_white,1)
draw_sprite_ext(sLongSpikeEnd,-1,x+extendDist,y,1,1,90,c_white,1)
