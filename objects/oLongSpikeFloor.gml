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
image_xscale=-16
image_angle=180

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false


yCheck=y
ySPlace=y
extendDist=0
seekSpeed=4 //how fast it comes out
seekTime=0
seekMax=12 //how long it will extend
waitTime=45 //how long it waits till it retracts and can go back out
bTargetFound=false
detectDistX=80
detectDistY=192

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ySPlace=y

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
      //extendDist-=seekSpeed
      extendDist-=seekSpeed*gDeltaTime //60fps change: per 30fps tick
      //yCheck-=seekSpeed
      yCheck-=seekSpeed*gDeltaTime //60fps change: per 30fps tick
    }
    else if seekTime<-waitTime
    {
      if yCheck=ySPlace
      {
        if seekTime<(round(-waitTime*2))
        {
          bTargetFound=false
          bActive=false
        }
      }
      else
      {
        //extendDist+=seekSpeed
        extendDist+=seekSpeed*gDeltaTime //60fps change: per 30fps tick
        //yCheck+=seekSpeed
        yCheck+=seekSpeed*gDeltaTime //60fps change: per 30fps tick
      }
    }
    image_yscale=-1-extendDist
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sLongSpikeMid,-1,x+15,ySPlace+8,1,-extendDist,180,c_white,1)
draw_sprite_ext(sLongSpikeEnd,-1,x+15,y+8+extendDist,1,1,180,c_white,1)
