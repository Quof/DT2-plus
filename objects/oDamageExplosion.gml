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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime!=-100
{
  //decayTime-=1
  decayTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if decayTime<=0
    instance_destroy()
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime=-100
  instance_destroy()
