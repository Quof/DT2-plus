/*
60fps change (added): writes the options that aren't kept in a save slot to DT2Options.dts (see loadOptions): the
frame rate, (gamepad change) Gamepad Input and the gamepad controls, and (window size change) the window size. Called
when [F2] on the title screen changes the frame rate (oFrameControl), when the pause menu changes Gamepad Input or a
gamepad control, and when [F3] changes the window size (oGame).
*/
var i;
ini_open("DT2Options.dts")
ini_write_real("Options","FrameRate",global.gameFrameRate)
ini_write_real("Options","GamePad",global.optGamePad) //gamepad change (added)
ini_write_real("Gamepad","Custom",global.gpCustom) //gamepad change (added): whether the controls below are the player's own (loadOptions)
for(i=1;i<=11;i+=1) {ini_write_real("Gamepad","Bind" +string(i),global.gpBind[i])} //gamepad change (added)
ini_write_real("Options","WindowDouble",global.screenWindowDouble) //window size change (added)
ini_close()
