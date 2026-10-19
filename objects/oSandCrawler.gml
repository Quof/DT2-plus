#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
y+=1
makeActive()
setCollisionBounds(1,1,1,1)
image_speed=0.6
bActive=1
bCanDealDamage=false
image_xscale=1.25
image_yscale=1.25
if oPlayer1.image_xscale=-1
  image_xscale*=-1

//Enemy base statistics
eName="Sand Crawler"
maxLife=100
life=maxLife
pointWorth=0
atkPower=100
atkDefense=0
FIREresist=100
WATERresist=100
WINDresist=100
EARTHresist=100
baseItemChance=90
initDir=0
biteTime=0
scanText="As long as you don't touch the sand, this thing won't detect you. It's best that you don't get caught because one bite and you're a goner.##I think this is from King of Monsters 2. I'm sure my brother would know."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //biteTime+=1
  biteTime+=1*gDeltaTime //60fps change: counts 30fps ticks
  if biteTime=7
  {
    sprite_index=sSandCrawlerBite
    image_index=0
  }

  if sprite_index=sSandCrawlerBite
  {
    image_speed=0.3
    if image_index>=5.5
      instance_destroy()
  }
  else
    image_speed=0.6

  if sprite_index=sSandCrawlerBite and image_index>=1 and image_index<=2.99
    bCanDealDamage=true
  else
    bCanDealDamage=false

  enemyStepEvent()
}
else
  image_speed=0
