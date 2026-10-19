#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=1.33
image_yscale=1.33

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

atkPower=4
turnTime=0
turnDist=384
moveSpeed=2

vSpin=0
pulsate=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction. chaserTickTime runs its 30fps turning
//step on its own ticks (see Step)
_speed=0
_direction=0
chaserTickTime=0

for(i=0;i<12;i+=1)
{
  virusSpin[i]=instance_create(x,y,oMisc)
  virusSpin[i].sprite_index=sVirusShot
  virusSpin[i].image_speed=0.45
  virusSpin[i].type=1
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<12;i+=1)
{
  with virusSpin[i]
    instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //---------- Shell pulsate ----------
  //pulsate+=1
  //if pulsate>=1 and pulsate<=25
  //60fps change: counts 30fps ticks; the pulse runs on all the frames of ticks 1-25 and 26-50 (>0, >25)
  pulsate+=1*gDeltaTime
  if pulsate>0 and pulsate<=25
  {
    //image_xscale+=0.01
    //image_yscale+=0.01
    image_xscale+=0.01*gDeltaTime
    image_yscale+=0.01*gDeltaTime
  }
  //else if pulsate>=26 and pulsate<=50
  else if pulsate>25 and pulsate<=50
  {
    //image_xscale-=0.01
    //image_yscale-=0.01
    image_xscale-=0.01*gDeltaTime
    image_yscale-=0.01*gDeltaTime
    if pulsate=50
      pulsate=0
  }

  //speed=moveSpeed
  //turnTime+=1
  //if turnTime>=turnDist/moveSpeed
  //{
  //  moveSpeed+=0.75
  //  turnTime=0
  //  direction+=90
  //}
  //60fps change: the 30fps step (set the speed, count, speed up and turn) runs on the first frame of each of its 30fps
  //ticks, and the tick's move is spread over its frames with the speed and direction it left (as at 30fps, where it
  //moves after its step), so it takes the 30fps path (the same as before at 30fps)
  if chaserTickTime<=0
  {
    chaserTickTime+=1
    _speed=moveSpeed
    turnTime+=1
    if turnTime>=turnDist/moveSpeed
    {
      moveSpeed+=0.75
      turnTime=0
      _direction+=90
    }
  }
  chaserTickTime-=gDeltaTime

  //virus spin effect
  //vSpin+=6
  vSpin+=6*gDeltaTime //60fps change: per 30fps tick
  var vDir; vDir=0
  for(i=0;i<12;i+=1)
  {
    virusSpin[i].x=x+lengthdir_x((sprite_width/2)-4,vDir+vSpin)
    virusSpin[i].y=y+lengthdir_y((sprite_height/2)-4,vDir+vSpin)
    vDir+=360/12
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  if bCanTakeHit=true and bCanTakeDamage=true
    takeDamage()
}
