#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.deathCount+=1
global.gameOver=true
global.gamePaused=true
stopLoopingSounds()
//stopAllMusic()
playSound(global.snd_GameOver,0,0.9)
GOCursorPos=1
GOCursorX=256
GOCursorY=154
GOCursorInc=14
GOMenuMax=3
useCommands=false
screenAlpha=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
    if GOCursorPos=1 //keep going
    {
      //remove 1 multiple
      if oClaireShip.multiple>0
      {
        oClaireShip.multiple-=1
        with oClaireShip.mult[oClaireShip.multiple]
          instance_destroy()
      }

      playSound(global.snd_MenuConfirm,0,1)
      retryCheckpoint()
      global.currentScore=0
      global.gamePaused=false
      global.gameOver=false
      oClaireShip.life=oClaireShip.maxLife
      instance_destroy()
    }
    else if GOCursorPos=2 //retry level
    {
      playSound(global.snd_MenuConfirm,0,1)
      retryLevel()
      global.gamePaused=false
      global.gameOver=false
      room_restart()
    }
    else if GOCursorPos=3 //go to map
    {
      playSound(global.snd_MenuCancel,0,1)
      global.gameOver=false
      room_goto(rWorldMap)
    }
  }
}
else
{
  //screenAlpha+=0.03
  screenAlpha+=0.03*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  if screenAlpha>=0.5
    useCommands=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(screenAlpha)
draw_set_color(c_orange)
draw_rectangle(0,0,512,384,0)

if useCommands=true
{
  draw_sprite(sShipGameOver,0,room_width/2,133)
  draw_sprite(sShipGOCursor,0,GOCursorX,GOCursorY)
}
