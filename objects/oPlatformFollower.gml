#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//makeActive()
//setCollisionBounds(-15,-15,15,15)

//Enemy base statistics
atkPower=4
bCanTakeDamage=false
bShowHealthBar=false
detectDistY=288
runAcc=2 //should always be a power of 2
UP=0
DOWN=1
LEFT=2
RIGHT=3
bClockWise=false
currentDir=LEFT
//60fps change (added): above 30fps the step along the wall is worked out once per 30fps tick of this follower (from its
//whole-pixel position, by the original code) and then moved in shares over the tick's frames (see the Step)
followTick=0
followDX=0
followDY=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newSpd")
  runAcc=newSpd
if variable_local_exists("newDir")
  currentDir=newDir
if variable_local_exists("bClock")
  bClockWise=true
if variable_local_exists("startAct")
  bActive=true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true
  {
    //60fps change (added): the code below runs at the start of each of this follower's 30fps ticks, from the position the
    //last tick ended on (whole pixels, as at 30fps), and its move is then made in shares over the tick's frames, so the
    //follower is always on the 30fps path (its corner checks look runAcc pixels ahead, which a fraction of a tick's move
    //wouldn't line up with). The same at 30fps
    if followTick<=0
    {
    followTick+=1
    var tFollowX,tFollowY;
    tFollowX=x; tFollowY=y
    if bClockWise=false //******************** COUNTER-CLOCK-WISE ********************
    {
      if currentDir=UP
      {
        if !place_meeting(x,y-runAcc,oSolid) //check up first
        {
          if place_meeting(x-runAcc,y,oSolid) //check left
            y-=runAcc //continue up
          else
          {
            currentDir=LEFT
            x-=runAcc //move left once
          }
        }
        else
        {
          currentDir=RIGHT
          x+=runAcc
        }
      }
      else if currentDir=DOWN
      {
        if !place_meeting(x,y+runAcc,oSolid) //check down first
        {
          if place_meeting(x+runAcc,y,oSolid) //check right
            y+=runAcc //continue down
          else
          {
            currentDir=RIGHT
            x+=runAcc //move right once
          }
        }
        else
        {
          currentDir=LEFT
          x-=runAcc
        }
      }
      else if currentDir=LEFT
      {
        if !place_meeting(x-runAcc,y,oSolid) //check left first
        {
          if place_meeting(x,y+runAcc,oSolid) //check down
            x-=runAcc //continue left
          else
          {
            currentDir=DOWN
            y+=runAcc //move down once
          }
        }
        else
        {
          currentDir=UP
          y-=runAcc
        }
      }
      else if currentDir=RIGHT
      {
        if !place_meeting(x+runAcc,y,oSolid) //check right first
        {
          if place_meeting(x,y-runAcc,oSolid) //check up
            x+=runAcc //continue right
          else
          {
            currentDir=UP
            y-=runAcc //move up once
          }
        }
        else
        {
          currentDir=DOWN
          y+=runAcc
        }
      }
    }
    else //******************** CLOCK-WISE ********************
    {
      if currentDir=UP
      {
        if !place_meeting(x,y-runAcc,oSolid) //check up first
        {
          if place_meeting(x+runAcc,y,oSolid) //check right
            y-=runAcc //continue up
          else
          {
            currentDir=RIGHT
            x+=runAcc //move right once
          }
        }
        else
        {
          currentDir=LEFT
          x-=runAcc
        }
      }
      else if currentDir=DOWN
      {
        if !place_meeting(x,y+runAcc,oSolid) //check down first
        {
          if place_meeting(x-runAcc,y,oSolid) //check left
            y+=runAcc //continue down
          else
          {
            currentDir=LEFT
            x-=runAcc //move left once
          }
        }
        else
        {
          currentDir=RIGHT
          x+=runAcc
        }
      }
      else if currentDir=LEFT
      {
        if !place_meeting(x-runAcc,y,oSolid) //check left first
        {
          if place_meeting(x,y-runAcc,oSolid) //check up
            x-=runAcc //continue left
          else
          {
            currentDir=UP
            y-=runAcc //move up once
          }
        }
        else
        {
          currentDir=DOWN
          y+=runAcc
        }
      }
      else if currentDir=RIGHT
      {
        if !place_meeting(x+runAcc,y,oSolid) //check right first
        {
          if place_meeting(x,y+runAcc,oSolid) //check down
            x+=runAcc //continue right
          else
          {
            currentDir=DOWN
            y+=runAcc //move down once
          }
        }
        else
        {
          currentDir=UP
          y-=runAcc
        }
      }
    }
    //60fps change (added): the tick's move, made over its frames (all of it at 30fps)
    followDX=x-tFollowX
    followDY=y-tFollowY
    x=tFollowX
    y=tFollowY
    }
    x+=followDX*gDeltaTime
    y+=followDY*gDeltaTime
    followTick-=gDeltaTime
  }
}
