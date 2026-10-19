#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//invertTime-=1
invertTime-=1*gDeltaTime //60fps change: counts 30fps ticks
if invertTime<=0
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
colorInverter(0,room_width,room_height)
