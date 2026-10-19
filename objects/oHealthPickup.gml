#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-5,-5,5,5)
yVel=-4
image_speed=0.25
totalHeal=3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if gDeltaTime<1 {scrSolidPushOut()} //60fps change (added): out of a solid it's in (e.g. an elevator that rose into it) before anything looks at where it is (see scrSolidPushOut)
  //yVel+=0.2
  yVel=scrGravAcc(yVel,0.2,1) //60fps change: gravity (accelerate, then move) spread over the frames so falls match 30fps (see scrGravAcc)
  //if isCollisionSolid()
  //  y-=2
  if gDeltaTime==1 {if isCollisionSolid() {y-=2}} //60fps change: above 30fps it's scrSolidPushOut, at the start of the step
  if y>room_height+8
    instance_destroy()
  //moveTo(xVel,yVel)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
}
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oPlayer1.life+=totalHeal
playSound(global.snd_HealthPickup,0,1)
newDamage=instance_create(x,y-(sprite_height/2+(sprite_height/4)),oDamageNotice);
newDamage.damageValue=totalHeal
newDamage.damageColor=make_color_rgb(78,192,34)
effect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
effect.sprite_index=sHeal
effect.followID=other.id
effect.xFollow=0
effect.yFollow=-(oPlayer1.sprite_height/2)
instance_destroy()
