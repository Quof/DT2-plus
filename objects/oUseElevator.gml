#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(-16,-64,16,0)
soundDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y)
  if myDist<8
  {
    if oPlayer1.kUp
      if isCollisionTop(1)
        yVel=0
      else
        yVel=-8
    else if oPlayer1.kDown
      if isCollisionBottom(1)
        yVel=0
      else
        yVel=8
    else
      yVel=0
    if yVel!=0
      if soundDelay=0
      {
        //sound_play(snd_ElevatorUse)
        soundDelay=4
      }
      else
        soundDelay-=1
  }
  else
    yVel=0
}
