#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.15
textColorMain=c_white
textColorBlack=c_black
subMenu=0 //0: main, 1: options, 2: controls
mainCurPos=1
mainInc=24
mainMax=6
mainCurX=6
mainCurY=27

optionCurPos=1
optionInc=12
//optionMax=15
optionMax=17 //frame rate / gamepad change: + Frame Rate (16) and Gamepad Input (17)
optionCurX=6
optionCurY=6

controlCurPos=1
controlInc=13
controlMax=12
controlCurX=5
controlCurY=5
//gamepad change (added): Set Controls shows the keyboard's keys (0) or the gamepad's buttons (1), swapped with [L] / Y.
//padCapture: the row waiting for a button to be pressed (0: none); padCaptureReady: 1 once nothing was held, so the
//next thing pressed is the new button
ctrlPad=0
padCapture=0
padCaptureReady=0

restartFinalConfirm=0
confirmCurPos=1
confirmCurX=6
confirmCurY=56

//Get level
crystalDisplay="5"
if global.lvlCurrent="0-1" or global.lvlCurrent="1-B" or global.lvlCurrent="2-B" or global.lvlCurrent="3-B" or global.lvlCurrent="4-B" or global.lvlCurrent="5-1" or global.lvlCurrent="Final"
{
  crystalDisplay="0"
}
if room=rBonusC1 or room=rBonusC2 or room=rBonusC3 or room=rBonusC4 {crystalDisplay="0"}

