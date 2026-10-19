#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=0.7
image_yscale=0.7
bCanTakeDamage=false
bShowHealthBar=false
atkPower=5
ySpd=4
//oPlayer1.extForceY=1.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //y+=ySpd
  ySpd=scrGravAcc(ySpd,0.2,-1) //60fps change (added): gravity spread over the frames; at 30fps this moves and then speeds up, so the original line below stays for 30fps (see scrGravAcc)
  y+=ySpd*gDeltaTime //60fps change: per 30fps tick
  //ySpd+=0.2
  if gDeltaTime==1 {ySpd+=0.2} //60fps change: 30fps only (see above)

  if y>=room_height+sprite_height+8
    instance_destroy()
}
