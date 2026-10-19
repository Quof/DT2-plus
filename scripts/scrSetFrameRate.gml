/*
60fps change (added): sets the frame rate the game runs at (30, 60 or 120): room_speed and the delta time everything
moves by (gDeltaTime = 30/fps). Used by loadOptions, and by oFrameControl at the end of a 30fps tick when [F2] on the
title screen asked for a frame rate (global.frameRateNext); anything else should ask the same way rather than call this
mid-tick.
argument0: frames per second
*/
//GameMaker keeps transition_kind/transition_steps for later room changes, and room_goto_fixed scaled the steps for the
//old frame rate
transition_steps=max(1,round(transition_steps*argument0/global.gameFrameRate))
global.gameFrameRate=argument0
room_speed=global.gameFrameRate
gDeltaTime=30/global.gameFrameRate
gDeltaDoTicks=0
gDeltaTick=0.0
