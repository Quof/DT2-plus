#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
loadImage=false
introFadeIn=1
//load external files
if !variable_global_exists("gamePriority")
{
  //SS_Init()
  loadExtFiles()
  global.gamePriority=0
}
stopAllMusic()
global.debugMenu=0
versionTag="1.0.6.3"
if !SS_IsSoundLooping(global.msc_TitleMenu) {SS_LoopSound(global.msc_TitleMenu)}
//check ini
ini_open("DT2save.dts")
currentCheck="ALPHA"
f1_Hours=ini_read_real(currentCheck,"101",0)
f1_Minutes=ini_read_real(currentCheck,"102",0)
f1_Seconds=ini_read_real(currentCheck,"103",0)
f1_GamePercent=ini_read_real(currentCheck,"104",0)
f1_GameProgress=ini_read_real(currentCheck,"105",0)
f1_GameBeat=ini_read_real(currentCheck,"108",0)
for(i=0;i<4;i+=1)
{
  f1_challScore[i]=ini_read_real(currentCheck,string("ch1") +string(i),0); f1_challScore[i]=encryptDecrypt(f1_challScore[i],1)
}
currentCheck="BETA"
f2_Hours=ini_read_real(currentCheck,"101",0)
f2_Minutes=ini_read_real(currentCheck,"102",0)
f2_Seconds=ini_read_real(currentCheck,"103",0)
f2_GamePercent=ini_read_real(currentCheck,"104",0)
f2_GameProgress=ini_read_real(currentCheck,"105",0)
f2_GameBeat=ini_read_real(currentCheck,"108",0)
for(i=0;i<4;i+=1)
{
  f2_challScore[i]=ini_read_real(currentCheck,string("ch1") +string(i),0); f2_challScore[i]=encryptDecrypt(f2_challScore[i],1)
}
ini_close()

//initialize player stats
global.p1MaxLife=24
global.p1Life=global.p1MaxLife
global.p1Power=10
global.p1Defense=0

//element levels
global.techLv=0
global.fireLv=1
global.waterLv=1
global.windLv=1
global.earthLv=1

//spirit and element stats
global.p1MaxFireEnergy=20
global.p1FireEnergy=global.p1MaxFireEnergy
global.p1MaxWaterEnergy=20
global.p1WaterEnergy=global.p1MaxWaterEnergy
global.p1MaxWindEnergy=20
global.p1WindEnergy=global.p1MaxWindEnergy
global.p1MaxEarthEnergy=20
global.p1EarthEnergy=global.p1MaxEarthEnergy

//0=None,1=Fire,2=Water,3=Wind,4=Earth
//global.p1FireEquip="FIREBALL"
//global.p1WaterEquip="WATER BLAST"
//global.p1WindEquip="WIND BURST"
//global.p1EarthEquip="ROCK SMASH"

//important item flags
global.hasWindBoots=1 //Can jump
global.hasAwesomeShoes=1 //Can dash
global.hasSuaveToken=1 //Can air dash
global.hasWallGrinder=1 //Can wall jump
global.canUseFire=1
global.canUseWater=1
global.canUseWind=1
global.canUseEarth=1

//play time
global.playTimeHour=0
global.playTimeMinute=0
global.playTimeSecond=0
global.playTimeFrameCount=0

//level play time
global.levelTimeSecond=0
global.levelTimeFrameCount=0

//level specific stuff
global.lvlCurrent="1-1"
global.currentCrystals=0
global.consecCry=0
global.currentScore=0

global.recordScore=0
global.recordTime=0

global.lvlTargetTime=0
global.lvlTargetScore=0
global.maxLevels=16
global.gameRank=0

//========================================
//============== game flags ==============
//========================================
//level completion flags
for(i=0;i<global.maxLevels;i+=1)
{
  global.lvlComplete[i]=0
  global.lvlCrystal[i]=0
  global.lvlTime[i]=0
  global.lvlScore[i]=0
}

for(i=0;i<4;i+=1)
{
  global.challScore[i]=-1
}

