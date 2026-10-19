/*
This script is used for NPC Yoshi characters.
It will make the Yoshi npc walk/stand/stomp randomly.
argument0: Stand
argument1: Walk
argument2: Stomp
*/
if bWalking=true
{
  if sprite_index=argument1
  {
    if image_xscale=1
      xVel=runAcc
    else
      xVel=-runAcc
  }
  if walkingTime<=0
  {
    sprite_index=argument0
    xVel=0
    walkingTime=round(random(120)+30)
    bWalking=false
  }
  else
    //walkingTime-=1
    walkingTime-=1*gDeltaTime //60fps change: counts 30fps ticks
}
else
{
  if walkingTime<=0
  {
    if round(random(10))>=6
      image_xscale=1
    else
      image_xscale=-1
    if random(10)<=9
    {
      sprite_index=argument1
      walkingTime=round(random(150)+90)
    }
    else
    {
      sprite_index=argument2
      walkingTime=round(random(90)+60)
    }
    bWalking=true
  }
  else
    //walkingTime-=1
    walkingTime-=1*gDeltaTime //60fps change: counts 30fps ticks
}

if x<0
{
  xVel=0
  x=0
}
else if x>room_width
{
  xVel=0
  x=room_width
}

//yVel+=0.2
yVel=scrGravAcc(yVel,0.2,1) //60fps change: gravity (accelerate, then move) spread over the frames so falls match 30fps (see scrGravAcc)
if isCollisionBottom(1)
  yVel=0
if isCollisionLeft(1)
  xVel=runAcc
if isCollisionRight(1)
  xVel=-runAcc
//moveTo(xVel,yVel)
moveTo(xVel*gDeltaTime,yVel*gDeltaTime) //60fps change: moveTo takes this frame's share of the move
if isCollisionSolid()
  y-=2
