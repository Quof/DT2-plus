//gamepad change (added): argument0: an action (scrGamepadInit). Returns 1 on the frame it's let go on the gamepad, if
//Gamepad Input is on (pause menu: Options). Used next to the keyboard checks: keyboard_check_released(...) or scrPadReleased(action)
return global.optGamePad and global.gpReleased[argument0]