//game state data
global.gameProgress=0            //the game's global progress state
global.storyProgress=0           //progress on added story content
global.currentQuestLog=0         //which file the player is using
global.gamePaused=true           //if the game is paused
global.gameOver=false            //if the game over screen is showing
global.showHUD=false             //if the HUD should be displayed
global.cutscene=false            //used so the character can be moved during cutscenes easier
global.currentBoss=""            //the current boss battle in progress
global.p1KillCount=0             //the player's kill count
global.deathCount=0              //how many times the player has lost
global.difficulty=2              //game difficulty. 1=Easy, 2=Normal(default), 3=Hard, 4=Very Hard
global.newMapX=0                 //where to place the player on a new map
global.newMapY=0                 //where to place the player on a new map
global.killingSpree=0            //current kills in killing spree
global.killSpreeSoundCheck=0     //checks the sound being played
//global.screenWindowDouble=false  //if window is set to 2x mode
if !variable_global_exists("screenWindowDouble") {global.screenWindowDouble=true} //window size change: the window is 2x by default, kept in DT2Options.dts (loadOptions sets it before the title screen), so it is left as it is here
global.rbSwitchBlueOn=false      //which switch color is active
global.levelLimer[0]=0           //current timer (countdown)
global.sessionPlayTime=0         //how long the player has been playing this play session
global.soundAmplify=1            //sound frequency multiplier
global.gamePercent=0             //game content completion percent
global.hitsTaken=0               //number of times taken damage in a level
global.bossTrack=0               //used for continuing in boss fights
global.saveOnAuto=0              //auto save when going to world map

for(i=0;i<5;i+=1)
  global.crystalNum[i]=0

//timer
global.cTimerMinute=0
global.cTimerSecond=0
global.cTimerHundred=0

//options flags
global.optLowHealthWarn=1
global.optShowPointsEarned=1
global.optShowDamage=1
global.optMusic=100
global.optSound=100
global.optFairy=1
global.optEnemyHP=1
global.optAutoSave=0
global.optKillChainScreen=1
global.optKillChainSound=1
global.optKillingSpreeScreen=1
global.optKillingSpreeSound=1
//global.optDPadDash=1
global.optDPadDash=0 //options change: D-Pad Dash (Up/Down + Jump dashes) is off by default
global.optRightIsForward=1
global.optShowHUD=1
//global.optGamePad=1
if !variable_global_exists("optGamePad") {global.optGamePad=1} //gamepad change: Gamepad Input is kept in DT2Options.dts (loadOptions), for the whole game rather than a save slot, so the title screen leaves it as it is
global.optDashWarn=0

//main characters
global.mainCharacters[0]="Jerry"           //The original protagonist
global.mainCharacters[1]="Jeremy"          //Jerry's best friend
global.mainCharacters[2]="The Darkness"    //The Dark Entity
global.mainCharacters[3]="Claire"          //Protagonist
global.mainCharacters[4]="Chao"            //Protagonist's Sidekick

//controls
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

//initialize start up screen --------------------------------------------------
if f1_GameProgress=0 and f2_GameProgress=0
{
  fileCursorPos=1
  fileCursorY=154
}
else //Start cursor on "Continue" if the player has a saved game in progress
{
  fileCursorPos=2
  fileCursorY=188
}
fileCursorX=296
cursorMoveInc=34
arraySizeMax=3
choiceMade=0 //0:main, 1:new, 2:continue
sFade=0
//intro data
introProgress=0
loadImage=true
loadingType=""
//controlHelp="Controls:#[W] Up    [S] Down#[J] Confirm    [K] Cancel"
controlHelp="Controls:#[Menu Up] Up    [Menu Down] Down#[Confirm] Confirm    [Cancel] Cancel" //input text change: the keys, or the gamepad's buttons while it's in use (textDropShadow, scrInputCode)
fpsShowTime=0 //frame rate change (added): 30fps ticks the controls help shows the frame rate after [F2] changes it

global.debugInvincible=false
global.debugMouseMove=false

