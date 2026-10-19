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
bCanDealDamage=false
atkProg=0
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever makes it sets _direction (0, to the right, if it doesn't)
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //atkProg+=1
  //if atkProg>=1 and atkProg<=atkPrompt
  //60fps change: atkProg counts 30fps ticks. The smoke is made once per tick (gDeltaDoTicks) in ticks 1 to atkPrompt; the
  //spike flies every tick from tick atkPrompt+1 (from right after tick atkPrompt), showing itself on that tick's first
  //frame (the same checks as before at 30fps)
  atkProg+=1*gDeltaTime
  if atkProg>0 and atkProg<=atkPrompt
  {
    if gDeltaDoTicks
    for(i=0;i<2;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x-14+random(28),y-14+random(28),oEffect)
      tEffect.sprite_index=sMMSmokeCloud
    }
  }
  //else if atkProg>=atkPrompt+1
  else if atkProg>atkPrompt
  {
    //if atkProg=atkPrompt+1
    if atkProg=atkPrompt+gDeltaTime
    {
      visible=1
      bCanDealDamage=true
    }
    //speed=4
    _speed=4
  }
}
//else {speed=0}
else {_speed=0}
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
