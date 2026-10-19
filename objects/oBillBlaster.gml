#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
detectDistX=264
detectDistY=112
inactiveDist=detectDistX*4
reshootTime=95
shootDelay=40
bActive=false
if variable_local_exists("newDDX")
  detectDistX=newDDX
if variable_local_exists("newDDY")
  detectDistY=newDDY
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and findTargetX<=detectDistX and findTargetY<=detectDistY
  {
    if findTargetX>=56
    {
      //shootDelay+=1
      shootDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
      if shootDelay=reshootTime-10
        effect_create_above(ef_smokeup,x,y,0,c_aqua)
      if shootDelay>=reshootTime
      {
        playSound(global.snd_BulletBillShot,0,1)
        var xOffset;
        if x>=oPlayer1.x
          xOffset=-16
        else
          xOffset=16
        bBill=instance_create(x+xOffset,y+16,oBulletBill)
        bBill.bActive=true
        shootDelay=0
      }
    }
  }
}