//---------- input commands ----------
curUp=ord("W")
curDown=ord("S")
curLeft=ord("A")
curRight=ord("D")
curConfirm=ord("J")
curCancel=ord("K")
curUnPause=ord("P")
curInfo=vk_f1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if restartFinalConfirm=0
{
  if subMenu=0 //---------- Main Menu ----------
  {
    //if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
    if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if mainCurPos=1
      {
        mainCurPos=mainMax
        mainCurY+=mainInc*(mainMax-1)
      }
      else
      {
        mainCurPos-=1
        mainCurY-=mainInc
      }
    }
    //else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
    else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if mainCurPos=mainMax
      {
        mainCurPos=1
        mainCurY-=mainInc*(mainMax-1)
      }
      else
      {
        mainCurPos+=1
        mainCurY+=mainInc
      }
    }

    //if keyboard_check_pressed(curConfirm)
    if keyboard_check_pressed(curConfirm) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
    {
      //input sanitize change (added): restarting or leaving the level (or going into Options / Set Controls) doesn't
      //carry the press on (held keys / pad buttons count as let go until pressed again)
      if mainCurPos>=2
      {
        io_clear()
        scrGamepadSync()
      }
      if mainCurPos=1 //RETURN TO GAME
      {
        io_clear()
        scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
        playSound(global.snd_MenuClose,0,1)
        global.gamePaused=false
        oHUD.menuOpen=false
        instance_destroy()
        exit;
      }
      else if mainCurPos=2 //RESTART LEVEL
      {
        if room!=rExtrasRoom
        {
          if room=rBonusC1 or room=rBonusC2 or room=rBonusC3 or room=rBonusC4
          {
            global.gamePaused=false
            retryLevel()
            room_restart()
          }
          else
          {
            if global.gameProgress<31
            {
              if global.lvlCurrent!="Final"
              {
                retryLevel()
                global.gamePaused=false
                if global.lvlCurrent="0-1"
                  room_goto(rTutorial)
                else if global.lvlCurrent="1-1"
                  room_goto(r1_1a1)
                else if global.lvlCurrent="1-2"
                  room_goto(r1_2a1)
                else if global.lvlCurrent="1-3"
                  room_goto(r1_3a1)
                else if global.lvlCurrent="1-B"
                  room_goto(r1_Ba1)
                else if global.lvlCurrent="2-1"
                  room_goto(r2_1a1)
                else if global.lvlCurrent="2-2"
                  room_goto(r2_2a1)
                else if global.lvlCurrent="2-B"
                  room_goto(r2_Ba1)
                else if global.lvlCurrent="3-1"
                  room_goto(r3_1a1)
                else if global.lvlCurrent="3-2"
                  room_goto(r3_2a1)
                else if global.lvlCurrent="3-3"
                  room_goto(r3_3a1)
                else if global.lvlCurrent="3-B"
                  room_goto(r3_Ba1)
                else if global.lvlCurrent="4-1"
                  room_goto(r4_1a1)
                else if global.lvlCurrent="4-2"
                  room_goto(r4_2a1)
                else if global.lvlCurrent="4-B"
                  room_goto(r4_Ba1)
                else if global.lvlCurrent="5-1"
                  room_goto(r5_1a1)
              }
              else
              {
                io_clear()
                scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
                confirmCurPos=1
                confirmCurY=56
                restartFinalConfirm=1
              }
            }
            else
              playSound(global.snd_MenuCancel,0,1)
          }
        }
      }
      else if mainCurPos=3 //EXIT LEVEL
      {
        if room!=rExtrasRoom
        {
          if global.gameProgress<31
          {
            playSound(global.snd_MenuCancel,0,1)
            room_goto(rWorldMap)
          }
          else
            playSound(global.snd_MenuCancel,0,1)
        }
      }
      else if mainCurPos=4 //OPTIONS
      {
        if room!=rExtrasRoom
          subMenu=1
        else
          playSound(global.snd_MenuCancel,0,1)
      }
      else if mainCurPos=5 //SET CONTROLS
      {
        if room!=rExtrasRoom
          subMenu=2
        else
          playSound(global.snd_MenuCancel,0,1)
      }
      else if mainCurPos=6 //RETURN TO TITLE
      {
        playSound(global.snd_MenuCancel,0,1)
        room_goto(rTitle)
      }
    }
  }
  else if subMenu=1 //---------- Options Menu ----------
  {
    //if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
    if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if optionCurPos=1
      {
        optionCurPos=optionMax
        optionCurY+=optionInc*(optionMax-1)
      }
      else
      {
        optionCurPos-=1
        optionCurY-=optionInc
      }
    }
    //else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
    else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if optionCurPos=optionMax
      {
        optionCurPos=1
        optionCurY-=optionInc*(optionMax-1)
      }
      else
      {
        optionCurPos+=1
        optionCurY+=optionInc
      }
    }

    //if keyboard_check(curLeft) or keyboard_check(vk_left)
    //if gDeltaDoTicks and (keyboard_check(curLeft) or keyboard_check(vk_left))
    if gDeltaDoTicks and (keyboard_check(curLeft) or keyboard_check(vk_left) or scrPadHeld(1)) //gamepad change: and the gamepad (scrGamepadInit)
    //60fps change: a held key changes the volume once per 30fps tick (every frame was 2x/4x as fast, with the cursor sound every frame)
    {
      if optionCurPos=4 //Music Volume
      {
        if global.optMusic>0
        {
          playSound(global.snd_MenuCursor,0,1)
          global.optMusic-=1
          var tempMplay;
          tempMplay=findMusic(1)
          SS_SetSoundVol(tempMplay,global.optMusic*100)
          if global.optMusic=0
            stopAllMusic()
        }
      }
      else if optionCurPos=5 //Sound Volume
      {
        if global.optSound>0
        {
          playSound(global.snd_MenuCursor,0,1)
          global.optSound-=1
        }
      }
    }
    //else if keyboard_check(curRight) or keyboard_check(vk_right)
    //else if gDeltaDoTicks and (keyboard_check(curRight) or keyboard_check(vk_right))
    else if gDeltaDoTicks and (keyboard_check(curRight) or keyboard_check(vk_right) or scrPadHeld(2)) //60fps change: see above //gamepad change: and the gamepad (scrGamepadInit)
    {
      if optionCurPos=4 //Music Volume
      {
        if global.optMusic<100
        {
          playSound(global.snd_MenuCursor,0,1)
          var prevVol,tempMplay;
          prevVol=global.optMusic
          tempMplay=findMusic(1)
          global.optMusic+=1
          if prevVol=0
            playMusic(tempMplay,0)
          SS_SetSoundVol(tempMplay,global.optMusic*100)
        }
      }
      else if optionCurPos=5 //Sound Volume
      {
        if global.optSound<100
        {
          playSound(global.snd_MenuCursor,0,1)
          global.optSound+=1
        }
      }
    }

    //frame rate change (added): Frame Rate (row 16) only shows the frame rate, greyed out: it can only be changed on the
    //title screen ([F2], oInitializeGame), so left / right don't change it here

    //if keyboard_check_pressed(curConfirm)
    //gamepad change: and the gamepad's A; with Gamepad Input off, A still turns it back on from its own row (17)
    if keyboard_check_pressed(curConfirm) or scrPadPressed(14) or (optionCurPos=17 and global.optGamePad=0 and global.gpPressed[14])
    {
      playSound(global.snd_MenuConfirm,0,1)
      if optionCurPos=1 //Low Health Warn
      {
        if global.optLowHealthWarn=1
          global.optLowHealthWarn=0
        else
          global.optLowHealthWarn=1
      }
      else if optionCurPos=2 //Show Points Earned
      {
        if global.optShowPointsEarned=1
          global.optShowPointsEarned=0
        else
          global.optShowPointsEarned=1
      }
      else if optionCurPos=3 //Show Damage
      {
        if global.optShowDamage=1
          global.optShowDamage=0
        else
          global.optShowDamage=1
      }
      else if optionCurPos=4 //Music Volume
      {
        if global.optMusic=0
        {
          global.optMusic=100
          var tempMplay;
          tempMplay=findMusic()
          playMusic(tempMplay,0)
        }
        else
        {
          global.optMusic=0
          stopAllMusic()
        }
      }
      else if optionCurPos=5 //Sound Volume
      {
        if global.optSound=100
          global.optSound=0
        else
          global.optSound=100
      }
      else if optionCurPos=6 //Show HUD
      {
        if global.optShowHUD=1
          global.optShowHUD=0
        else
          global.optShowHUD=1
      }
      else if optionCurPos=7 //Show Enemy Life
      {
        if global.optEnemyHP=1
          global.optEnemyHP=0
        else
          global.optEnemyHP=1
      }
      else if optionCurPos=8 //Auto Save
      {
        if global.optAutoSave=1
          global.optAutoSave=0
        else
          global.optAutoSave=1
      }
      else if optionCurPos=9 //Kill Chain (Screen)
      {
        if global.optKillChainScreen=1
          global.optKillChainScreen=0
        else
          global.optKillChainScreen=1
      }
      else if optionCurPos=10 //Kill Chain (Sound)
      {
        if global.optKillChainSound=1
          global.optKillChainSound=0
        else
          global.optKillChainSound=1
      }
      else if optionCurPos=11 //Killing Spree (Screen)
      {
        if global.optKillingSpreeScreen=1
          global.optKillingSpreeScreen=0
        else
          global.optKillingSpreeScreen=1
      }
      else if optionCurPos=12 //Killing Spree (Sound)
      {
        if global.optKillingSpreeSound=1
          global.optKillingSpreeSound=0
        else
          global.optKillingSpreeSound=1
      }
      else if optionCurPos=13 //D-Pad Dash
      {
        if global.optDPadDash=1
          global.optDPadDash=0
        else
          global.optDPadDash=1
      }
      else if optionCurPos=14 //Right is Forward
      {
        if global.optRightIsForward=1
          global.optRightIsForward=0
        else
          global.optRightIsForward=1
      }
      else if optionCurPos=15 //Dash Warn
      {
        if global.optDashWarn=1
          global.optDashWarn=0
        else
          global.optDashWarn=1
      }
      else if optionCurPos=16 //Frame Rate (frame rate change, added): can't be changed here (see above)
      {
      }
      else if optionCurPos=17 //Gamepad Input (gamepad change, added): kept in DT2Options.dts (saveOptions)
      {
        if global.optGamePad=1
          global.optGamePad=0
        else
          global.optGamePad=1
        scrGamepadSync()
        saveOptions()
      }
    }

    //if keyboard_check_pressed(curCancel)
    if keyboard_check_pressed(curCancel) or scrPadPressed(15) //gamepad change: and the gamepad (scrGamepadInit)
    {
      subMenu=0
    }
  }
  else if subMenu=2 //---------- Controls Menu ----------
  {
    //gamepad change (added): the Gamepad list waiting for a button for row padCapture (Confirm on a row). It waits until
    //nothing is held, then the first thing pressed (but BACK/START, which are Cutscene Skip/Pause) becomes that row's
    //button; if another action had it, that one gets this row's old button. [K] or [Esc] cancels. Nothing else works
    //meanwhile, so the button pressed doesn't also move the cursor or close the menu
    if padCapture>0
    {
      var tCode,tAct,i;
      tCode=scrGamepadCapture()
      if padCaptureReady=0
      {
        if tCode=0
        {
          padCaptureReady=1
          for(i=0;i<16;i+=1) {global.gpCapBase[i]=global.gpAxis[i]}
        }
      }
      else if tCode!=0 and tCode!=9 and tCode!=10
      {
        tAct=global.gpRowAct[padCapture]
        for(i=1;i<=11;i+=1) {if i!=tAct and global.gpBind[i]=tCode {global.gpBind[i]=global.gpBind[tAct]}}
        global.gpBind[tAct]=tCode
        global.gpCustom=1 //the controls are the player's own now: saved and loaded (loadOptions)
        playSound(global.snd_MenuConfirm,0,1)
        padCapture=0
        scrGamepadSync()
        saveOptions()
      }
      if padCapture>0 and (keyboard_check_pressed(curCancel) or keyboard_check_pressed(vk_escape))
      {
        playSound(global.snd_MenuCancel,0,1)
        padCapture=0
        io_clear()
        scrGamepadSync()
      }
      exit
    }
    //gamepad change (added): [L] / Y swaps the keyboard's and the gamepad's lists
    if keyboard_check_pressed(ord("L")) or scrPadPressed(16)
    {
      playSound(global.snd_MenuCursor,0,1)
      ctrlPad=!ctrlPad
    }
    //if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
    if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if controlCurPos=1
      {
        controlCurPos=controlMax
        controlCurY+=controlInc*(controlMax-1)
      }
      else
      {
        controlCurPos-=1
        controlCurY-=controlInc
      }
    }
    //else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
    else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if controlCurPos=controlMax
      {
        controlCurPos=1
        controlCurY-=controlInc*(controlMax-1)
      }
      else
      {
        controlCurPos+=1
        controlCurY+=controlInc
      }
    }

    //gamepad change (added): Confirm in the Gamepad list: wait for a button for the row (see the top), or Restore Default
    if ctrlPad=1 and (keyboard_check_pressed(curConfirm) or scrPadPressed(14))
    {
      if controlCurPos=12 //Restore Default
      {
        playSound(global.snd_MenuConfirm,0,1)
        scrGamepadDefaults()
        saveOptions()
      }
      else if global.gpDevice>=0
      {
        playSound(global.snd_MenuConfirm,0,1)
        padCapture=controlCurPos
        padCaptureReady=0
      }
      else
        playSound(global.snd_MenuCancel,0,1) //no gamepad plugged in
    }
    //if keyboard_check_pressed(curConfirm)
    else if keyboard_check_pressed(curConfirm) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuConfirm,0,1)
      var keyHelpInfo,keyChange;
      keyHelpInfo="Enter the key you would like to#change this action to and press Enter."
      if controlCurPos=1 //Up
      {
        keyChange=get_string(keyHelpInfo,global.ctrlUp)
        global.ctrlUp=string_upper(keyChange)
      }
      else if controlCurPos=2 //Down
      {
        keyChange=get_string(keyHelpInfo,global.ctrlDown)
        global.ctrlDown=string_upper(keyChange)
      }
      else if controlCurPos=3 //Left
      {
        keyChange=get_string(keyHelpInfo,global.ctrlLeft)
        global.ctrlLeft=string_upper(keyChange)
      }
      else if controlCurPos=4 //Right
      {
        keyChange=get_string(keyHelpInfo,global.ctrlRight)
        global.ctrlRight=string_upper(keyChange)
      }
      else if controlCurPos=5 //Jump
      {
        keyChange=get_string(keyHelpInfo,global.ctrlJump)
        global.ctrlJump=string_upper(keyChange)
      }
      else if controlCurPos=6 //Use Fire
      {
        keyChange=get_string(keyHelpInfo,global.ctrlFire)
        global.ctrlFire=string_upper(keyChange)
      }
      else if controlCurPos=7 //Use Water
      {
        keyChange=get_string(keyHelpInfo,global.ctrlWater)
        global.ctrlWater=string_upper(keyChange)
      }
      else if controlCurPos=8 //Use Wind
      {
        keyChange=get_string(keyHelpInfo,global.ctrlWind)
        global.ctrlWind=string_upper(keyChange)
      }
      else if controlCurPos=9 //Use Earth
      {
        keyChange=get_string(keyHelpInfo,global.ctrlEarth)
        global.ctrlEarth=string_upper(keyChange)
      }
      else if controlCurPos=10 //Dash Left
      {
        keyChange=get_string(keyHelpInfo,global.ctrlDashLeft)
        global.ctrlDashLeft=string_upper(keyChange)
      }
      else if controlCurPos=11 //Dash Right
      {
        keyChange=get_string(keyHelpInfo,global.ctrlDashRight)
        global.ctrlDashRight=string_upper(keyChange)
      }
      else if controlCurPos=12 //Set to default controls
      {
        global.ctrlUp="W"
        global.ctrlDown="S"
        global.ctrlLeft="A"
        global.ctrlRight="D"
        global.ctrlJump="J"
        global.ctrlFire="K"
        global.ctrlWater="L"
        global.ctrlWind="I"
        global.ctrlEarth="O"
        global.ctrlDashLeft="Q"
        global.ctrlDashRight="E"
      }
    }

    //if keyboard_check_pressed(curCancel)
    if keyboard_check_pressed(curCancel) or scrPadPressed(15) //gamepad change: and the gamepad (scrGamepadInit)
      subMenu=0
  }
}
else if restartFinalConfirm=1
{
  //if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
  if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
  {
    if confirmCurPos=2
    {
      playSound(global.snd_MenuCursor,0,1)
      confirmCurPos=1
      confirmCurY-=12
    }
  }
  //else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
  else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
  {
    if confirmCurPos=1
    {
      playSound(global.snd_MenuCursor,0,1)
      confirmCurPos=2
      confirmCurY+=12
    }
  }

  //if keyboard_check_pressed(curConfirm)
  if keyboard_check_pressed(curConfirm) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
  {
    if confirmCurPos=1 //YES
    {
      io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
      scrGamepadSync()
      retryLevel()
      global.gamePaused=false
      room_goto(rFinal_a1)
    }
    else if confirmCurPos=2 //NO
    {
      restartFinalConfirm=0
    }
  }

  //if keyboard_check_pressed(curCancel)
  if keyboard_check_pressed(curCancel) or scrPadPressed(15) //gamepad change: and the gamepad (scrGamepadInit)
  {
    restartFinalConfirm=0
  }
}

