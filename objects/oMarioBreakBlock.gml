#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
image_speed=0.15
hitTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hitTime>0
{
  hitTime+=1
  if hitTime>=3
    instance_destroy()
}
if isCollisionCharacterBottom(1) and hitTime=0
{
  playSound(global.snd_MarioBlockBreak,0,1)
  itemChance=round(random(100)) //find item drop chance
  if itemChance>=(98)
  {
    moneyType=1
    moneyIcon=0
    moneyDrop=instance_create(x+8,y-sprite_height,oMoneyPickupHop)
    moneyDrop.moneyType=moneyType
    moneyDrop.moneyIcon=moneyIcon
  }
  for(i=0;i<4;i+=1)
  {
    newEffect=instance_create(x,y,oMarioBlockEffect)
    newEffect.type=i
  }
  hitTime=1
}
