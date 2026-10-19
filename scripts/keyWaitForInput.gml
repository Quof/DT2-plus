/*
This makes the script wait for the next input command.
*/
//if (keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter)) and bWaitForInput=true
if (keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter) or scrPadPressed(14)) and bWaitForInput=true //gamepad change: and the gamepad (scrGamepadInit)
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  bWaitForInput=false
  with oMessageCutscene
    instance_destroy()
  sceneProgress+=1
}
