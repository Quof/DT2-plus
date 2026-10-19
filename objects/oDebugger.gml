#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xSpot=5936
ySpot=256
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
{
  oPlayer1.x=xSpot
  oPlayer1.y=ySpot
}
