#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.45
image_xscale+=0.2
image_yscale+=0.2
damageType="SPIRIT"
atkPower=oPlayer1.atkPower
currentSpell="BLAST OFF"
elementType=1
skillPower=10
lifeTime=4
oPlayer1.yVel=-7.5
oPlayer1.yVelSetExt=1 //60fps change (added): velocity set after the player's move: its next move uses the 30fps formula (see pMoveToWrapNew)
scrSlowFall(5,0.5)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  x=oPlayer1.x
  y=oPlayer1.y
  //image_xscale+=0.3
  //image_yscale+=0.3
  image_xscale+=0.3*gDeltaTime //60fps change: per 30fps tick
  image_yscale+=0.3*gDeltaTime //60fps change: per 30fps tick

  //lifeTime-=1
  lifeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if lifeTime<=0
  {
    oPlayer1.yVel=-10
    oPlayer1.yVelSetExt=1 //60fps change (added): see the Create event
    instance_destroy()
  }
  else
  {
    var tEffect,tScale;
    if gDeltaDoTicks //60fps change (added): effects once per 30fps tick (every frame made 2x/4x as many)
    for(i=0;i<12;i+=1)
    {
      tScale=0.4+random(0.2)
      tEffect=instance_create(x-12+random(24),y+random(32),oEffect)
      tEffect.sprite_index=sXshotEffect1; tEffect.image_speed=0.2+random(0.1)
      tEffect.image_xscale=tScale; tEffect.image_yscale=tScale; tEffect.image_alpha=0.6+random(0.1)
      tEffect.xSpd=random_range(-2,2); tEffect.ySpd=2+random(6)
    }
    oPlayer1.yVel=-7.5
    oPlayer1.yVelSetExt=1 //60fps change (added): velocity set every frame: the player's next move uses the 30fps formula (see pMoveToWrapNew)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
