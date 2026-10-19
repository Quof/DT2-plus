#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x<256
  xSpd=1
else
  xSpd=-2
ySpd=-4
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //x+=xSpd
  //y+=ySpd
  //ySpd+=0.1
  //60fps change: per 30fps tick, with the fall spread over the frames (scrGravAcc: it moves, then speeds up)
  ySpd=scrGravAcc(ySpd,0.1,-1)
  x+=xSpd*gDeltaTime
  y+=ySpd*gDeltaTime
  if gDeltaTime==1 {ySpd+=0.1}
  if y>room_height+sprite_height+4
    instance_destroy()
}
