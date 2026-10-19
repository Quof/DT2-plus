/*
This script is called in the HUD pause menu.
It is used to for setting up the controls.
(This could just go in the execute code, but it takes too long to load all that.)
*/
if keyboard_check_pressed(curUp)=true
{
  playSound(global.snd_MenuCursor,0,1)
  if cursorPosY=1
  {
    cursorPosY=menuMax
    menuCursorY+=cursorIncY*(menuMax-1)
  }
  else
  {
    cursorPosY-=1
    menuCursorY-=cursorIncY
  }
}
if keyboard_check_pressed(curDown)=true
{
  playSound(global.snd_MenuCursor,0,1)
  if cursorPosY=menuMax
  {
    cursorPosY=1
    menuCursorY-=cursorIncY*(menuMax-1)
  }
  else
  {
    cursorPosY+=1
    menuCursorY+=cursorIncY
  }
}
if keyboard_check_pressed(curConfirm)=true
{
  playSound(global.snd_MenuConfirm,0,1)
  var keyHelpInfo,keyChange;
  keyHelpInfo="Enter the key you would like to#change this action to and press Enter."
  if cursorPosY=1 //Up
  {
    keyChange=get_string(keyHelpInfo,global.ctrlUp)
    global.ctrlUp=string_upper(keyChange)
  }
  else if cursorPosY=2 //Down
  {
    keyChange=get_string(keyHelpInfo,global.ctrlDown)
    global.ctrlDown=string_upper(keyChange)
  }
  else if cursorPosY=3 //Left
  {
    keyChange=get_string(keyHelpInfo,global.ctrlLeft)
    global.ctrlLeft=string_upper(keyChange)
  }
  else if cursorPosY=4 //Right
  {
    keyChange=get_string(keyHelpInfo,global.ctrlRight)
    global.ctrlRight=string_upper(keyChange)
  }
  else if cursorPosY=5 //Jump
  {
    keyChange=get_string(keyHelpInfo,global.ctrlJump)
    global.ctrlJump=string_upper(keyChange)
  }
  else if cursorPosY=6 //Use Fire
  {
    keyChange=get_string(keyHelpInfo,global.ctrlFire)
    global.ctrlFire=string_upper(keyChange)
  }
  else if cursorPosY=7 //Use Water
  {
    keyChange=get_string(keyHelpInfo,global.ctrlWater)
    global.ctrlWater=string_upper(keyChange)
  }
  else if cursorPosY=8 //Use Wind
  {
    keyChange=get_string(keyHelpInfo,global.ctrlWind)
    global.ctrlWind=string_upper(keyChange)
  }
  else if cursorPosY=9 //Use Earth
  {
    keyChange=get_string(keyHelpInfo,global.ctrlEarth)
    global.ctrlEarth=string_upper(keyChange)
  }
  else if cursorPosY=10 //Set to default controls
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
