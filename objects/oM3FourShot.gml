#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
detectDistX=272
shotTime=0
shotDelay=50
bReadyToFire=0
stopFiring=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and stopFiring=0
{
  findTargetX=point_distance(view_xview[0]+256,0,x,0)
  if findTargetX<=detectDistX
  {
    //shotTime+=1
    shotTime+=1*gDeltaTime //60fps change: counts 30fps ticks
    if shotTime=round(shotDelay/2)-10
    {
      playSound(global.snd_MarioCannon,0,0.86)
      var shotDir;
      if image_index=0
        shotDir=0
      else
        shotDir=45
      for(i=0;i<4;i+=1)
      {
        bBill=instance_create(x,y+16,oM3Shot)
        bBill.x=x+lengthdir_x(14,shotDir)
        bBill.y=y+16+lengthdir_y(14,shotDir)
        bBill.sprite_index=sMSTShotSmall
        //bBill.direction=shotDir
        bBill._direction=shotDir //60fps change: _direction (oM3Shot moves by _speed/_direction)
        bBill.atkPower=4
        bBill.bulletSpeed=4
        shotDir+=90
      }
    }
    //else if shotTime=shotDelay
    else if shotTime>=shotDelay //60fps change: counts 30fps ticks (>=: the same as = at 30fps, and it still fires if the frame rate changed mid-count)
    {
      if image_index=0
        image_index=1
      else
        image_index=0
      shotTime=0
    }
  }
}
