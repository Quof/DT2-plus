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
size=2
bombSize=8
bShrink=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //damage to player
  if collision_circle(x,y,bombSize-2,oPlayer1,1,1)
  {
    with oPlayer1
      hitPlayer()
  }
  //bomb time
  if bShrink=0
  {
    //bombSize+=4
    bombSize+=4*gDeltaTime //60fps change: per 30fps tick
    if bombSize>=36
      bShrink=1
  }
  else
  {
    //bombSize-=4
    bombSize-=4*gDeltaTime //60fps change: per 30fps tick
    if bombSize<=4
      instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
colorInverter(1,bombSize)
