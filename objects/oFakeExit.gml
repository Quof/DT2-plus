#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
init=0
used=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and used=0 and global.gamePaused=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and used=0 and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
{
  if global.gameProgress<23
    msgCreate("It doesn't work!",0,oMessagePerson,global.mainCharacters[3],0,384,96)
  else
    msgCreate("I know this trick already.",0,oMessagePerson,global.mainCharacters[3],0,352,96)
  newMessage.fadingTime=60
  used=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,-1,x,y)
if init=0
{
  starFrame=0
  starTime=0
  for (i=0;i<=3;i+=1)
    starY[i]=(y-12)+(i*12)
  init=1
}
//starTime+=1
starTime+=1*gDeltaTime //60fps change: counts 30fps ticks (Draw runs every frame)
if starTime=5
  starFrame=1
else if starTime=10
  starFrame=2
else if starTime=15
  starFrame=3
else if starTime=20
{
  starFrame=0
  starTime=0
}
for (i=0;i<=3;i+=1)
{
  draw_sprite(sKirbyDoorStarSmall,starFrame,x+20,starY[i])
  draw_sprite(sKirbyDoorStarSmall,starFrame,x-4,starY[i])
  //starY[i]+=2
  starY[i]+=2*gDeltaTime //60fps change: per 30fps tick
  if starY[i]>=y+34
    starY[i]=y-12
}
draw_sprite(sKirbyDoorStarBig,starFrame,x+8,y-12)
