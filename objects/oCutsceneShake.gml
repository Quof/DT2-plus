#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
shakeChange=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks=0 {exit} //60fps change (added): one shake step per 30fps tick (every frame shook 2x/4x as fast)
if shakeChange=0
{
  x+=shakePower
  shakeChange=1
}
else if shakeChange=1
{
  x-=shakePower
  shakeChange=0
}
