#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.gamePaused=false
global.currentBoss=""
global.bossTrack=0
global.recordScore=0
global.recordTime=0
retryLevel()

//----- Obscure map areas -----
if global.lvlComplete[0]=0 //1-2
{
  instance_create(124,92,oObscureMap)
  instance_create(148,84,oObscureMap)
  instance_create(92,108,oObscureMap)
}
if global.lvlComplete[1]=0 //1-3
{
  instance_create(140,116,oObscureMap)
  instance_create(176,116,oObscureMap)
  instance_create(100,140,oObscureMap)
}
if global.lvlComplete[2]=0 //1-B
{
  instance_create(124,156,oObscureMap)
  instance_create(164,156,oObscureMap)
}
if global.lvlComplete[3]=0 //2-1
{
  instance_create(164,180,oObscureMap)
  instance_create(196,188,oObscureMap)
  instance_create(172,212,oObscureMap)
  instance_create(132,196,oObscureMap)
}
if global.lvlComplete[4]=0 //2-2
{
  instance_create(204,220,oObscureMap)
  instance_create(236,220,oObscureMap)
}
if global.lvlComplete[5]=0 //2-B
{
  instance_create(172,252,oObscureMap)
  instance_create(212,252,oObscureMap)
  instance_create(180,284,oObscureMap)
}
if global.lvlComplete[6]=0 //3-1
{
  instance_create(236,268,oObscureMap)
  instance_create(212,300,oObscureMap)
  instance_create(252,308,oObscureMap)
  instance_create(260,292,oObscureMap)
}
if global.lvlComplete[7]=0 //3-2
{
  instance_create(292,300,oObscureMap)
  instance_create(284,268,oObscureMap)
}
if global.lvlComplete[8]=0 //3-3
{
  instance_create(268,236,oObscureMap)
  instance_create(308,236,oObscureMap)
}
if global.lvlComplete[9]=0 //3-B
{
  instance_create(276,204,oObscureMap)
  instance_create(308,204,oObscureMap)
  instance_create(340,220,oObscureMap)
}
if global.lvlComplete[10]=0 //4-1
{
  instance_create(372,196,oObscureMap)
  instance_create(380,236,oObscureMap)
  instance_create(412,196,oObscureMap)
  instance_create(340,172,oObscureMap)
  instance_create(396,164,oObscureMap)
}
if global.lvlComplete[11]=0 //4-2
{
  instance_create(412,132,oObscureMap)
  instance_create(364,140,oObscureMap)
}
if global.lvlComplete[12]=0 //4-B
{
  instance_create(372,100,oObscureMap)
  instance_create(412,100,oObscureMap)
  instance_create(324,116,oObscureMap)
  instance_create(348,116,oObscureMap)
}
if global.lvlComplete[13]=0 //5-1
{
  instance_create(276,92,oObscureMap)
  instance_create(292,132,oObscureMap)
  instance_create(244,132,oObscureMap)
  instance_create(236,92,oObscureMap)
  instance_create(268,124,oObscureMap)
}
if global.lvlComplete[14]=0 //Final
{
  instance_create(220,20,oObscureMap)
  instance_create(252,20,oObscureMap)
  instance_create(220,52,oObscureMap)
  instance_create(252,52,oObscureMap)
  instance_create(180,28,oObscureMap)
  instance_create(292,28,oObscureMap)
}

//----- Set menu variables -----
image_speed=0.2
mapCurPos=1
mapCurX=108
mapCurY=135
mapIndex=0

mapMax=1
for(i=0;i<global.maxLevels;i+=1)
{
  if global.lvlComplete[i]=1
    mapMax+=1
}
//mapMax=global.maxLevels

