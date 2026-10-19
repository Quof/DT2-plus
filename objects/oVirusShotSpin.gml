#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.35
image_index=random(image_number)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

spinDist=12
decay=120
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //60fps change: one trail puff per 30fps tick, and the spin and spread are per 30fps tick (oGame.time counts frames;
  //direction is only this shot's angle around the core here: its built-in speed is 0). decay counts 30fps ticks; at 30fps
  //it's gone in its step on tick 119, so it goes on that tick's first frame (<2; the same as <=1 at 30fps)
  if gDeltaDoTicks
  {
  effect=instance_create(x,y,oEffect)
  effect.sprite_index=sVirusFalloff
  effect.image_speed=0.3+random(0.1)
  }

  //x=oVirusCore.x+lengthdir_x(spinDist,direction+(oGame.time*3))
  //y=oVirusCore.y+lengthdir_y(spinDist,direction+(oGame.time*3))
  //spinDist+=1.75
  x=oVirusCore.x+lengthdir_x(spinDist,direction+(oGame.time*gDeltaTime*3))
  y=oVirusCore.y+lengthdir_y(spinDist,direction+(oGame.time*gDeltaTime*3))
  spinDist+=1.75*gDeltaTime

  //decay-=1
  //if decay<=1
  decay-=1*gDeltaTime
  if decay<2
    instance_destroy()
}
