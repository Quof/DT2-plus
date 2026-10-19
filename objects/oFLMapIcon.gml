#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveProg=0
moveSpeed=-0.2

mapGridX=256
mapGridY=124
bMapDisplay=false
rmNum=0
maxRmNum=0
if global.gameProgress>=14
  maxRmNum+=1
if global.gameProgress>=18
  maxRmNum+=1
if global.gameProgress>=21
  maxRmNum+=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//move icon
//60fps change: the bobbing is per 30fps tick (it bobbed 2x/4x as fast at 60/120fps)
if moveProg=0
{
  //moveSpeed+=0.01
  moveSpeed+=0.01*gDeltaTime
  if moveSpeed>=0.2
    moveProg=1
}
else if moveProg=1
{
  //moveSpeed-=0.01
  moveSpeed-=0.01*gDeltaTime
  if moveSpeed<=-0.2
    moveProg=0
}
//y+=moveSpeed
y+=moveSpeed*gDeltaTime

if bMapDisplay=true //map functions
{
  //if keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left)
  if keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left) or scrPadPressed(1) //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if rmNum>0
      rmNum-=1
    else
      rmNum=maxRmNum
  }
  //else if keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right)
  else if keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right) or scrPadPressed(2) //gamepad change: and the gamepad (scrGamepadInit)
  {
    playSound(global.snd_MenuCursor,0,1)
    if rmNum<maxRmNum
      rmNum+=1
    else
      rmNum=0
  }

  //if keyboard_check_pressed(ord("J")) //goto room
  if keyboard_check_pressed(ord("J")) or scrPadPressed(14) //goto room //gamepad change: and the gamepad (scrGamepadInit)
  {
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    global.gamePaused=false
    if rmNum=0
    {
      SS_StopSound(global.msc_LurkingEvil)
      room_goto(rFinal_a2_1)
    }
    else if rmNum=1
    {
      SS_StopSound(global.msc_LurkingEvil)
      room_goto(rFinal_a3_1)
    }
    else if rmNum=2
    {
      SS_StopSound(global.msc_LurkingEvil)
      room_goto(rFinal_a5_1)
    }
    else if rmNum=3
    {
      SS_StopSound(global.msc_LurkingEvil)
      room_goto(rFinal_a6_1)
    }
  }
  //if keyboard_check_pressed(ord("K")) //cancel
  if keyboard_check_pressed(ord("K")) or scrPadPressed(15) //cancel //gamepad change: and the gamepad (scrGamepadInit)
  {
    io_clear()
    scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
    playSound(global.snd_MenuClose,0,1)
    bMapDisplay=false
    global.gamePaused=false
    exit;
  }
}
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//post message
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false and bMapDisplay=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false and bMapDisplay=false //gamepad change: and the gamepad (scrGamepadInit)
{
  playSound(global.snd_MenuOpen,0,1)
  rmNum=0
  bMapDisplay=true
  global.gamePaused=true
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)

if bMapDisplay=true //map display
{
  draw_sprite(sFLGrid,0,mapGridX,mapGridY)
  draw_sprite(sMapArrows,0,mapGridX,mapGridY-76)
  draw_sprite(sMapNumbers,rmNum,mapGridX,mapGridY-76)

  //draw completed paths
  if global.gameProgress>=14
    draw_sprite(sFLPath_1,0,mapGridX+18,mapGridY-7)
  if global.gameProgress>=18
    draw_sprite(sFLPath_2,0,mapGridX-11,mapGridY+15)
  if global.gameProgress>=21
    draw_sprite(sFLPath_3,0,mapGridX-51,mapGridY)
}
