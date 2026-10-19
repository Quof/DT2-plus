#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//gamepad change (added): reads the gamepad for the whole game (persistent; made in rIntro's creation code, after
//oFrameControl). Ported from DT1 Plus's oGamepad / DT3+'s oKeyCodesHighFPS: scrGamepadInit explains the controls,
//scrGamepadPoll reads the pad
if instance_number(oGamepad)>1 {instance_destroy(); exit}
scrGamepadInit()
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//read the gamepad once per frame, before any Step event asks for it (scrPadHeld/scrPadPressed/scrPadReleased)
scrGamepadPoll()
