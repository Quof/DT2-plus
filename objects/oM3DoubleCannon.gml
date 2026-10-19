#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
detectDistX=272
if room=rFinal_aFleetC
  shotTime=65
else
  shotTime=55
shotDelay=75
bReadyToFire=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bReadyToFire=0
  {
    findTargetX=point_distance(view_xview[0]+256,0,x+8,0)
    if findTargetX<=detectDistX
    {
      //shotTime+=1
      shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      //if shotTime=shotDelay
      if shotTime>=shotDelay //60fps change: counts 30fps ticks (>=: the same as = at 30fps, and it still fires if the frame rate changed mid-count)
      {
        effect_create_above(ef_smokeup,x,y,0,c_red)
        bReadyToFire=1
      }
    }
  }
  else
  {
    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    //if shotTime=shotDelay+10
    if shotTime>=shotDelay+10 //60fps change: counts 30fps ticks (>=: the same as = at 30fps, and it still fires if the frame rate changed mid-count)
    {
      playSound(global.snd_MarioCannon,0,0.9)
      var xAdj,yAdj,shotDir;
      if oPlayer1.y-24<y
      {
        if type=0
        {
          xAdj=-8
          shotDir=135
        }
        else
        {
          xAdj=8
          shotDir=45
        }
        yAdj=-8
      }
      else
      {
        if type=0
        {
          xAdj=8
          shotDir=315
        }
        else
        {
          xAdj=-8
          shotDir=225
        }
        yAdj=8
      }
      bBill=instance_create(x+xAdj,y+yAdj,oM3Shot)
      bBill.sprite_index=sMSTShotSmall
      //bBill.direction=shotDir
      bBill._direction=shotDir //60fps change: _direction (oM3Shot moves by _speed/_direction)
      bBill.atkPower=4
      bBill.bulletSpeed=4
      shotTime=0
      bReadyToFire=0
    }
  }
}
