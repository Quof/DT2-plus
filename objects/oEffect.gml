#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tfollowID=-1
tBlend=-1
txSpd=0
tySpd=0
tDecay=-100
if global.lvlCurrent="4-1"
  depth=35
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newBlend")
  tBlend=newBlend
if variable_local_exists("followID")
  tfollowID=followID
if variable_local_exists("xSpd")
  txSpd=xSpd
if variable_local_exists("ySpd")
  tySpd=ySpd
if variable_local_exists("decay")
  tDecay=decay
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//x+=txSpd
//y+=tySpd
x+=txSpd*gDeltaTime //60fps change: per 30fps tick
y+=tySpd*gDeltaTime //60fps change: per 30fps tick
if tDecay!=-100
{
  //decay-=1
  decay-=1*gDeltaTime //60fps change: counts 30fps ticks
  if decay<=0
    instance_destroy()
}
//(built-in speed/direction given to effects is scaled by oFrameControl)
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if tDecay=-100
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if tBlend!=-1
{
  draw_set_blend_mode(bm_add)
  if tfollowID!=-1
    draw_sprite_ext(sprite_index,-1,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else
    draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_set_blend_mode(bm_normal)
}
else
{
  if tfollowID!=-1
    draw_sprite_ext(sprite_index,-1,followID.x+xFollow,followID.y+yFollow,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else
    draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
