#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.03+random(0.03)
if instance_exists(oChaserVirus) {image_alpha=0}
else {image_alpha=0.05}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if image_alpha<0.05 {image_alpha+=0.0002}
  if image_alpha<0.05 {image_alpha+=0.0002*gDeltaTime} //60fps change: per 30fps tick
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*for(i=0;i<7;i+=1)
{
  for(ii=0;ii<4;ii+=1)
  {
    draw_sprite_ext(sVH_MainBody,image_index+(i/20),6272+(84*i),64+(78*ii),1,1,0,image_blend,image_alpha)
  }
}
for(i=0;i<6;i+=1)
{
  for(ii=0;ii<3;ii+=1)
  {
    draw_sprite_ext(sVH_MainBody,image_index+(i/10),6319+(84*i),105+(78*ii),1,1,0,image_blend,image_alpha)
  }
}*/
draw_sprite_ext(sVH_MainBody,image_index,x,y,1,1,0,image_blend,image_alpha)
