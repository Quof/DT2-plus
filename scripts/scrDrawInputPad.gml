/*
input text change (added): for a key drawn on its own (the tutorial panels' [ ] boxes): while the gamepad is the input
being used (global.gpLastUsed), draws the input's button icon (sKeyPressPad, DT3+'s) centered on x and on the middle of a
line of the current font drawn at y, at the current alpha, and returns 1. Otherwise it draws nothing and returns 0, and
the caller draws the key as before:
  if !scrDrawInputPad(5,x,y) {draw_text(x,y,global.ctrlJump)}
argument0: input code (scrInputCode)
argument1: x (the middle of the key's text)
argument2: y (the top of the key's text)
*/
if global.gpLastUsed!=1 {return 0}
draw_sprite_ext(sKeyPressPad,scrInputPadFrame(argument0),argument1,argument2+floor(string_height("M")/2),1,1,0,c_white,draw_get_alpha())
return 1
