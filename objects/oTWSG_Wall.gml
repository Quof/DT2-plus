#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
bMoving=0
mstLX=x; mstLY=y //60fps change (added): see the Step (gameStepEvent keeps them up to date)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
//60fps change: runs on 30fps ticks (unscaled), like the other moving solids: they only read their speed on 30fps ticks
//and gameStepEvent spreads each tick's move over the frames. mstLX/mstLY are where the wall will be once this tick's
//move has finished (the same as x/y at 30fps), so it stops on the same spot as at 30fps
if global.gamePaused=false and gDeltaDoTicks!=0
{
  if bMoving=1
  {
    //if x>=targetX and xVel>0 //----- Right -----
    if mstLX>=targetX and xVel>0 //----- Right -----
    {
      xVel=0
      bMoving=0
    }
    //if x<=targetX and xVel<0 //----- Left -----
    if mstLX<=targetX and xVel<0 //----- Left -----
    {
      xVel=0
      bMoving=0
    }

    //if y>=targetY and yVel>0 //----- Down -----
    if mstLY>=targetY and yVel>0 //----- Down -----
    {
      yVel=0
      bMoving=0
    }
    //if y<=targetY and yVel<0 //----- Up -----
    if mstLY<=targetY and yVel<0 //----- Up -----
    {
      yVel=0
      bMoving=0
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=0 //Right Wall
{
  draw_background_part(tileSharpCaves,0,48,64,32,x,y)
  draw_background_part(tileSharpCaves,0,48,64,32,x,y+32)
  for(i=0;i<4;i+=1)
  {
    draw_background_part(tileSharpCaves,32,48,32,32,x+64+(i*32),y)
    draw_background_part(tileSharpCaves,32,48,32,32,x+64+(i*32),y+32)
  }
}
else if drawType=1 //Left Wall
{
  for(i=0;i<4;i+=1)
  {
    draw_background_part(tileSharpCaves,32,48,32,32,x+(i*32),y)
    draw_background_part(tileSharpCaves,32,48,32,32,x+(i*32),y+32)
  }
  draw_background_part(tileSharpCaves,32,48,64,32,x+128,y)
  draw_background_part(tileSharpCaves,32,48,64,32,x+128,y+32)
}
else if drawType=2 //Floor A
{
  draw_background_part(tileSharpCaves,0,16,80,64,x,y-16)
  for(i=0;i<4;i+=1)
  {
    draw_background_part(tileSharpCaves,0,48,80,32,x,y+48+(i*32))
  }
}
else if drawType=3 //Floor B
{
  draw_background_part(tileSharpCaves,16,16,80,64,x,y-16)
  for(i=0;i<4;i+=1)
  {
    draw_background_part(tileSharpCaves,16,48,80,32,x,y+48+(i*32))
  }
}
else if drawType=4 //Floor C
{
  draw_background_part(tileSharpCaves,0,16,32,64,x,y-16)
  draw_background_part(tileSharpCaves,64,16,32,64,x+32,y-16)
  for(i=0;i<4;i+=1)
  {
    draw_background_part(tileSharpCaves,0,48,32,64,x,y+48+(i*32))
    draw_background_part(tileSharpCaves,64,48,32,64,x+32,y+48+(i*32))
  }
}