//----- Place player in correct spot -----
if global.lvlCurrent="0-1" {mapCurPos=0}
else if global.lvlCurrent="1-1" {mapCurPos=1}
else if global.lvlCurrent="1-2" {mapCurPos=2}
else if global.lvlCurrent="1-3" {mapCurPos=3}
else if global.lvlCurrent="1-B" {mapCurPos=4}
else if global.lvlCurrent="2-1" {mapCurPos=5}
else if global.lvlCurrent="2-2" {mapCurPos=6}
else if global.lvlCurrent="2-B" {mapCurPos=7}
else if global.lvlCurrent="3-1" {mapCurPos=8}
else if global.lvlCurrent="3-2" {mapCurPos=9}
else if global.lvlCurrent="3-3" {mapCurPos=10}
else if global.lvlCurrent="3-B" {mapCurPos=11}
else if global.lvlCurrent="4-1" {mapCurPos=12}
else if global.lvlCurrent="4-2" {mapCurPos=13}
else if global.lvlCurrent="4-B" {mapCurPos=14}
else if global.lvlCurrent="5-1" {mapCurPos=15}
else if global.lvlCurrent="Final" {mapCurPos=16}

mainCurPos=1
mainInc=16
mainMax=5
mainCurY=39

menuActive=false
starSpin=0
lvlName=""
lvlTime=0
lvlScore=0

detailsX=322
detailsY=8
mapMenuX=(room_width/2)+10
mapMenuY=83
scoreMenuX=97
scoreMenuY=8

for(i=0;i<3;i+=1)
{
  cStar[i]=instance_create(0,0,oMisc)
  cStar[i].type=0
  cStar[i].sprite_index=sCharacterStar
  cStar[i].image_speed=0.15
  cStar[i].depth=41
}

//---------- input commands ----------
curUp=ord("W")
curDown=ord("S")
curLeft=ord("A")
curRight=ord("D")
curConfirm=ord("J")
curMenu=ord("K")

