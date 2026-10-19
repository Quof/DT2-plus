/*
60fps change (added): loads the options that aren't kept in a save slot (they're for the whole game, whichever file is
played) from DT2Options.dts: the frame rate (30, 60 or 120; 120 if there's no file yet or it has something else),
(gamepad change) Gamepad Input and the gamepad controls (only if they were changed in the pause menu, "Custom": otherwise
the defaults scrGamepadInit set, so new defaults replace old ones that were saved) and (window size change) the window
size: 2x (1024x768) unless [F3] made it 1x.
Called once from rIntro's creation code, after oGamepad is made; saveOptions writes the file.
*/
var tFps,i;
ini_open("DT2Options.dts")
tFps=ini_read_real("Options","FrameRate",120)
global.optGamePad=ini_read_real("Options","GamePad",1) //gamepad change (added)
global.gpCustom=ini_read_real("Gamepad","Custom",0) //gamepad change (added)
if global.gpCustom=1 {for(i=1;i<=11;i+=1) {global.gpBind[i]=ini_read_real("Gamepad","Bind" +string(i),global.gpBind[i])}} //gamepad change (added)
else {global.gpCustom=0}
global.screenWindowDouble=ini_read_real("Options","WindowDouble",1) //window size change (added): 2x by default
ini_close()
if tFps!=30 and tFps!=60 and tFps!=120 {tFps=120}
scrSetFrameRate(tFps)
if global.optGamePad!=0 {global.optGamePad=1} //gamepad change (added)
//window size change (added): the window's size, as [F3] sets it (oGame)
if global.screenWindowDouble!=0 {global.screenWindowDouble=true; window_set_size(1024,768)}
else {global.screenWindowDouble=false; window_set_size(512,384)}
window_center()
