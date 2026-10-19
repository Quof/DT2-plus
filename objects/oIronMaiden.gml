#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
bTargetFound=false
snakeAmount=round(random(4)+3)
if global.difficulty=1
  snakeAmount-=1
else if global.difficulty=3
  snakeAmount+=1
else if global.difficulty=4
  snakeAmount+=2
detectDistX=160
detectDistY=160
dir=1
awardTime=45
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and bTargetFound=false
  {
    if oPlayer1.x<=x
      dir=-1
    for (i=0;i<=snakeAmount;i+=1)
    {
      ranX=random(6)
      ranY=random(32)
      snakeEnemy[i]=instance_create(x-3+ranX,y-8-ranY,oRedDustSnake)
      snakeEnemy[i].xVel=round(random(4)+2)*dir
      snakeEnemy[i].yVel=round(random(3)-6)
    }
    image_index=1
    bTargetFound=true
  }
  if awardTime>0 and bTargetFound=true
  {
    //awardTime-=1
    awardTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    award=0
    for (i=0;i<=snakeAmount;i+=1)
    {
      if !instance_exists(snakeEnemy[i])
        award+=1
      if award>snakeAmount
      {
        moneyDrop=instance_create(x,y-(sprite_height/2),oMoneyPickup)
        moneyDrop.moneyType=10
        moneyDrop.moneyIcon=2
        awardTime=0
      }
    }
  }
}
