/*
gamepad change (added): the default gamepad controls (codes and actions: see scrGamepadInit). Used at startup, as the
defaults when the options are loaded (loadOptions) and by Restore Default in the pause menu's Gamepad list.
global.gpCustom is 1 once a control has been changed in that list: only then are the saved controls loaded (loadOptions),
so a change to these defaults reaches anyone who hasn't set their own.
*/
global.gpBind[1]=15   //Left: d-pad left
global.gpBind[2]=16   //Right: d-pad right
global.gpBind[3]=13   //Up: d-pad up
global.gpBind[4]=14   //Down: d-pad down
global.gpBind[5]=1    //Jump: A (Cross)
global.gpBind[6]=3    //Use Fire: X (Square)
global.gpBind[7]=2    //Use Water: B (Circle)
global.gpBind[8]=5    //Use Wind: L1
global.gpBind[9]=4    //Use Earth: Y (Triangle)
global.gpBind[10]=8   //Dash Left (Dash Back while Right is Forward is on, the default): R2
global.gpBind[11]=6   //Dash Right (Dash Forward): R1
global.gpCustom=0
