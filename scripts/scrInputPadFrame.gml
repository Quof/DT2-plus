/*
input text change (added): the sKeyPressPad frame for an input (scrInputCode's codes) with the gamepad in use: the icon
of the button it's set to (scrPadIcon). The menus' fixed actions are START, BACK, A, B and Y; the title screen's
[Menu Up] / [Menu Down] are Up / Down's buttons.
argument0: input code
*/
var c;
c=argument0
if c>=101 {c-=100}
if c>=1 and c<=11 {return scrPadIcon(global.gpBind[c])}
if c=12 {return scrPadIcon(10)} //START
if c=13 {return scrPadIcon(9)} //BACK
if c=14 {return scrPadIcon(1)} //A
if c=15 {return scrPadIcon(2)} //B
if c=16 {return scrPadIcon(4)} //Y
return 30