if keyboard_check_pressed(curInfo)
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  show_info()
}

//if keyboard_check_pressed(curUnPause)
if keyboard_check_pressed(curUnPause) or scrPadPressed(12) //gamepad change: and the gamepad (scrGamepadInit) (START)
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  playSound(global.snd_MenuClose,0,1)
  global.gamePaused=false
  oHUD.menuOpen=false
  oShipHUD.menuOpen=false
  instance_destroy()
  exit;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mainMenuX=view_xview[0]+134
mainMenuY=view_yview[0]+52
contentMenuX=mainMenuX+125
contentMenuY=mainMenuY-12
controlMenuX=mainMenuX+125
controlMenuY=mainMenuY+21
infoMenuX=mainMenuX+125
infoMenuY=mainMenuY+183
draw_set_alpha(1)
draw_set_halign(fa_middle)
draw_set_font(fnt_PauseText)

draw_sprite(sPauseMenu,0,mainMenuX,mainMenuY)
mapIndex=findMapIndex()

//Press F1 for game info
draw_set_color(c_black)
draw_text(mainMenuX+63,mainMenuY+266,"Press F1 for Game Info & Credits")
draw_set_color(c_white)
draw_text(mainMenuX+63,mainMenuY+265,"Press F1 for Game Info & Credits")

