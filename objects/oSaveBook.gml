#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveProg=0
moveSpeed=-0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//move icon
if moveProg=0
{
  //moveSpeed+=0.01
  moveSpeed+=0.01*gDeltaTime //60fps change: per 30fps tick
  if moveSpeed>=0.2
    moveProg=1
}
else if moveProg=1
{
  //moveSpeed-=0.01
  moveSpeed-=0.01*gDeltaTime //60fps change: per 30fps tick
  if moveSpeed<=-0.2
    moveProg=0
}
//y+=moveSpeed
y+=moveSpeed*gDeltaTime //60fps change: per 30fps tick
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
{
  saveData()
}
