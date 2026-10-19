#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gameCreateEvent()
bStatRender=false
global.mstMoverNum=0 //60fps change (added): see the moving solids in gameStepEvent
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
  gameStepEvent()

//play time
//(gDeltaTime/gDeltaDoTicks are worked out in oFrameControl's Begin Step, so every Step event this frame agrees on whether it's a 30fps tick)
global.playTimeFrameCount+=1
//if global.playTimeFrameCount mod 30=0
if global.playTimeFrameCount mod (30/gDeltaTime)=0 //60fps change: the count is in frames, so a second is 30/gDeltaTime of them (play time ran 2x/4x too fast at 60/120fps)
{
  global.playTimeSecond+=1
  global.sessionPlayTime+=1
  if global.playTimeSecond>=60
  {
    global.playTimeSecond=0
    global.playTimeMinute+=1
    if global.playTimeMinute>=60
    {
      global.playTimeMinute=0
      global.playTimeHour+=1
    }
  }
}

//close the game
if keyboard_check_pressed(vk_escape)
{
  var closeGame;
  closeGame=show_question("Do you want to quit the game? :(")
  if closeGame=true
    game_end()
}

//windowed mode 1x/2x swap
if keyboard_check_pressed(vk_f3)
{
  if global.screenWindowDouble=false
  {
    window_set_size(1024,768)
    window_center()
    global.screenWindowDouble=true
  }
  else
  {
    window_set_size(512,384)
    window_center()
    global.screenWindowDouble=false
  }
  saveOptions() //window size change (added): kept for next time (DT2Options.dts; 2x by default)
}
//windowed/fullscreen mode
/*if keyboard_check_pressed(vk_f4)
{
  if window_get_fullscreen()
  {
    window_set_fullscreen(false)
    window_center()
  }
  else
  {
    window_set_fullscreen(true)
    window_center()
  }
}*/

if global.debugMenu=true //debug commands
{
  //if keyboard_check_pressed(vk_f2)
  if keyboard_check_pressed(vk_f5) //60fps change: F2 changes the frame rate now (oFrameControl), as in DT3+
  {
    if bStatRender=false
      bStatRender=true
    else
      bStatRender=false
  }
  else if keyboard_check_pressed(vk_f6)
  {
    global.difficulty+=1
    if global.difficulty=5
      global.difficulty=1
  }
  else if keyboard_check_pressed(vk_f8)
  {
    if global.gamePaused=0
      global.gamePaused=1
    else
      global.gamePaused=0
  }
  else if keyboard_check_pressed(vk_f11)
  {
    execute_string(get_string("Command?",""))
  }

  if keyboard_check_pressed(ord("N"))
  {
    if oInvisibleSolid.visible=false
    {
      oInvisibleSolid.visible=true
      oInvisibleSlimSolid.visible=true
      oInvisibleRupLowSlope.visible=true
      oInvisibleLupLowSlope.visible=true
      oInvisibleRCeilingLowSlope.visible=true
      oInvisibleLCeilingLowSlope.visible=true
      oInvisibleRupSlope.visible=true
      oInvisibleLupSlope.visible=true
      oInvisibleRCeilingSlope.visible=true
      oInvisibleLCeilingSlope.visible=true
      oInvisiblePlatform.visible=true
    }
    else
    {
      oInvisibleSolid.visible=false
      oInvisibleSlimSolid.visible=false
      oInvisibleRupLowSlope.visible=false
      oInvisibleLupLowSlope.visible=false
      oInvisibleRCeilingLowSlope.visible=false
      oInvisibleLCeilingLowSlope.visible=false
      oInvisibleRupSlope.visible=false
      oInvisibleLupSlope.visible=false
      oInvisibleRCeilingSlope.visible=false
      oInvisibleLCeilingSlope.visible=false
      oInvisiblePlatform.visible=false
    }
  }
  else if keyboard_check_pressed(ord("B"))
  {
    oPlayer1.life=oPlayer1.maxLife
    oPlayer1.fireEnergy=oPlayer1.maxFireEnergy
    oPlayer1.waterEnergy=oPlayer1.maxWaterEnergy
    oPlayer1.windEnergy=oPlayer1.maxWindEnergy
    oPlayer1.earthEnergy=oPlayer1.maxEarthEnergy
  }
  else if keyboard_check(ord("Y"))
    instance_create(0,0,oScreenEffect)
  else if keyboard_check_pressed(ord("R"))
  {
    if global.debugInvincible=false
      global.debugInvincible=true
    else
      global.debugInvincible=false
  }

  if keyboard_check_pressed(vk_numpad1)
  {
    stopLoopingSounds()
    room_restart()
  }
  else if keyboard_check_pressed(vk_numpad3)
  {
    stopLoopingSounds()
    writeToPlayerGlobals()
    room_restart()
  }
  else if keyboard_check_pressed(vk_numpad7)
  {
    if room!=room_first
    {
      writeToPlayerGlobals()
      room_goto_previous()
    }
  }
  else if keyboard_check_pressed(vk_numpad8)
  {
    if room!=room_last
    {
      writeToPlayerGlobals()
      room_goto_next()
    }
  }
  else if keyboard_check_pressed(vk_numpad9)
  {
    stopLoopingSounds()
    stopAllMusic()
    room_goto(rIntro)
  }
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
SS_Unload()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bStatRender=true and instance_exists(oPlayer1)
{
  xSet=view_xview[0]+4
  ySet=view_yview[0]+80
  draw_set_color(make_color_rgb(0,255,0))
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_StatRender)
  draw_text(xSet,ySet,"> fps: " +string(fps))
  draw_text(xSet,ySet+9,"> Object Num: " +string(instance_count))
  draw_text(xSet,ySet+18,"> Player X Vel: " +string(oPlayer1.xVel))
  draw_text(xSet,ySet+27,"> Player Y Vel: " +string(oPlayer1.yVel))
  draw_text(xSet,ySet+36,"> Difficulty: " +string(global.difficulty))
  draw_text(xSet,ySet+45,"> Current Map ID: " +string(room))
  draw_text(xSet,ySet+54,"> Map Prev/Next: " +string(room_previous(room)) +string(" / ") +string(room_next(room)))
  draw_text(xSet,ySet+63,"> Map ID Range: " +string(room_first) +string(" / ") +string(room_last))
  draw_text(xSet,ySet+72,"> Game Progress: " +string(global.gameProgress))
  draw_text(xSet,ySet+81,"> Sound Freq: " +string(findFreq()))
  draw_text(xSet,ySet+90,"> Slow Fall Time: " +string(oPlayer1.slowFallTime))
  draw_text(xSet,ySet+99,"> Slow Fall Effect: " +string(oPlayer1.slowFallEffect))
  draw_text(xSet,ySet+108,"> Extra Vel Time: " +string(oPlayer1.walljumpExtVel))
}