//Time fix for old save files before "1.0.5.0"
global.saveFile_TimeFix=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//frame rate change (added): [F2] changes the frame rate (30 -> 60 -> 120), only here on the title screen (the pause
//menu's Frame Rate row just shows it). The change is made at the end of the current 30fps tick (global.frameRateNext,
//oFrameControl), which saves it; the controls help shows the new rate for 2 seconds
if keyboard_check_pressed(vk_f2)
{
  var tFps;
  tFps=global.gameFrameRate
  if global.frameRateNext!=0 {tFps=global.frameRateNext}
  if tFps=30 {global.frameRateNext=60}
  else if tFps=60 {global.frameRateNext=120}
  else {global.frameRateNext=30}
  playSound(global.snd_MenuCursor,0,1)
  fpsShowTime=60
}
if fpsShowTime>0 {fpsShowTime-=1*gDeltaTime}

//cursor movement
if introFadeIn<=0.8
{
  //if keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) and choiceMade<=3
  if keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) or scrPadPressed(4) and choiceMade<=3 //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if fileCursorPos<arraySizeMax
    {
      fileCursorY+=cursorMoveInc
      fileCursorPos+=1
    }
    else
    {
      fileCursorY-=cursorMoveInc*(arraySizeMax-1)
      fileCursorPos=1
    }
  }
  //else if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) and choiceMade<=3
  else if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or scrPadPressed(3) and choiceMade<=3 //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if fileCursorPos>1
    {
      fileCursorY-=cursorMoveInc
      fileCursorPos-=1
    }
    else
    {
      fileCursorY+=cursorMoveInc*(arraySizeMax-1)
      fileCursorPos=arraySizeMax
    }
  }

  //start game
  //if keyboard_check_pressed(ord("J")) and choiceMade<=3
  if (keyboard_check_pressed(ord("J")) or scrPadPressed(14)) and choiceMade<=3 //gamepad change: and the gamepad (scrGamepadInit)
  {
    if choiceMade=0 //main
    {
      if fileCursorPos=1 or fileCursorPos=2
      {
        playSound(global.snd_MenuConfirm,0,1)
        fileCursorY=154
        arraySizeMax=2
        cursorMoveInc=58
        choiceMade=fileCursorPos
        fileCursorPos=1
      }
      else if fileCursorPos=3
        game_end()
    }
    else if choiceMade=1 //new
    {
      global.currentQuestLog=fileCursorPos
      arraySizeMax=3
      fileCursorPos=2
      sFade=1
      choiceMade=3

      global.gamePaused=0
      global.showHUD=1
      global.saveFile_TimeFix=1
      SS_StopSound(global.msc_TitleMenu)
      io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
      scrGamepadSync()
      room_goto(rTutorial)
    }
    else if choiceMade=2 //continue
    {
      if fileCursorPos=1
        sectionRead="ALPHA"
      else if fileCursorPos=2
        sectionRead="BETA"
      if sectionRead="ALPHA" and f1_GamePercent>0
      {
        loadSaveData(0)
        global.currentQuestLog=1
        global.resetMusic=true
        SS_StopSound(global.msc_TitleMenu)
        io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
        scrGamepadSync()
        room_goto(rWorldMap)
      }
      else if sectionRead="BETA" and f2_GamePercent>0
      {
        loadSaveData(0)
        global.currentQuestLog=2
        global.resetMusic=true
        SS_StopSound(global.msc_TitleMenu)
        io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
        scrGamepadSync()
        room_goto(rWorldMap)
      }
    }
    /*else if choiceMade=3 //difficulty select
    {
      global.difficulty=fileCursorPos
      global.gamePaused=0
      global.showHUD=1
      global.optMusic=0
      SS_StopSound(global.msc_TitleMenu)
      room_goto(rTutorial)
    }*/
  }
  //else if keyboard_check_pressed(ord("K")) and choiceMade<=3
  else if (keyboard_check_pressed(ord("K")) or scrPadPressed(15)) and choiceMade<=3 //gamepad change: and the gamepad (scrGamepadInit)
  {
    if choiceMade=1 or choiceMade=2
    {
      playSound(global.snd_MenuCancel,0,1)
      fileCursorPos=1
      fileCursorY=154
      arraySizeMax=3
      cursorMoveInc=34
      choiceMade=0
    }
  }
}

if f1_GameBeat=2 or f2_GameBeat=2 //go to extras room
{
  //if keyboard_check_pressed(ord("P"))
  if keyboard_check_pressed(ord("P")) or scrPadPressed(12) //gamepad change: and the gamepad (scrGamepadInit) (START)
  {
    SS_StopSound(global.msc_TitleMenu)
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    room_goto(rExtrasRoom)
  }
}

