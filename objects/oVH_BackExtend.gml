#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.05+random(0.05)
visible=0
bSetup=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oHorrorVirus.x>x
  {
    visible=1
    //if oGame.time mod 18=0 //Worms dropping
    if oGame.time mod (18/gDeltaTime)=0 //Worms dropping //60fps change: every 18 30fps ticks (oGame.time counts frames)
    {
      var tEffect;
      tEffect=instance_create(x-13+random(26),y-13+random(26),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5); tEffect.depth=30
    }
    y=oHorrorVirus.y+yOffset
  }
  else {visible=0}

  if bSetup=0
  {
    for(i=0;i<7;i+=1) //Initial worms dropping
    {
      var tEffect;
      tEffect=instance_create(x-13+random(26),y-13+random(26),oEffect)
      tEffect.sprite_index=sVH_WormDrop; tEffect.image_speed=0.1+random(0.1); tEffect.ySpd=1+random(1.5)
    }
    bSetup=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