menuScoreDisplay(0)
if global.optAutoSave=1 and global.saveOnAuto=1
{
  saveData()
  global.saveOnAuto=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//world map functions
if !instance_exists(oHowToPlay) and !instance_exists(oBonusMenu)
{
  if menuActive=false
  {
    //if keyboard_check_pressed(curLeft) or keyboard_check_pressed(vk_left)
    if keyboard_check_pressed(curLeft) or keyboard_check_pressed(vk_left) or scrPadPressed(1) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if mapCurPos=0
      {
        mapCurPos=mapMax
      }
      else
      {
        mapCurPos-=1
      }
    }
    //else if keyboard_check_pressed(curRight) or keyboard_check_pressed(vk_right)
    else if keyboard_check_pressed(curRight) or keyboard_check_pressed(vk_right) or scrPadPressed(2) //gamepad change: and the gamepad (scrGamepadInit)
    {
      playSound(global.snd_MenuCursor,0,1)
      if mapCurPos=mapMax
      {
        mapCurPos=0
      }
      else
      {
        mapCurPos+=1
      }
    }

    //if keyboard_check_pressed(curConfirm) or keyboard_check_pressed(vk_enter)
    if keyboard_check_pressed(curConfirm) or keyboard_check_pressed(vk_enter) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
    {
      io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
      scrGamepadSync()
      if mapCurPos=0
      {
        stopAllMusic()
        room_goto(rTutorial)
      }
      else if mapCurPos=1
      {
        stopAllMusic()
        room_goto(r1_1a1)
      }
      else if mapCurPos=2
      {
        stopAllMusic()
        if global.storyProgress=0 {room_goto(rCutscene_1)}
        else {room_goto(r1_2a1)}
      }
      else if mapCurPos=3
      {
        stopAllMusic()
        if global.storyProgress=1 {room_goto(rCutscene_2)}
        else {room_goto(r1_3a1)}
      }
      else if mapCurPos=4
      {
        stopAllMusic()
        room_goto(r1_Ba1)
      }
      else if mapCurPos=5
      {
        stopAllMusic()
        room_goto(r2_1a1)
      }
      else if mapCurPos=6
      {
        stopAllMusic()
        if global.storyProgress=2 {room_goto(rCutscene_3)}
        else {room_goto(r2_2a1)}
      }
      else if mapCurPos=7
      {
        stopAllMusic()
        room_goto(r2_Ba1)
      }
      else if mapCurPos=8
      {
        stopAllMusic()
        room_goto(r3_1a1)
      }
      else if mapCurPos=9
      {
        stopAllMusic()
        if global.storyProgress=3 {room_goto(rCutscene_4)}
        else {room_goto(r3_2a1)}
      }
      else if mapCurPos=10
      {
        stopAllMusic()
        if global.storyProgress=4 {room_goto(rCutscene_5)}
        else {room_goto(r3_3a1)}
      }
      else if mapCurPos=11
      {
        stopAllMusic()
        room_goto(r3_Ba1)
      }
      else if mapCurPos=12
      {
        stopAllMusic()
        room_goto(r4_1a1)
      }
      else if mapCurPos=13
      {
        stopAllMusic()
        if global.storyProgress=5 {room_goto(rCutscene_6)}
        else {room_goto(r4_2a1)}
      }
      else if mapCurPos=14
      {
        stopAllMusic()
        room_goto(r4_Ba1)
      }
      else if mapCurPos=15
      {
        stopAllMusic()
        room_goto(r5_1a1)
      }
      else if mapCurPos=16
      {
        stopAllMusic()
        room_goto(rFinal_a1)
      }
    }

    //if keyboard_check_pressed(curMenu)
    if keyboard_check_pressed(curMenu) or scrPadPressed(15) or scrPadPressed(12) //gamepad change: and the gamepad (scrGamepadInit) (B or START)
    {
      io_clear()
      scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
      playSound(global.snd_MenuOpen,0,1)
      menuActive=true
    }
  }
  else //Menu
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
      if mainCurPos=1 //RETURN TO GAME
      {
        io_clear()
        scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
        playSound(global.snd_MenuClose,0,1)
        menuActive=false
      }
      else if mainCurPos=2 //SAVE
      {
        saveData()
      }
      else if mainCurPos=3 //HOW TO PLAY
      {
        playSound(global.snd_MenuOpen,0,1)
        instance_create(0,0,oHowToPlay)
      }
      else if mainCurPos=4 //BONUS CHALLENGES
      {
        if mapMax>=5
        {
          io_clear()
          scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
          playSound(global.snd_MenuOpen,0,1)
          instance_create(0,0,oBonusMenu)
        }
      }
      else if mainCurPos=5 //RETURN TO TITLE
      {
        playSound(global.snd_MenuCancel,0,1)
        room_goto(rTitle)
      }
    }

    //if keyboard_check_pressed(curMenu)
    if keyboard_check_pressed(curMenu) or scrPadPressed(15) or scrPadPressed(12) //gamepad change: and the gamepad (scrGamepadInit) (B or START)
    {
      io_clear()
      scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
      mainCurPos=1
      mainCurY=39
      playSound(global.snd_MenuClose,0,1)
      menuActive=false
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_PauseText)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(1)

