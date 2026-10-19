#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
activated=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  makeEnemyActive()
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if activated=0
{
  playSound(global.snd_SwitchHit,0,1)
  image_index=1
  activated=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)
