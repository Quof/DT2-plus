/*
input text change (added): the sKeyPressPad frame (DT3+'s button icons) for a gamepad code (the codes: scrGamepadInit),
Xbox or PlayStation icons by the pad (global.gpPlayStation). As in DT3+.
argument0: gamepad code
*/
var c;
c=argument0
if c>=1 and c<=12 {return c-1+12*global.gpPlayStation} //face buttons, L1/R1, L2/R2, BACK, START, L3, R3
if c>=13 and c<=16 {return 24+c-13} //d-pad up, down, left, right
if c>=17 and c<=20 {return 28} //left stick
if c>=21 and c<=24 {return 29} //right stick
return 30 //a raw button or axis
