#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
arrowX=x+8
arrowY=y-24
pointTime=0
init=0
arrowColor=0
if variable_local_exists("newArrowPosX")
  arrowX+=newArrowPosX
if variable_local_exists("newArrowPosY")
  arrowY+=newArrowPosY
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Exit script.
This will move the player to another room.
exitType is set in the creation code.
exitType relates to whether the player has to press up to activate the event.
0 = Player must press up. Use for doors.
1 = Player just needs to walk into the exit.
*/
if exitType=0
{
  //if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
  if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
  {
    global.newMapX=0
    global.newMapY=0
    if newMapX!=0 and newMapY!=0 and newMapX<1000000 and newMapY<1000000
    {
      global.newMapX=newMapX
      global.newMapY=newMapY
    }
    writeToPlayerGlobals()
    global.recordScore=global.currentScore
    global.recordTime=global.levelTimeFrameCount

    transition_steps=10
    transition_kind=5
    if variable_local_exists("newStep")
      transition_steps=newStep
    if variable_local_exists("newTrans")
      transition_kind=newTrans
    //room_goto(toRoom)
    room_goto_fixed(toRoom) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
  }
}
else if exitType=1
{
  global.newMapX=0
  global.newMapY=0
  if newMapX!=0 and newMapY!=0 and newMapX<1000000 and newMapY<1000000
  {
    global.newMapX=newMapX
    global.newMapY=newMapY
  }
  else if newMapX>1000000 and newMapY>1000000
  {
    newMapX-=1000000
    newMapY-=1000000
    global.worldMapX=newMapX
    global.worldMapY=newMapY
  }
  writeToPlayerGlobals()
  global.recordScore=global.currentScore
  global.recordTime=global.levelTimeFrameCount

  transition_steps=10
  if x<64
    transition_kind=14
  else
    transition_kind=15
  if variable_local_exists("newStep")
    transition_steps=newStep
  if variable_local_exists("newTrans")
    transition_kind=newTrans
  //room_goto(toRoom)
  room_goto_fixed(toRoom) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowArrow=true
{
  //pointTime+=1
  pointTime+=1*gDeltaTime //60fps change: counts 30fps ticks (Draw runs every frame)
  if pointTime=20
    arrowY+=1
  else if pointTime=40
  {
    arrowY-=1
    pointTime=0
  }
  if newMapX>1000000
    arrowColor=1
  else
    arrowColor=0
  draw_sprite(sExitArrow,arrowColor,arrowX,arrowY)
}

if sprite_index=sKirbyDoorway
{
  depth=100
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
}
