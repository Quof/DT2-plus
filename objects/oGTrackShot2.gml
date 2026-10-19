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

bulletProgress=0
bulletTime=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever fires it sets _direction. bulletTime counts 30fps ticks
//(+=1*gDeltaTime): a move or growth done every tick from tick N on runs from right after tick N-1 (>N-1)
_speed=0
_direction=0

image_speed=0.4
/*
bulletWait
bulletDelay
bulletGrowTime
bulletGrowAmt
bulletDir
fireDelay
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bulletProgress=0 //move to spot
  {
    //bulletTime+=1
    //speed=bulletSpeed
    //if bulletTime>=bulletDelay
    //{
    //  speed=0
    //  bulletTime=0
    //  bulletProgress+=1
    //}
    //60fps change: see Create. At 30fps it stops on tick bulletDelay itself (speed 0 before that tick's move), so it
    //stops on all of that tick's frames (>bulletDelay-1) and moves on at its end
    bulletTime+=1*gDeltaTime
    _speed=bulletSpeed
    if bulletTime>bulletDelay-1
      _speed=0
    if bulletTime>=bulletDelay
    {
      bulletTime=0
      bulletProgress+=1
    }
  }
  else if bulletProgress=1 //slight wait 1
  {
    //bulletTime+=1
    bulletTime+=1*gDeltaTime //60fps change: see Create
    if bulletTime>=bulletWait
    {
      if type=1
      {
        //direction=bulletDir
        _direction=bulletDir //60fps change: see Create
        image_angle=bulletDir
      }
      bulletTime=0
      bulletProgress+=1
    }
  }
  else if bulletProgress=2 //grow
  {
    //bulletTime+=1
    //image_xscale+=bulletGrowAmt
    bulletTime+=1*gDeltaTime //60fps change: see Create
    image_xscale+=bulletGrowAmt*gDeltaTime
    if bulletTime>=bulletGrowTime
    {
      bulletTime=0
      bulletProgress+=1
    }
  }
  else if bulletProgress=3 //slight wait 2
  {
    //bulletTime+=1
    bulletTime+=1*gDeltaTime //60fps change: see Create
    if bulletTime>=bulletWait
    {
      bulletTime=0
      bulletProgress+=1
    }
  }
  else if bulletProgress=4 //fire
  {
    //bulletTime+=1
    //if bulletTime>=fireDelay
    //{
    //  if type=0
    //    direction=bulletDir
    //  speed=7
    //}
    bulletTime+=1*gDeltaTime //60fps change: see Create (it flies from tick fireDelay on: >fireDelay-1)
    if bulletTime>fireDelay-1
    {
      if type=0
        _direction=bulletDir
      _speed=7
    }
  }
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
