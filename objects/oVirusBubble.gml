#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //speed=bulletSpeed
  //popTime-=1
  //
  //if popTime=0
  //60fps change: popTime counts 30fps ticks. At 30fps it pops in its step before that tick's move, so it pops on the
  //first frame of that tick (popTime<1; the same as =0 at 30fps) and travels as far as at 30fps
  _speed=bulletSpeed
  popTime-=1*gDeltaTime

  if popTime<1
  {
    if type=1 //big bubble
    {
      effect=instance_create(x,y,oEffect)
      effect.sprite_index=sS6MetImpact
      effect.image_speed=0.35

      tSpinDir=0
      for(i=0;i<oVirusCore.vSpinShotAmt;i+=1)
      {
        newAttack=instance_create(x,y,oVirusBubble)
        newAttack.x=x+lengthdir_x(16,tSpinDir)
        newAttack.y=y+lengthdir_y(16,tSpinDir)
        //newAttack.direction=tSpinDir
        newAttack._direction=tSpinDir //60fps change: _direction (see Create)
        newAttack.image_xscale=0.25
        newAttack.image_yscale=0.25
        newAttack.type=2
        newAttack.atkPower=atkPower-1
        newAttack.bulletSpeed=6
        newAttack.popTime=80
        tSpinDir+=360/oVirusCore.vSpinShotAmt
      }
      instance_destroy()
    }
    else if type=2 //small bubble
    {
      effect=instance_create(x,y,oEffect)
      effect.sprite_index=sS6MetImpact
      effect.image_speed=0.35
      effect.image_xscale=0.25
      effect.image_yscale=0.25
      instance_destroy()
    }
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
