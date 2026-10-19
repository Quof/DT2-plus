#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
detectDistX=272
if room=rFinal_aFleetC
  shotTime=50
else
  shotTime=40
shotDelay=65
bFireOut=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bFireOut=0
  {
    findTargetX=point_distance(view_xview[0]+256,0,x+8,0)
    if findTargetX<=detectDistX
    {
      //shotTime+=1
      shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      //if shotTime=shotDelay
      if shotTime>=shotDelay //60fps change: counts 30fps ticks (>=: the same as = at 30fps, and it still fires if the frame rate changed mid-count)
      {
        var xAdj,yAdj;
        if flameDir=0
        {
          xAdj=16
          yAdj=8
        }
        else if flameDir=90
        {
          xAdj=8
          yAdj=0
        }
        else if flameDir=180
        {
          xAdj=0
          yAdj=8
        }
        else if flameDir=270
        {
          xAdj=8
          yAdj=16
        }
        flameOut=instance_create(x+xAdj,y+yAdj,oTankFlame)
        flameOut.image_angle=flameDir
        flameOut.atkPower=4
        shotTime=0
        bFireOut=1
      }
    }
  }
  else
  {
    if !instance_exists(flameOut)
      bFireOut=0
  }
}