//close the game
if !instance_exists(oGame)
{
  if keyboard_check_pressed(vk_escape)
  {
    var closeGame;
    closeGame=show_question("Do you want to quit the game? :(")
    if closeGame=true
      game_end()
  }
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oGame)
  SS_Unload()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if loadImage=false
{
  loadingBarMax=97
  draw_set_alpha(1)
  draw_set_font(fnt_Continue)
  draw_set_halign(fa_center)
  draw_set_color(c_ltgray)
  draw_rectangle(162,156,164+loadingBarMax,162,false)
  draw_set_color(c_white)
  draw_rectangle(162,156,164+loadingBarMax,162,true)
  draw_set_color(c_green)
  draw_text(244,112,"Loading External Files")
  draw_rectangle(163,157,163+loadingBar,161,false)
  draw_text(244,170,"Loading: " +string(loadingType))
}
else
{
  draw_set_color(c_black)
  draw_set_alpha(0.4)
  draw_rectangle(2,2,88,14,0) //version darken
  draw_rectangle(2,368,122,381,0) //Game by darken
  //draw_rectangle(376,337,509,382,0) //control help darken
  draw_rectangle(376,324,509,382,0) //control help darken //frame rate change: a line taller, for [F2] Frame Rate
  draw_set_alpha(1)

  //DT2 Title
  draw_sprite(sTitleText,0,10,70)
  draw_sprite(sSubTitleText,0,10,102)

  //file slots
  if choiceMade=0
  {
    draw_sprite(sFileSelections,0,342,138)
    draw_sprite(sFileSelections,1,342,172)
    draw_sprite(sFileSelections,2,342,206)
  }
  else if choiceMade=1 or choiceMade=2
  {
    draw_sprite(sFileSlots,0,342,126)
    draw_sprite(sFileSlots,1,342,184)

    draw_set_font(fnt_SubMenu)
    draw_set_color(make_color_rgb(0,255,0))
    draw_set_halign(fa_right)

    //----- Quest Record Slot 1 -----
    draw_text(432,131,string(f1_GamePercent) +string("%"))
    if f1_GamePercent>0
    {
      draw_text(463,162,f1_Hours)
      draw_text(466,162,":")
      if f1_Minutes<10
        draw_text(472,162,"0")
      draw_text(478,162,f1_Minutes)
      draw_text(481,162,":")
      if f1_Seconds<10
        draw_text(487,162,"0")
      draw_text(493,162,f1_Seconds)

      if f1_challScore[0]>=9 {draw_sprite_ext(sChallengeMedals,0,361,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[0]>=18 {draw_sprite_ext(sChallengeMedals,1,361,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[0]>=36 {draw_sprite_ext(sChallengeMedals,2,361,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[1]>=10 {draw_sprite_ext(sChallengeMedals,0,382,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[1]>=20 {draw_sprite_ext(sChallengeMedals,1,382,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[1]>=40 {draw_sprite_ext(sChallengeMedals,2,382,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[2]>=13 {draw_sprite_ext(sChallengeMedals,0,403,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[2]>=26 {draw_sprite_ext(sChallengeMedals,1,403,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[2]>=52 {draw_sprite_ext(sChallengeMedals,2,403,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[3]>=15 {draw_sprite_ext(sChallengeMedals,0,424,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[3]>=30 {draw_sprite_ext(sChallengeMedals,1,424,154,0.7,0.7,0,c_white,1)}
      if f1_challScore[3]>=60 {draw_sprite_ext(sChallengeMedals,2,424,154,0.7,0.7,0,c_white,1)}

      if f1_GameBeat>0
        draw_sprite(sEnemyDieStar,0,440,138)
    }
    else
      draw_text(493,162,"--:--:--")

    //----- Quest Record Slot 2 -----
    draw_text(432,189,string(f2_GamePercent) +string("%"))
    if f2_GamePercent>0
    {
      draw_text(463,220,f2_Hours)
      draw_text(466,220,":")
      if f2_Minutes<10
        draw_text(472,220,"0")
      draw_text(478,220,f2_Minutes)
      draw_text(481,220,":")
      if f2_Seconds<10
        draw_text(487,220,"0")
      draw_text(493,220,f2_Seconds)

      if f2_challScore[0]>=9 {draw_sprite_ext(sChallengeMedals,0,361,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[0]>=18 {draw_sprite_ext(sChallengeMedals,1,361,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[0]>=36 {draw_sprite_ext(sChallengeMedals,2,361,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[1]>=10 {draw_sprite_ext(sChallengeMedals,0,382,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[1]>=20 {draw_sprite_ext(sChallengeMedals,1,382,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[1]>=40 {draw_sprite_ext(sChallengeMedals,2,382,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[2]>=13 {draw_sprite_ext(sChallengeMedals,0,403,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[2]>=26 {draw_sprite_ext(sChallengeMedals,1,403,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[2]>=52 {draw_sprite_ext(sChallengeMedals,2,403,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[3]>=15 {draw_sprite_ext(sChallengeMedals,0,424,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[3]>=30 {draw_sprite_ext(sChallengeMedals,1,424,212,0.7,0.7,0,c_white,1)}
      if f2_challScore[3]>=60 {draw_sprite_ext(sChallengeMedals,2,424,212,0.7,0.7,0,c_white,1)}

      if f2_GameBeat>0
        draw_sprite(sEnemyDieStar,0,440,196)
    }
    else
      draw_text(493,220,"--:--:--")
  }
  draw_set_font(fnt_MenuInfo)
  draw_set_halign(fa_left)
  draw_set_color(c_black)
  //textDropShadow(controlHelp,379,337,c_white,c_black,4)
  //frame rate change: + [F2] Frame Rate (the frame rate can only be changed here), with the new rate for a moment after
  //[F2] changes it
  var tFpsHelp,tFps;
  tFpsHelp="#[F2] Frame Rate"
  if fpsShowTime>0
  {
    tFps=global.gameFrameRate
    if global.frameRateNext!=0 {tFps=global.frameRateNext}
    tFpsHelp+=": " +string(tFps)
  }
  textDropShadow(controlHelp +tFpsHelp,379,324,c_white,c_black,4)
  textDropShadow("Game by ZephyrBurst",3,367,c_white,c_black,4)
  textDropShadow("Version: " +string(versionTag),3,1,c_white,c_black,4)

  if f1_GameBeat=2 or f2_GameBeat=2 //extras room info
  {
    draw_set_color(c_black)
    draw_set_alpha(0.4)
    draw_rectangle(132,368,300,381,0)
    draw_set_alpha(1)
    //textDropShadow("Press [P] to go to Extras Room",134,367,c_white,c_black,4)
    textDropShadow("Press [Pause] to go to Extras Room",134,367,c_white,c_black,4) //input text change: [P], or START's icon while the gamepad is in use
  }

  //slot descriptions
  draw_set_color(c_white)
  draw_set_halign(fa_left)
  if choiceMade=0
  {
    if fileCursorPos=1
      cursorTip="Start a new game."
    else if fileCursorPos=2
      cursorTip="Continue from where you left off."
    else if fileCursorPos=3
      cursorTip="Close the game and play later...#you BETTER play later!"
  }
  else if choiceMade=1
  {
    if fileCursorPos=1
      cursorTip="Start a new game in slot 1.#Probably what you will do."
    else if fileCursorPos=2
      cursorTip="Start a new game in slot 2.#Trying to be different...#or are you the younger brother?"
  }
  else if choiceMade=2
  {
    if fileCursorPos=1
      cursorTip="Continue from slot 1.#I knew you would."
    else if fileCursorPos=2
      cursorTip="Continue from slot 2.#Yeah, you're most likely the younger brother...#why are you on your brother's computer?"
  }
  textDropShadow(cursorTip,56,216,c_white,c_black,4)
  //file cursor
  draw_sprite(sGameOverCursor,0,fileCursorX,fileCursorY)

  //if introFadeIn>0 {introFadeIn-=0.01}
  if introFadeIn>0 {introFadeIn-=0.01*gDeltaTime} //60fps change: per 30fps tick (Draw runs every frame)
}

draw_set_color(c_black)
draw_set_alpha(introFadeIn)
draw_rectangle(-1,-1,room_width+1,room_height+1,0)
