#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="enemy"
setCollisionBounds(-1,-1,1,1)
event_inherited()
bShowHealthBar=true
#define Mouse_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and scanText!=""
{
  with oMessageEnemy
    instance_destroy()
  newMessage=instance_create(view_xview[0]+32,view_yview[0]+24,oMessageEnemy)
  newMessage.name=eName
  newMessage.scanText=scanText
  newMessage.chaoText=scanText
  newMessage.jeremyText=jeremyText
  newMessage.bossInfo=bIsBoss
  newMessage.life=maxLife
  newMessage.pPower=atkPower
  newMessage.pDefense=atkDefense
  newMessage.fireRes=FIREresist
  newMessage.waterRes=WATERresist
  newMessage.windRes=WINDresist
  newMessage.earthRes=EARTHresist
  newMessage.effectX=mouse_x
  newMessage.effectY=mouse_y
}