//Current Level
draw_set_color(c_black)
draw_text(mainMenuX+63,mainMenuY+4,global.lvlCurrent)
draw_set_color(c_white)
draw_text(mainMenuX+63,mainMenuY+3,global.lvlCurrent)
draw_set_halign(fa_right)
//Best/Target Time
if mapIndex=14 or mapIndex=15 or mapIndex=16
  draw_text(mainMenuX+119,mainMenuY+197,"---- / ----")
else
  draw_text(mainMenuX+119,mainMenuY+197,string(global.lvlTime[mapIndex]) +string(" / ") +string(global.lvlTargetTime))
//Best/Target Score
if mapIndex=3 or mapIndex=6 or mapIndex=10 or mapIndex=13 or mapIndex=15 or mapIndex=16
  draw_text(mainMenuX+119,mainMenuY+221,"---- / ----")
else
  draw_text(mainMenuX+119,mainMenuY+221,string(global.lvlScore[mapIndex]) +string(" / ") +string(global.lvlTargetScore))
//Crystals
draw_set_halign(fa_left)
draw_text(mainMenuX+31,mainMenuY+243,global.currentCrystals)

draw_text(mainMenuX+49,mainMenuY+243,crystalDisplay)

draw_sprite(sPauseCursor,image_index,mainMenuX+mainCurX,mainMenuY+mainCurY)