findTargetScores()
if mapCurPos=0
{
  mapCurX=52
  mapCurY=88
  lvlName="0-1: Tutorial"
  global.lvlCurrent="0-1"
  global.lvlTargetTime=0
  global.lvlTargetScore=0
}
else if mapCurPos=1
{
  mapCurX=100
  mapCurY=56
  lvlName="1-1: Through the Ropes"
  global.lvlCurrent="1-1"
  mapIndex=0
}
else if mapCurPos=2
{
  mapCurX=116
  mapCurY=80
  lvlName="1-2: Half a Mind"
  global.lvlCurrent="1-2"
  mapIndex=1
}
else if mapCurPos=3
{
  mapCurX=132
  mapCurY=112
  lvlName="1-3: Self Indulgence"
  global.lvlCurrent="1-3"
  mapIndex=2
}
else if mapCurPos=4
{
  mapCurX=124
  mapCurY=144
  lvlName="1-B: Garbage Tracker"
  global.lvlCurrent="1-B"
  mapIndex=3
}
else if mapCurPos=5
{
  mapCurX=164
  mapCurY=192
  lvlName="2-1: Hokey Pokey"
  global.lvlCurrent="2-1"
  mapIndex=4
}
else if mapCurPos=6
{
  mapCurX=188
  mapCurY=208
  lvlName="2-2: Never Lost"
  global.lvlCurrent="2-2"
  mapIndex=5
}
else if mapCurPos=7
{
  mapCurX=188
  mapCurY=240
  lvlName="2-B: Quadradic Wall Shifting Golem"
  global.lvlCurrent="2-B"
  mapIndex=6
}
else if mapCurPos=8
{
  mapCurX=244
  mapCurY=288
  lvlName="3-1: Sand Trap"
  global.lvlCurrent="3-1"
  mapIndex=7
}
else if mapCurPos=9
{
  mapCurX=276
  mapCurY=288
  lvlName="3-2: Glass Factory"
  global.lvlCurrent="3-2"
  mapIndex=8
}
else if mapCurPos=10
{
  mapCurX=276
  mapCurY=256
  lvlName="3-3: Dry Conveyors"
  global.lvlCurrent="3-3"
  mapIndex=9
}
else if mapCurPos=11
{
  mapCurX=284
  mapCurY=224
  lvlName="3-B: Twin Bloom"
  global.lvlCurrent="3-B"
  mapIndex=10
}
else if mapCurPos=12
{
  mapCurX=396
  mapCurY=176
  lvlName="4-1: Tetrious"
  global.lvlCurrent="4-1"
  mapIndex=11
}
else if mapCurPos=13
{
  mapCurX=396
  mapCurY=152
  lvlName="4-2: Spinning Wheels"
  global.lvlCurrent="4-2"
  mapIndex=12
}
else if mapCurPos=14
{
  mapCurX=380
  mapCurY=120
  lvlName="4-B: Harpuia"
  global.lvlCurrent="4-B"
  mapIndex=13
}
else if mapCurPos=15
{
  mapCurX=276
  mapCurY=112
  lvlName="5-1: Take Flight"
  global.lvlCurrent="5-1"
  mapIndex=14
}
else if mapCurPos=16
{
  mapCurX=236
  mapCurY=40
  lvlName="Final Level: The Bug"
  global.lvlCurrent="Final"
  mapIndex=15
}

//map dot position
draw_sprite(sWorld1Icon,global.lvlComplete[0],100,56)
draw_sprite(sWorld1Icon,global.lvlComplete[1],116,80)
draw_sprite(sWorld1Icon,global.lvlComplete[2],132,112)
draw_sprite(sWorld1Icon,global.lvlComplete[3],124,144)
draw_sprite(sWorld1Icon,global.lvlComplete[4],164,192)
draw_sprite(sWorld1Icon,global.lvlComplete[5],188,208)
draw_sprite(sWorld1Icon,global.lvlComplete[6],188,240)
draw_sprite(sWorld1Icon,global.lvlComplete[7],244,288)
draw_sprite(sWorld1Icon,global.lvlComplete[8],276,288)
draw_sprite(sWorld1Icon,global.lvlComplete[9],276,256)
draw_sprite(sWorld1Icon,global.lvlComplete[10],284,224)
draw_sprite(sWorld1Icon,global.lvlComplete[11],396,176)
draw_sprite(sWorld1Icon,global.lvlComplete[12],396,152)
draw_sprite(sWorld1Icon,global.lvlComplete[13],380,120)
draw_sprite(sWorld1Icon,global.lvlComplete[14],276,112)
draw_sprite(sWorld1Icon,0,236,40)

if menuActive=true
{
  draw_set_color(c_black)
  draw_set_alpha(0.9)
  draw_rectangle(0,0,room_width,room_height,0)
}
draw_set_color(c_white)

//player position
draw_sprite_ext(sPlayerWalk,image_index,mapCurX,mapCurY,0.5,0.5,0,c_white,1)
//circling stars around player position
//starSpin+=2
starSpin+=2*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
for(i=0;i<3;i+=1)
{
  cStar[i].x=mapCurX+lengthdir_x(20,(i*120)+starSpin)
  cStar[i].y=(mapCurY-13)+lengthdir_y(20,(i*120)+starSpin)
}

