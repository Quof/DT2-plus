#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mainCurPos=1
mainInc=13
mapMenuX=(room_width/2)+10
mapMenuY=205
mainMax=4
obscureCol=make_color_rgb(96,64,0)

//---------- input commands ----------
curUp=ord("W")
curDown=ord("S")
curConfirm=ord("J")
curCancel=ord("K")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up)
if keyboard_check_pressed(curUp) or keyboard_check_pressed(vk_up) or scrPadPressed(3) //gamepad change: and the gamepad (scrGamepadInit)
{
  playSound(global.snd_MenuCursor,0,1)
  if mainCurPos=1
  {
    mainCurPos=mainMax
  }
  else
  {
    mainCurPos-=1
  }
}
//else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down)
else if keyboard_check_pressed(curDown) or keyboard_check_pressed(vk_down) or scrPadPressed(4) //gamepad change: and the gamepad (scrGamepadInit)
{
  playSound(global.snd_MenuCursor,0,1)
  if mainCurPos=mainMax
  {
    mainCurPos=1
  }
  else
  {
    mainCurPos+=1
  }
}

//if keyboard_check_pressed(curConfirm)
if keyboard_check_pressed(curConfirm) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
{
  if mainCurPos=1
  {
    stopAllMusic()
    global.lvlCurrent="Bonus"
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    room_goto(rBonusC1)
  }
  else if mainCurPos=2 and oWorldMap.mapMax>=8
  {
    stopAllMusic()
    global.lvlCurrent="Bonus"
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    room_goto(rBonusC2)
  }
  else if mainCurPos=3 and oWorldMap.mapMax>=12
  {
    stopAllMusic()
    global.lvlCurrent="Bonus"
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    room_goto(rBonusC3)
  }
  else if mainCurPos=4 and oWorldMap.mapMax>=15
  {
    stopAllMusic()
    global.lvlCurrent="Bonus"
    io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
    scrGamepadSync()
    room_goto(rBonusC4)
  }
}

//if keyboard_check_pressed(curCancel)
if keyboard_check_pressed(curCancel) or scrPadPressed(15) //gamepad change: and the gamepad (scrGamepadInit)
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  playSound(global.snd_MenuClose,0,1)
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sBonusMenu,0,mapMenuX,mapMenuY)
draw_sprite_ext(sOptionFilled,0,mapMenuX-55,mapMenuY+7+(mainCurPos*mainInc),1.5,1.4,0,c_white,1)

draw_set_font(fnt_PauseText)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(1)
if mainCurPos=1
{
  draw_text_ext(mapMenuX-57,mapMenuY+71,"Stay in the air as long as possible.#Don't panic.",13,114)
  draw_set_halign(fa_center)
  draw_text(mapMenuX-32,mapMenuY+146,"270")
  draw_text(mapMenuX-2,mapMenuY+146,"540")
  draw_text(mapMenuX+28,mapMenuY+146,"1080")
  if global.challScore[0]>=270 {draw_sprite(sChallengeMedals,0,mapMenuX-32,mapMenuY+153)}
  if global.challScore[0]>=540 {draw_sprite(sChallengeMedals,1,mapMenuX-2,mapMenuY+153)}
  if global.challScore[0]>=1080 {draw_sprite(sChallengeMedals,2,mapMenuX+28,mapMenuY+153)}
}
else if mainCurPos=2
{
  if oWorldMap.mapMax>=8
  {
    draw_text_ext(mapMenuX-57,mapMenuY+71,"Keep away from the bad thing chasing you as long as possible.#Don't stop.",13,114)
    draw_set_halign(fa_center)
    draw_text(mapMenuX-32,mapMenuY+146,"300")
    draw_text(mapMenuX-2,mapMenuY+146,"600")
    draw_text(mapMenuX+28,mapMenuY+146,"1200")
    if global.challScore[1]>=300 {draw_sprite(sChallengeMedals,0,mapMenuX-32,mapMenuY+153)}
    if global.challScore[1]>=600 {draw_sprite(sChallengeMedals,1,mapMenuX-2,mapMenuY+153)}
    if global.challScore[1]>=1200 {draw_sprite(sChallengeMedals,2,mapMenuX+28,mapMenuY+153)}
  }
}
else if mainCurPos=3
{
  if oWorldMap.mapMax>=12
  {
    draw_text_ext(mapMenuX-57,mapMenuY+71,"Wall jump along the moving blocks as long as you can.#Don't bump your head.",13,114)
    draw_set_halign(fa_center)
    draw_text(mapMenuX-32,mapMenuY+146,"390")
    draw_text(mapMenuX-2,mapMenuY+146,"780")
    draw_text(mapMenuX+28,mapMenuY+146,"1560")
    if global.challScore[2]>=390 {draw_sprite(sChallengeMedals,0,mapMenuX-32,mapMenuY+153)}
    if global.challScore[2]>=780 {draw_sprite(sChallengeMedals,1,mapMenuX-2,mapMenuY+153)}
    if global.challScore[2]>=1560 {draw_sprite(sChallengeMedals,2,mapMenuX+28,mapMenuY+153)}
  }
}
else if mainCurPos=4
{
  if oWorldMap.mapMax>=15
  {
    draw_text_ext(mapMenuX-57,mapMenuY+71,"Fight as long as you can without taking damage.#Don't uh... get hit.",13,114)
    draw_set_halign(fa_center)
    draw_text(mapMenuX-32,mapMenuY+146,"450")
    draw_text(mapMenuX-2,mapMenuY+146,"900")
    draw_text(mapMenuX+28,mapMenuY+146,"1200")
    if global.challScore[3]>=450 {draw_sprite(sChallengeMedals,0,mapMenuX-32,mapMenuY+153)}
    if global.challScore[3]>=900 {draw_sprite(sChallengeMedals,1,mapMenuX-2,mapMenuY+153)}
    if global.challScore[3]>=1200 {draw_sprite(sChallengeMedals,2,mapMenuX+28,mapMenuY+153)}
  }
}

draw_set_color(obscureCol)
if oWorldMap.mapMax<8
{
  draw_rectangle(mapMenuX-44,mapMenuY+32,mapMenuX+20,mapMenuY+41,0)
}
if oWorldMap.mapMax<12
{
  draw_rectangle(mapMenuX-44,mapMenuY+44,mapMenuX+20,mapMenuY+56,0)
}
if oWorldMap.mapMax<15
{
  draw_rectangle(mapMenuX-44,mapMenuY+57,mapMenuX+20,mapMenuY+67,0)
}