if subMenu=1
{
  draw_sprite(sOptionMenu,0,contentMenuX,contentMenuY)
  if global.optLowHealthWarn=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+10)
  if global.optShowPointsEarned=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+22)
  if global.optShowDamage=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+34)
  if global.optMusic>0
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+46)
  if global.optSound>0
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+58)
  if global.optShowHUD=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+70)
  if global.optEnemyHP=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+82)
  if global.optAutoSave=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+94)
  if global.optKillChainScreen=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+106)
  if global.optKillChainSound=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+118)
  if global.optKillingSpreeScreen=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+130)
  if global.optKillingSpreeSound=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+142)
  if global.optDPadDash=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+154)
  if global.optRightIsForward=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+166)
  if global.optDashWarn=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+178)

  //frame rate / gamepad change (added): two more rows, Frame Rate (16) and Gamepad Input (17), on a part of the panel
  //drawn under it (the same border colours: dark red, light/orange bevel, dark green inside)
  var tX1,tY1,tX2,tY2,tFps;
  tX1=contentMenuX; tY1=contentMenuY+185; tX2=contentMenuX+136; tY2=contentMenuY+218
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(152,40,8)); draw_rectangle(tX1,tY1,tX2,tY2,false)
  draw_set_color(make_color_rgb(248,224,152)); draw_rectangle(tX1+1,tY1,tX1+1,tY2-1,false)
  draw_set_color(make_color_rgb(240,112,24)); draw_rectangle(tX2-1,tY1,tX2-1,tY2-1,false); draw_rectangle(tX1+1,tY2-1,tX2-1,tY2-1,false)
  draw_set_color(make_color_rgb(240,112,24)); draw_rectangle(tX1+2,tY1,tX1+2,tY2-2,false)
  draw_set_color(make_color_rgb(248,224,152)); draw_rectangle(tX2-2,tY1,tX2-2,tY2-2,false); draw_rectangle(tX1+2,tY2-2,tX2-2,tY2-2,false)
  draw_set_color(make_color_rgb(0,70,30)); draw_rectangle(tX1+4,tY1,tX2-4,tY2-4,false)
  //Gamepad Input's checkbox
  draw_set_color(make_color_rgb(240,112,24)); draw_rectangle(contentMenuX+9,contentMenuY+201,contentMenuX+16,contentMenuY+208,true)
  if global.optGamePad=1
    draw_sprite(sOptionFilled,0,contentMenuX+10,contentMenuY+202)
  tFps=global.gameFrameRate
  if global.frameRateNext!=0 {tFps=global.frameRateNext}
  draw_set_halign(fa_left)
  draw_set_color(c_black)
  draw_text(contentMenuX+21,contentMenuY+187,"Frame Rate")
  draw_text(contentMenuX+99,contentMenuY+187,tFps)
  draw_text(contentMenuX+21,contentMenuY+199,"Gamepad Input")
  draw_set_color(c_gray) //frame rate change: greyed out, it can only be changed on the title screen
  draw_text(contentMenuX+21,contentMenuY+186,"Frame Rate")
  draw_text(contentMenuX+99,contentMenuY+186,tFps)
  draw_set_color(c_white)
  draw_text(contentMenuX+21,contentMenuY+198,"Gamepad Input")

  draw_set_halign(fa_left)
  draw_set_color(c_black)
  draw_text(contentMenuX+99,contentMenuY+43,global.optMusic)
  draw_text(contentMenuX+99,contentMenuY+55,global.optSound)
  draw_set_color(c_white)
  draw_text(contentMenuX+99,contentMenuY+42,global.optMusic)
  draw_text(contentMenuX+99,contentMenuY+54,global.optSound)

  draw_sprite(sOptionCursor,0,contentMenuX+optionCurX,contentMenuY+optionCurY)

  //Descriptions
  //draw_sprite(sInfoMenu,0,infoMenuX,infoMenuY)
  draw_sprite(sInfoMenu,0,infoMenuX,infoMenuY+26) //frame rate / gamepad change: under the panel's two new rows

  if optionCurPos=1 //Low Health Warn
  {
    itemInfo="Give a warning when#life is low."
  }
  else if optionCurPos=2 //Show Points Earned
  {
    itemInfo="Show points earned#from enemies defeated."
  }
  else if optionCurPos=3 //Show Damage
  {
    itemInfo="Show damage dealt to#you and the enemy."
  }
  else if optionCurPos=4 //Music Volume
  {
    itemInfo="Press left / right to#change music volume."
  }
  else if optionCurPos=5 //Sound Volume
  {
    itemInfo="Press left / right to#change sound volume."
  }
  else if optionCurPos=6 //Show HUD
  {
    itemInfo="Show HUD."
  }
  else if optionCurPos=7 //Show Enemy Life
  {
    itemInfo="Show enemy / boss#life gauge."
  }
  else if optionCurPos=8 //Auto Save
  {
    itemInfo="Auto save when a level#is complete."
  }
  else if optionCurPos=9 //Kill Chain (Screen)
  {
    itemInfo="Alert during a kill chain."
  }
  else if optionCurPos=10 //Kill Chain (Sound)
  {
    itemInfo="Alert during a kill chain."
  }
  else if optionCurPos=11 //Killing Spree (Screen)
  {
    itemInfo="Alert during a#killing spree."
  }
  else if optionCurPos=12 //Killing Spree (Sound)
  {
    itemInfo="Alert during a#killing spree."
  }
  else if optionCurPos=13 //D-Pad Dash
  {
    itemInfo="Up+Jump enables dash."
  }
  else if optionCurPos=14 //Right is Forward
  {
    itemInfo="Dash Right means#Dash Forward."
  }
  else if optionCurPos=15 //Dash Warn
  {
    itemInfo="Warn on low#dash points."
  }
  else if optionCurPos=16 //Frame Rate (frame rate change, added)
  {
    itemInfo="Can only be changed#on the title screen,#with [F2]."
  }
  else if optionCurPos=17 //Gamepad Input (gamepad change, added)
  {
    //itemInfo="Play with a gamepad.#Its buttons are in#Set Controls ([L] / Y)."
    itemInfo="Play with a gamepad.#Its buttons are in#Set Controls ([Swap Lists])." //input text change: [L], or Y's icon while the gamepad is in use
  }
  //input text change: the info text through scrDrawInput (its input [tokens] show the keys, or the gamepad's buttons'
  //icons while it's in use; the icons only on the top pass)
  draw_set_color(c_black)
  //draw_text(infoMenuX+7,infoMenuY+5,itemInfo)
  //draw_text(infoMenuX+7,infoMenuY+31,itemInfo) //frame rate / gamepad change: the box is lower (see above)
  scrDrawInput(infoMenuX+7,infoMenuY+31,itemInfo,-1,-1,0) //frame rate / gamepad change: the box is lower (see above)
  draw_set_color(c_white)
  //draw_text(infoMenuX+7,infoMenuY+4,itemInfo)
  //draw_text(infoMenuX+7,infoMenuY+30,itemInfo)
  scrDrawInput(infoMenuX+7,infoMenuY+30,itemInfo,-1,-1,1)
}
else if subMenu=2
{
  draw_sprite(sControlMenu,0,controlMenuX,controlMenuY)

  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_halign(fa_middle)
  draw_set_font(fnt_SubMenu)
  if ctrlPad=0 //gamepad change (added): the keyboard's keys, as before
  {
  draw_text(controlMenuX+14,controlMenuY+6,global.ctrlUp)
  draw_text(controlMenuX+14,controlMenuY+19,global.ctrlDown)
  draw_text(controlMenuX+14,controlMenuY+32,global.ctrlLeft)
  draw_text(controlMenuX+14,controlMenuY+45,global.ctrlRight)
  draw_text(controlMenuX+14,controlMenuY+58,global.ctrlJump)
  draw_text(controlMenuX+14,controlMenuY+71,global.ctrlFire)
  draw_text(controlMenuX+14,controlMenuY+84,global.ctrlWater)
  draw_text(controlMenuX+14,controlMenuY+97,global.ctrlWind)
  draw_text(controlMenuX+14,controlMenuY+110,global.ctrlEarth)
  draw_text(controlMenuX+14,controlMenuY+123,global.ctrlDashLeft)
  draw_text(controlMenuX+14,controlMenuY+136,global.ctrlDashRight)
  draw_text(controlMenuX+14,controlMenuY+149,global.optDashWarn)
  }
  else //gamepad change (added): the gamepad's buttons, at the right of each row ("PRESS" while it waits for one)
  {
    var r;
    draw_set_halign(fa_right)
    for(r=1;r<=11;r+=1)
    {
      if padCapture=r
      {
        draw_set_color(c_yellow)
        draw_text(controlMenuX+131,controlMenuY+6+13*(r-1),"PRESS")
        draw_set_color(c_white)
      }
      else
        draw_text(controlMenuX+131,controlMenuY+6+13*(r-1),scrGamepadName(global.gpBind[global.gpRowAct[r]]))
    }
  }
  //gamepad change (added): which list this is, and how to swap
  draw_set_halign(fa_left)
  //input text change: the swap key is [L], or Y's icon while the gamepad is in use (scrDrawInput; the icon only on the
  //top pass)
  var tSwapHelp;
  if ctrlPad=0 {tSwapHelp="KEYBOARD    [Swap Lists]: GAMEPAD"}
  else {tSwapHelp="GAMEPAD    [Swap Lists]: KEYBOARD"}
  draw_set_color(c_black)
  //if ctrlPad=0 {draw_text(controlMenuX+3,controlMenuY-11,"KEYBOARD    [L] / Y: GAMEPAD")}
  //else {draw_text(controlMenuX+3,controlMenuY-11,"GAMEPAD    [L] / Y: KEYBOARD")}
  scrDrawInput(controlMenuX+3,controlMenuY-11,tSwapHelp,-1,-1,0)
  draw_set_color(c_white)
  //if ctrlPad=0 {draw_text(controlMenuX+3,controlMenuY-12,"KEYBOARD    [L] / Y: GAMEPAD")}
  //else {draw_text(controlMenuX+3,controlMenuY-12,"GAMEPAD    [L] / Y: KEYBOARD")}
  scrDrawInput(controlMenuX+3,controlMenuY-12,tSwapHelp,-1,-1,1)
  if ctrlPad=1
  {
    var tInfo;
    if padCapture>0 {tInfo="Press a button ([K]: cancel)"}
    else if global.gpDevice<0 {tInfo="No gamepad found"}
    else {tInfo=global.gpName}
    draw_set_color(c_black)
    draw_text(controlMenuX+3,controlMenuY+172,tInfo)
    draw_set_color(c_white)
    draw_text(controlMenuX+3,controlMenuY+171,tInfo)
  }

  draw_sprite(sControlCursor,0,controlMenuX+controlCurX,controlMenuY+controlCurY)
}

if restartFinalConfirm=1 //Restart Confirm Window
{
  draw_sprite(sConfirmMenu,0,contentMenuX,contentMenuY)
  draw_sprite(sOptionCursor,0,contentMenuX+confirmCurX,contentMenuY+confirmCurY)
}