//level details
draw_sprite(sLevelDetails,0,detailsX,detailsY)
draw_text(detailsX+6,detailsY+3,lvlName)
draw_set_halign(fa_right)
if mapCurPos>0 and mapCurPos<16
{
  global.lvlTargetTime=targetTime[mapIndex]
  global.lvlTargetScore=targetScore[mapIndex]
  //----- time -----
  if mapCurPos=15
  {
    draw_text(detailsX+175,detailsY+29,"---- / ----")
    draw_set_color(make_color_rgb(96,64,0))
    draw_rectangle(detailsX+7,detailsY+48,detailsX+29,detailsY+64,0)
    draw_set_color(c_white)
  }
  else
    draw_text(detailsX+175,detailsY+29,string(global.lvlTime[mapIndex]) +string(" / ") +string(global.lvlTargetTime))

  //----- score -----
  if mapCurPos=4 or mapCurPos=7 or mapCurPos=11 or mapCurPos=14
  {
    draw_text(detailsX+175,detailsY+53,"---- / ----")
    draw_set_color(make_color_rgb(96,64,0))
    draw_rectangle(detailsX+7,detailsY+48,detailsX+29,detailsY+64,0)
    draw_set_color(c_white)
  }
  else
    draw_text(detailsX+175,detailsY+53,string(global.lvlScore[mapIndex]) +string(" / ") +string(global.lvlTargetScore))

  if global.lvlCrystal[mapIndex]=1
    draw_sprite(sLevelCrystal,0,detailsX+18,detailsY+53)
}
else
{
  draw_text(detailsX+175,detailsY+29,"---- / ----")
  draw_text(detailsX+175,detailsY+53,"---- / ----")
  draw_set_color(make_color_rgb(96,64,0))
  draw_rectangle(detailsX+7,detailsY+48,detailsX+29,detailsY+64,0)
  draw_set_color(c_white)
}

//---------- Map Menu ----------
if menuActive=true
{
  draw_sprite(sMapMenu,0,mapMenuX,mapMenuY)
  if mapMax<5
    draw_sprite(sMapGrayOutEC,0,mapMenuX,mapMenuY+86)
  draw_sprite(sMapCursor,0,mapMenuX,mapMenuY+mainCurY)
  draw_sprite(sScoreMenu,0,scoreMenuX,scoreMenuY)

  draw_set_halign(fa_right)
  draw_text(mapMenuX+67,mapMenuY+4,string(global.gamePercent) +string("%"))
  //score icons
  menuScoreDisplay(1)
  //----- records -----
  recordsMenuX=376
  recordsMenuY=108
  draw_sprite(sRecordsMenu,0,recordsMenuX,recordsMenuY)
  var totalTime,totalScore;
  totalTime=0
  totalScore=0
  for(i=0;i<global.maxLevels;i+=1)
  {
    totalTime+=global.lvlTime[i]
    totalScore+=global.lvlScore[i]
  }
  draw_text(recordsMenuX+79,recordsMenuY+17,global.p1KillCount)
  draw_text(recordsMenuX+79,recordsMenuY+30,global.deathCount)
  draw_text(recordsMenuX+79,recordsMenuY+43,totalTime)
  draw_text(recordsMenuX+79,recordsMenuY+56,totalScore)
  draw_text(recordsMenuX+79,recordsMenuY+69,global.lvlScore[15])
  if global.challScore[0]>0 {draw_text(recordsMenuX+79,recordsMenuY+82,global.challScore[0])}
  else {draw_text(recordsMenuX+79,recordsMenuY+82,"-----")}

  if global.challScore[1]>0 {draw_text(recordsMenuX+79,recordsMenuY+95,global.challScore[1])}
  else {draw_text(recordsMenuX+79,recordsMenuY+95,"-----")}

  if global.challScore[2]>0 {draw_text(recordsMenuX+79,recordsMenuY+108,global.challScore[2])}
  else {draw_text(recordsMenuX+79,recordsMenuY+108,"-----")}

  if global.challScore[3]>0 {draw_text(recordsMenuX+79,recordsMenuY+121,global.challScore[3])}
  else {draw_text(recordsMenuX+79,recordsMenuY+121,"-----")}
}
