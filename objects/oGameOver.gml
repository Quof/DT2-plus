#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.deathCount+=1
global.gameOver=true
global.gamePaused=true
if global.deathCount=1
  ranMessage=0
else
{
  var goMessage;
  goMessage=7
  ranMessage=irandom_range(0,goMessage)
}
if ranMessage=0 gameOverMessage="Keep going, you're doing great!"
else if ranMessage=1 gameOverMessage="You can do it, I know you can!"
else if ranMessage=2 gameOverMessage="My big brother wouldn't say this, but you have a lot of potential!"
else if ranMessage=3 gameOverMessage="Don't worry, practice makes perfect!"
else if ranMessage=4 gameOverMessage="You were so close! Come on, one more try!"
else if ranMessage=5 gameOverMessage="You'll get it next time!"
else if ranMessage=6 gameOverMessage="I have faith in you!"
else if ranMessage=7 gameOverMessage="Failures are simply stepping stones to success!"

stopLoopingSounds()
stopAllMusic()
playSound(global.snd_GameOver,0,1)
effect_clear()
image_speed=0.2
for (i=0;i<7;i+=1)
  background_foreground[i]=false
background_visible[7]=true
background_foreground[7]=true
oPlayer1.xVel=0
oPlayer1.yVel=0
oPlayer1.xAcc=0
oPlayer1.yAcc=0
view_angle[0]=0
backAlpha=0
backColor=c_white
showOptions=0
useCommands=false
GOCursorPos=1
GOCursorX=165
GOCursorY=177
GOCursorInc=24
GOMenuMax=4

staticEffect=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if staticEffect>=2 //fade to black
{
  //staticEffect+=1
  staticEffect+=1*gDeltaTime //60fps change: counts 30fps ticks (from 2, so it lands on 3 and 10)
  if staticEffect=3
  {
    background_alpha[7]=0
    backAlpha=1
  }
  else if staticEffect=10
  {
    backColor=make_color_rgb(70,0,110)
    if showOptions=0
    {
      showOptions=1
      alpha1=0.1
    }
  }
}
else //static effect
{
  //staticEffect+=0.04
  staticEffect+=0.04*gDeltaTime //60fps change: per 30fps tick
  if staticEffect>=1.4
    staticEffect=2
  background_alpha[7]=staticEffect
}

if showOptions>0 and useCommands=false //start options
{
  //showOptions+=1
  showOptions+=1*gDeltaTime //60fps change: counts 30fps ticks
  if showOptions=2
    playSound(global.snd_Continue,0,1)
  if showOptions=5
    useCommands=true
}

if useCommands=true
{
  //if keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) //down
  if keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //down //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if GOCursorPos=GOMenuMax
    {
      GOCursorPos=1
      GOCursorY-=GOCursorInc*(GOMenuMax-1)
    }
    else
    {
      GOCursorPos+=1
      GOCursorY+=GOCursorInc
    }
  }
  //if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) //up
  if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //up //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if GOCursorPos=1
    {
      GOCursorPos=GOMenuMax
      GOCursorY+=GOCursorInc*(GOMenuMax-1)
    }
    else
    {
      GOCursorPos-=1
      GOCursorY-=GOCursorInc
    }
  }
  //if keyboard_check_pressed(ord("J")) //confirm
  if keyboard_check_pressed(ord("J")) or scrPadPressed(14) //confirm //gamepad change: and the gamepad (scrGamepadInit)
  {
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    if GOCursorPos=1 //retry boss / retry from checkpoint
    {
      playSound(global.snd_MenuConfirm,0,1)
      retryCheckpoint()

      global.hasWindBoots=1; global.hasAwesomeShoes=1; global.hasSuaveToken=1; global.hasWallGrinder=1
      global.canUseFire=1; global.canUseWater=1; global.canUseWind=1; global.canUseEarth=1

      global.gamePaused=false
      //if global.currentBoss!=""
      //{
      //  global.levelTimeSecond=0
      //  global.levelTimeFrameCount=0
      //}
      global.gameOver=false
      room_restart()
    }
    else if GOCursorPos=2 //retry level
    {
      if global.gameProgress<31
      {
        playSound(global.snd_MenuConfirm,0,1)
        retryLevel()
        global.gamePaused=false
        global.gameOver=false

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
        else if global.lvlCurrent="Final"
          room_goto(rFinal_a1)
      }
      else
        playSound(global.snd_MenuCancel,0,1)
    }
    else if GOCursorPos=3 //go to map
    {
      if global.gameProgress<31
      {
        playSound(global.snd_MenuCancel,0,1)
        global.gameOver=false
        room_goto(rWorldMap)
      }
      else
        playSound(global.snd_MenuCancel,0,1)
    }
    else if GOCursorPos=4 //title screen
    {
      playSound(global.snd_MenuCancel,0,1)
      room_goto(rTitle)
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(backAlpha)
if room!=rFinal_EscapeA
  draw_set_color(backColor)
else
  draw_set_color(c_black)
draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)

if showOptions>0
{
  draw_set_alpha(1)
  if room!=rFinal_EscapeA
  {
    draw_set_color(make_color_rgb(0,255,252))
    draw_line(view_xview[0],view_yview[0]+40,view_xview[0]+512,view_yview[0]+40)
    draw_line(view_xview[0],view_yview[0]+132,view_xview[0]+512,view_yview[0]+132)
    draw_sprite(sGameOverHeart,0,view_xview[0]+134,view_yview[0]+85)
    draw_sprite_ext(sGameOverHeart,0,view_xview[0]+376,view_yview[0]+85,-1,1,0,c_white,1)
  }

  draw_set_halign(fa_center)
  draw_set_valign(fa_middle)
  if room!=rFinal_EscapeA
    draw_set_color(make_color_rgb(243,0,255))
  else
    draw_set_color(c_red)
  draw_set_font(fnt_GameOver)
  draw_text(view_xview[0]+256,view_yview[0]+85,"GAME  OVER")
  draw_set_valign(fa_top)
  draw_set_font(fnt_Continue)
  draw_set_halign(fa_left)

  if global.currentBoss!=""
    draw_text(view_xview[0]+210,view_yview[0]+166,"Retry Boss")
  else
    draw_text(view_xview[0]+210,view_yview[0]+166,"Retry From Last Checkpoint")
  draw_text(view_xview[0]+210,view_yview[0]+190,"Restart Level")
  draw_text(view_xview[0]+210,view_yview[0]+214,"Return to World Map")
  draw_text(view_xview[0]+210,view_yview[0]+238,"Return to Title Screen")

  //Show encouragement message
  if room!=rFinal_EscapeA
  {
    draw_sprite(sGameOverGirl,0,view_xview[0]+56,view_yview[0]+384)
    draw_set_font(fnt_MenuInfo)
    draw_text_ext(view_xview[0]+108,view_yview[0]+322,gameOverMessage,12,284)
  }
  else
  {
    draw_set_font(fnt_MenuInfo)
    draw_text_ext(view_xview[0]+108,view_yview[0]+322,"Your loss was inevitable.#Corrupting world stability functions...",12,284)
  }
}

if useCommands=true
  draw_sprite(sGameOverCursor,-1,view_xview[0]+GOCursorX,view_yview[0]+GOCursorY)
