//gamepad change (added): argument0: an action (scrGamepadInit). Returns 1 on the frame it's pressed on the gamepad, if
//Gamepad Input is on (pause menu: Options). Used next to the keyboard checks: keyboard_check_pressed(...) or scrPadPressed(action)
return global.optGamePad and global.gpPressed[argument0]
