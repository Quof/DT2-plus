#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_number(self)>1
  instance_destroy()
changeShake=2
viewDirChange=changeShake/2
viewDirShake="Right"
//alarm[0]=8
alarm[0]=8/gDeltaTime //60fps change: alarms count frames; 8 30fps ticks
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
view_wview=512
view_hview=384
instance_destroy()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks=0 {exit} //60fps change (added): the shake steps once per 30fps tick (every frame shook 2x/4x as fast)
viewDirChange+=1

if viewDirChange=changeShake
{
  if viewDirShake="Right"
    viewDirShake="Left"
  else
    viewDirShake="Right"
  viewDirChange=0
}

if viewDirShake="Right"
  view_wview+=6
else
  view_wview-=6
