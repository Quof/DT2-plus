#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(0,0,sprite_width,sprite_height)
image_speed=0.15
bHit=false
moveAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveAnim>=1 and moveAnim<=4
{
  moveAnim+=1
  if moveAnim=2
    y-=2
  else if moveAnim=4
    y+=2
}

if isCollisionCharacterBottom(1) and bHit=false
{
  playSound(global.snd_MarioCoin,0,1)
  global.recQuestionMarkBlocksHit+=1
  itemChance=round(random(100)) //find item drop chance
  if itemChance>=(70)
  {
    moneyType=1
    moneyIcon=0
    moneyDrop=instance_create(x+8,y-sprite_height,oMoneyPickupHop)
    moneyDrop.moneyType=moneyType
    moneyDrop.moneyIcon=moneyIcon
  }
  moveAnim=1
  bHit=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=false
  draw_sprite(sMarioQBlockN,-1,x,y)
else
  draw_sprite(sMarioQBlockHit,-1,x,y)
