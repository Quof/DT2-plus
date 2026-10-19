/*
This script should be placed in the step event for the platform character.
It updates the keys used by the character, moves all of the solids, moves the
character, sets the sprite index, and sets the animation speed for the sprite.
*/
//60fps change (added): above 30fps: set to 1 by code that sets xVel/yVel directly this frame (dashes, one-off pushes);
//pMoveToWrapNew then applies the original 30fps formula (velocity+acceleration)*friction instead of spreading
//acceleration/friction over the frame
xVelSetTick=0
yVelSetTick=0

if player=1 //========================================
{
  if attackState!=ACT_CASTED and global.gamePaused=false
  {
    //updates the keys
    //key left
    if walljumpTime=0
    {
      kLeftReleased=0
      if kLeft
      {
        //kLeft=keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left)
        kLeft=keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left) or scrPadHeld(1) //gamepad change: and the gamepad (scrGamepadInit)
        //kLeftPushedSteps+=1
        kLeftPushedSteps+=1*gDeltaTime //60fps change: counts 30fps ticks
        kLeftPressed=0;
        if (kLeft=0)
          kLeftReleased=1;
      }
      else
      {
        //kLeft=keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left)
        kLeft=keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left) or scrPadHeld(1) //gamepad change: and the gamepad (scrGamepadInit)
        if kLeft
          kLeftPressed=1
        kLeftPushedSteps=0
      }
      //key right
      kRightReleased=0
      if kRight
      {
        //kRight=keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right)
        kRight=keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right) or scrPadHeld(2) //gamepad change: and the gamepad (scrGamepadInit)
        //kRightPushedSteps+=1
        kRightPushedSteps+=1*gDeltaTime //60fps change: counts 30fps ticks
        kRightPressed=0
        if kRight=0
          kRightReleased=1
      }
      else
      {
        //kRight=keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right)
        kRight=keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right) or scrPadHeld(2) //gamepad change: and the gamepad (scrGamepadInit)
        if kRight
          kRightPressed=1
        kRightPushedSteps=0
      }
    }
    //key up
    //kUp=keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up)
    kUp=keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up) or scrPadHeld(3) //gamepad change: and the gamepad (scrGamepadInit)
    //key down
    //kDown=keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down)
    kDown=keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down) or scrPadHeld(4) //gamepad change: and the gamepad (scrGamepadInit)
    //key "run"
    //if canRun
    //  kRun=keyboard_check(vk_shift)
    //else
    //  kRun=0
    //key "jump"
    if kJump
    {
      //kJump=keyboard_check(ord(global.ctrlJump))
      kJump=keyboard_check(ord(global.ctrlJump)) or scrPadHeld(5) //gamepad change: and the gamepad (scrGamepadInit)
      kJumpPressed=0
    }
    else
    {
      //kJump=keyboard_check(ord(global.ctrlJump))
      kJump=keyboard_check(ord(global.ctrlJump)) or scrPadHeld(5) //gamepad change: and the gamepad (scrGamepadInit)
      if kJump
        kJumpPressed=1
    }
    //key "fire"
    if kFire
    {
      //kFire=keyboard_check(ord(global.ctrlFire))
      kFire=keyboard_check(ord(global.ctrlFire)) or scrPadHeld(6) //gamepad change: and the gamepad (scrGamepadInit)
      kFirePressed=0
    }
    else
    {
      //kFire=keyboard_check(ord(global.ctrlFire))
      kFire=keyboard_check(ord(global.ctrlFire)) or scrPadHeld(6) //gamepad change: and the gamepad (scrGamepadInit)
      if kFire
        kFirePressed=1
    }
    //key "water"
    if kWater
    {
      //kWater=keyboard_check(ord(global.ctrlWater))
      kWater=keyboard_check(ord(global.ctrlWater)) or scrPadHeld(7) //gamepad change: and the gamepad (scrGamepadInit)
      kWaterPressed=0
    }
    else
    {
      //kWater=keyboard_check(ord(global.ctrlWater))
      kWater=keyboard_check(ord(global.ctrlWater)) or scrPadHeld(7) //gamepad change: and the gamepad (scrGamepadInit)
      if kWater
        kWaterPressed=1
    }
    //key "wind"
    if kWind
    {
      //kWind=keyboard_check(ord(global.ctrlWind))
      kWind=keyboard_check(ord(global.ctrlWind)) or scrPadHeld(8) //gamepad change: and the gamepad (scrGamepadInit)
      kWindPressed=0
    }
    else
    {
      //kWind=keyboard_check(ord(global.ctrlWind))
      kWind=keyboard_check(ord(global.ctrlWind)) or scrPadHeld(8) //gamepad change: and the gamepad (scrGamepadInit)
      if kWind
        kWindPressed=1
    }
    //key "earth"
    if kEarth
    {
      //kEarth=keyboard_check(ord(global.ctrlEarth))
      kEarth=keyboard_check(ord(global.ctrlEarth)) or scrPadHeld(9) //gamepad change: and the gamepad (scrGamepadInit)
      kEarthPressed=0
    }
    else
    {
      //kEarth=keyboard_check(ord(global.ctrlEarth))
      kEarth=keyboard_check(ord(global.ctrlEarth)) or scrPadHeld(9) //gamepad change: and the gamepad (scrGamepadInit)
      if kEarth
        kEarthPressed=1
    }
    //key "Dash Left"
    if kDashLeft
    {
      //kDashLeft=keyboard_check(ord(global.ctrlDashLeft))
      kDashLeft=keyboard_check(ord(global.ctrlDashLeft)) or scrPadHeld(10) //gamepad change: and the gamepad (scrGamepadInit)
      kDashLeftPressed=0
    }
    else
    {
      //kDashLeft=keyboard_check(ord(global.ctrlDashLeft))
      kDashLeft=keyboard_check(ord(global.ctrlDashLeft)) or scrPadHeld(10) //gamepad change: and the gamepad (scrGamepadInit)
      if kDashLeft {kDashLeftPressed=1}
    }
    //key "Dash Right"
    if kDashRight
    {
      //kDashRight=keyboard_check(ord(global.ctrlDashRight))
      kDashRight=keyboard_check(ord(global.ctrlDashRight)) or scrPadHeld(11) //gamepad change: and the gamepad (scrGamepadInit)
      kDashRightPressed=0
    }
    else
    {
      //kDashRight=keyboard_check(ord(global.ctrlDashRight))
      kDashRight=keyboard_check(ord(global.ctrlDashRight)) or scrPadHeld(11) //gamepad change: and the gamepad (scrGamepadInit)
      if kDashRight {kDashRightPressed=1}
    }
  }
}

//deals with the ladderTimer ========================================
if state=CLIMBING
  ladderTimer=10
else
{
  if ladderTimer>0
    //ladderTimer-=1
    ladderTimer-=1*gDeltaTime //60fps change: counts 30fps ticks
}

//---------- wall jump ----------
if global.hasWallGrinder=1 and bTakingDamage=false
{
  if isCollisionRight(3) and platformCharacterIs(IN_AIR) and facing=RIGHT //right wall
  {
    if kLeft and bCanStick //cling to wall
    {
      clingTime=clingMax
      bSticking=1
      bCanStick=0
    }

    bWallGrab=1
    canAirDash=1
    if (((kDown or kUp) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashPoints>0
    {
      if kLeft
      {
        walljumpExtVel=25
      }
      pMoveWallDash(0)
    }
    else
    {
      if kJumpPressed
      {
        if kLeft
        {
          walljumpExtVel=15
          facing=LEFT
        }
        pMoveWallJump(0)
      }
    }
  }
  else if isCollisionLeft(3) and platformCharacterIs(IN_AIR) and facing=LEFT //left wall
  {
    if kRight and bCanStick //cling to wall
    {
      clingTime=clingMax
      bSticking=1
      bCanStick=0
    }

    bWallGrab=1
    canAirDash=1
    if (((kDown or kUp) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed)) and dashPoints>0
    {
      if kRight
      {
        walljumpExtVel=25
      }
      pMoveWallDash(1)
    }
    else
    {
      if kJumpPressed
      {
        if kRight
        {
          walljumpExtVel=15
          facing=RIGHT
        }
        pMoveWallJump(1)
      }
    }
  }
  else
  {
    bWallGrab=0
    bSticking=0
    bCanStick=1
  }
}
else
{
  bWallGrab=0
  bSticking=0
  bCanStick=1
}

//if walljumpExtVel>0 {walljumpExtVel-=1}
if walljumpExtVel>0 {walljumpExtVel-=1*gDeltaTime} //60fps change: counts 30fps ticks

if clingTime>0
{
  //clingTime-=1
  //if clingTime=0 {bSticking=0}
  clingTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if clingTime<=0 {bSticking=0} //60fps change: <= (the same at 30fps; a count left on a fraction by an F2 frame rate change still ends)
}
//if walljumpTime>0 {walljumpTime-=1}
if walljumpTime>0 {walljumpTime-=1*gDeltaTime} //60fps change: counts 30fps ticks

//allows the character to run left and right
//if state!=DUCKING and state!=CLIMBING and bTakingDamage=false
//60fps change: not for the rest of a dash's first 30fps tick (dashTickTime, set by pMoveDashForward/pMoveDashBack/
//pMoveAirDash). At 30fps this code had already run for that tick before the dash took over; running it again on the
//next frames could turn the dash around (e.g. holding forward during a back dash) half/three quarters of a tick early
if state!=DUCKING and state!=CLIMBING and bTakingDamage=false and dashTickTime<=0
{
  //if kLeftReleased and approximatelyZero(xVel) {xAcc-=0.5}
  //if kRightReleased and approximatelyZero(xVel) {xAcc+=0.5}
  if kLeftReleased and approximatelyZero(xVel) {xAcc-=0.5; xVelSetTick=1} //60fps change: one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
  if kRightReleased and approximatelyZero(xVel) {xAcc+=0.5; xVelSetTick=1} //60fps change: see above

  if kLeft and !bSticking //----- Run left -----
  {
    if kLeftPushedSteps<3
    {
      if backDashRec>0
      {
        dashMomentumTime=0; backDashRec=0
      }
    }
    if facing=RIGHT
    {
      //if dashMomentumTime<20 {dashMomentumTime=0}
      if ceil(dashMomentumTime)<20 {dashMomentumTime=0} //60fps change: the counter holds fractions between 30fps ticks; ceil() is its value for this tick (it's counted down after this)
    }
    //if (kLeftPushedSteps>1 or isCollisionMoveableSolidRight(1)) and (facing=LEFT or approximatelyZero(xVel))
    //60fps change: >1 started the run 3/4 of a tick early at 120fps (steps 1.25) but half a tick early at 60fps (1.5), which
    //happens to cancel out pMoveToWrapNew's half-tick lag in speeding up (as found in DT3+, same engine). >=1.5 uses the
    //60fps timing at 120fps too. Same as >1 at 30fps
    if (kLeftPushedSteps>=1.5 or isCollisionMoveableSolidRight(1)) and (facing=LEFT or approximatelyZero(xVel))
    {
      //if walljumpExtVel>0 {xAcc-=runAcc*extVelAmt}
      if walljumpExtVel>=1 {xAcc-=runAcc*extVelAmt} //60fps change: the count was just counted down for this frame (it holds fractions between 30fps ticks); >=1 is >0 at 30fps and lasts exactly as many ticks at 60/120fps
      else {xAcc-=runAcc}

      //if dashMomentumTime>=1
      if dashMomentumTime>0 //60fps change: >=1 dropped the second half of the last momentum tick above 30fps (the same as >=1 at 30fps)
      {
        //if platformCharacterIs(IN_AIR)
        if platformCharacterIs(IN_AIR) or landTickHold>0 //60fps change: see the landing code
        {
          //xAcc-=(xVel/2.1+(dashMomentumTime/1.95))
          //xVel=-(dashVel/4+(dashMomentumTime/4))
          xVel=-(dashVel/4+(ceil(dashMomentumTime)/4)); xVelSetTick=1 //60fps change: ceil() uses the 30fps tick's value of the counter; the velocity is set, so pMoveToWrapNew uses the 30fps formula
        }
        //if kLeftPushedSteps<=1 {dashMomentumTime=0} //3
        if kLeftPushedSteps<1.5 {dashMomentumTime=0} //3 //60fps change: the counterpart of the >=1.5 run start above
      }
    }
    facing=LEFT
  }
  if kRight and !bSticking //----- Run right -----
  {
    if kRightPushedSteps<3
    {
      if backDashRec>0
      {
        dashMomentumTime=0; backDashRec=0
      }
    }
    if facing=LEFT
    {
      //if dashMomentumTime<20 {dashMomentumTime=0}
      if ceil(dashMomentumTime)<20 {dashMomentumTime=0} //60fps change: see run left
    }
    //if (kRightPushedSteps>1 or isCollisionMoveableSolidLeft(1)) and (facing=RIGHT or approximatelyZero(xVel))
    if (kRightPushedSteps>=1.5 or isCollisionMoveableSolidLeft(1)) and (facing=RIGHT or approximatelyZero(xVel)) //60fps change: see run left
    {
      //if walljumpExtVel>0 {xAcc+=runAcc*extVelAmt}
      if walljumpExtVel>=1 {xAcc+=runAcc*extVelAmt} //60fps change: see run left
      else {xAcc+=runAcc}

      //if dashMomentumTime>=1
      if dashMomentumTime>0 //60fps change: see run left
      {
        //if platformCharacterIs(IN_AIR)
        if platformCharacterIs(IN_AIR) or landTickHold>0 //60fps change: see the landing code
        {
          //xAcc+=xVel/2.1+(dashMomentumTime/1.95)
          //xVel=dashVel/4+(dashMomentumTime/4)
          xVel=dashVel/4+(ceil(dashMomentumTime)/4); xVelSetTick=1 //60fps change: see run left
        }
        //if kRightPushedSteps<=1 {dashMomentumTime=0} //3
        if kRightPushedSteps<1.5 {dashMomentumTime=0} //3 //60fps change: see run left
      }
    }
    facing=RIGHT
  }
}

if state=CLIMBING and isCollisionLadder()=0
{
  state=FALLING
}
if state=CLIMBING and bTakingDamage=false
{
  if kLeft
  {
    xAcc-=climbAcc
    facing=LEFT
  }
  if kRight
  {
    xAcc+=climbAcc
    facing=RIGHT
  }
  if kUp
    yAcc-=climbAcc
  if kDown
    yAcc+=climbAcc
}
xAccInputWalk=xAcc //60fps change (added): the walking/climbing input's acceleration (pMoveToWrapNew's stopping friction leaves it alone)
/*if floatTime>0
  floatTime-=1*/
if platformCharacterIs(IN_AIR)
{
  yAcc+=gravityIntensity
  /*if floatTime=0
    yAcc+=gravityIntensity
  else
    yAcc+=gravityIntensity/2*/
}
if (isCollisionBottom(1) or isCollisionPlatformBottom(1) and isCollisionPlatform()=0) and platformCharacterIs(IN_AIR) and yVel>=0
{
  yVel=0
  yAcc=0
  //player has just landed
  hopOnCount=0
  state=RUNNING
  jumps=0
  canAirDash=1
  busterAnimStay=0
  airDashDamage=0
  //60fps change (added): landing with dash momentum keeps the air friction and the momentum formula for the rest of this
  //30fps tick of the dash (dashMomentumTime is a whole number at its tick boundaries). At 30fps a landing only shows up at
  //the start of the next tick, so the tick it touched down in still moved with them; above 30fps it shows up within 1/2
  //or 1/4 tick (as in DT3+)
  if gDeltaTime!=1 and dashMomentumTime>0 {landTickHold=frac(dashMomentumTime)}
}
//if the character has just walked off of the edge of a solid
if isCollisionBottom(1)=0 and (isCollisionPlatformBottom(1)=0 or isCollisionPlatform()) and platformCharacterIs(ON_GROUND)
{
  state=FALLING
  //yAcc+=grav
  yAcc+=grav; yVelSetTick=1 //60fps change: one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
}
if isCollisionTop(1) and state=JUMPING
{
  yVel=abs(yVel*0.3)
}

//player may jump
if bTakingDamage=false
{
  if platformCharacterIs(ON_GROUND)
  {
    if global.optRightIsForward=0 //Left and Right
    {
      if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed and facing=LEFT) or (kDashLeftPressed and facing=RIGHT)) and global.hasAwesomeShoes=1 and dashPoints>0 //Dash back
      {
        pMoveDashBack()
      }
      else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed and facing=LEFT) or (kDashRightPressed and facing=RIGHT)) and global.hasAwesomeShoes=1 and dashPoints>0 //Dash forward
      {
        pMoveDashForward()
      }
      else
      {
        if kJumpPressed
        {
          //give an initial HUGE jump if jump is pressed and flySpeed is big and canFlyJump and the character is running
          if flySpeed>=95 and jumps=0 and canFlyJump
          {
            playSound(global.snd_PlayerJump[0],0,1)
            jumps=1
            flyAccTimer=5
            flyDir=facing //either LEFT or RIGHT
            yAcc+=initialJumpAcc*0.7
            yVelSetTick=1 //60fps change (added): one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
            if canFly
            {
              flyInitialHeight=y
              flyJumpsTimer=10
              flyJumpWasPressed=-1
            }
          }
          else //----- Normal jump -----
          {
            if global.hasWindBoots=1
            {
              pMoveJump()
            }
          }
        }
      }
    }
    else
    {
      if ((kDown and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed)) and global.hasAwesomeShoes=1 and dashPoints>0 //Dash back
      {
        pMoveDashBack()
      }
      else if ((kUp and kJumpPressed and global.optDPadDash=1) or (kDashRightPressed)) and global.hasAwesomeShoes=1 and dashPoints>0 //Dash forward
      {
        pMoveDashForward()
      }
      else
      {
        if kJumpPressed
        {
          //give an initial HUGE jump if jump is pressed and flySpeed is big and canFlyJump and the character is running
          if flySpeed>=95 and jumps=0 and canFlyJump
          {
            playSound(global.snd_PlayerJump[0],0,1)
            jumps=1
            flyAccTimer=5
            flyDir=facing //either LEFT or RIGHT
            yAcc+=initialJumpAcc*0.7
            yVelSetTick=1 //60fps change (added): one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
            if canFly
            {
              flyInitialHeight=y
              flyJumpsTimer=10
              flyJumpWasPressed=-1
            }
          }
          else //----- Normal jump -----
          {
            if global.hasWindBoots=1
            {
              pMoveJump()
            }
          }
        }
      }
    }
  }
  else if platformCharacterIs(IN_AIR) and dashPoints>0 and airDashRecovery=0 and canAirDash=1 and bWallGrab=0 and global.hasSuaveToken=true //Air dash
  {
    if (((kUp or kDown) and kJumpPressed and global.optDPadDash=1) or (kDashLeftPressed or kDashRightPressed))
    {
      pMoveAirDash()
    }
  }
}

if airDashRecovery>0 //continue air dash
{
  var tAirDashFirstTick;
  tAirDashFirstTick=(airDashRecovery>5) //60fps change (added): still in the air dash's first 30fps tick (it starts at 6)
  //airDashRecovery-=1
  //yVel=-3
  //if facing=RIGHT
  //  xVel=(dashVel+1)
  //else if facing=LEFT
  //  xVel=-(dashVel+1)
  //60fps change: counts 30fps ticks. The velocities are set every frame, so they're flagged (xVelSetTick/yVelSetTick) and
  //pMoveToWrapNew uses the original 30fps formula for them; above 30fps pMoveAirDash's upward kick is added here for the
  //dash's whole first tick, like the 30fps yAcc kick, and that tick keeps the dash frame's acceleration (the run code is
  //skipped for the rest of it, see above)
  airDashRecovery-=1*gDeltaTime
  yVel=-3; yVelSetTick=1
  if gDeltaTime!=1 and tAirDashFirstTick {yVel+=airDashKick}
  if dashTickTime>0 {xAcc=dashTickXAcc}
  if facing=RIGHT
    {xVel=(dashVel+1); xVelSetTick=1}
  else if facing=LEFT
    {xVel=-(dashVel+1); xVelSetTick=1}
}

//if backDashRec>0 {backDashRec-=1}
//if dashMomentumTime>0 {dashMomentumTime-=1} //Dash momentum
if backDashRec>0 {backDashRec-=1*gDeltaTime} //60fps change: counts 30fps ticks
if dashMomentumTime>0 {dashMomentumTime-=1*gDeltaTime} //Dash momentum //60fps change: counts 30fps ticks
if dashTickTime>0 {dashTickTime-=gDeltaTime} //60fps change (added): dash's first 30fps tick (see the run code)

//if jumpTime<jumpTimeTotal
//  jumpTime+=1
if jumpTime<jumpTimeTotal
  jumpTime+=1*gDeltaTime //60fps change: counts 30fps ticks
//let the character continue to jump
//60fps change (added): at 30fps the jump button let go is noticed as a tick starts and the full gravity comes on the next
//tick, half a tick on in the smooth movement above 30fps; at 60fps the next frame is that half tick, at 120fps a quarter,
//so a jump let go early came out lower than 30fps's. At 120fps the frame that notices it keeps the jump's gravity (as in DT3+)
var tRelNow;
tRelNow=0
//if kJump=0 and kDashLeft=0 and kDashRight=0
//  jumpButtonReleased=1
//if jumpButtonReleased
//  jumpTime=jumpTimeTotal
if kJump=0 and kDashLeft=0 and kDashRight=0
  {if jumpButtonReleased=0 {tRelNow=1}; jumpButtonReleased=1} //60fps change: see above
if jumpButtonReleased and !(tRelNow and gDeltaTime<0.5)
  jumpTime=jumpTimeTotal //60fps change: see above
gravityIntensity=(jumpTime/jumpTimeTotal)*grav

if bTakingDamage=false
{
  if kUp and xVel=0 and xAcc=0 and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0
  {
    if kLeft=0 or kRight=0 {state=LOOKING_UP}
    hopOnCount=0
    canAirDash=1
    busterAnimStay=0
    airDashDamage=0
  }
  if kUp=0 and state=LOOKING_UP
  {
    state=STANDING
    hopOnCount=0
    canAirDash=1
    busterAnimStay=0
    airDashDamage=0
  }
  if kDown and platformCharacterIs(ON_GROUND) and isCollisionLadder()=0
  {
    hopOnCount=0
    canAirDash=1
    busterAnimStay=0
    airDashDamage=0
    if isCollisionPlatformBottom(1)
    {
      if isCollisionBottom(1)=0
      {
        y+=1
        state=FALLING
        //yAcc+=grav
        yAcc+=grav; yVelSetTick=1 //60fps change: one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
      }
      else
      {
        //the character can't move down because there is a solid in the way
        state=RUNNING
      }
    }
    else
    {
      //60fps change (added): crouch slide: on the step you crouch, the run code above has already added a full tick of run
      //acceleration, and friction is now the much lighter crouch friction, so at 30fps (speed + runAcc) * crouch friction
      //gives a burst. Above 30fps that tick's acceleration would only partly apply before the run input stops, so this
      //step uses the 30fps formula (pMoveToWrapNew), as in DT3+
      if state!=DUCKING {xVelSetTick=1}
      state=DUCKING
    }
  }
  if kDown=0 and state=DUCKING
  {
    state=STANDING
    xVel=0
    xAcc=0
    hopOnCount=0
    canAirDash=1
    busterAnimStay=0
    airDashDamage=0
  }
}
if xVel=0 and xAcc=0 and state=RUNNING
{
  state=STANDING
  hopOnCount=0
  canAirDash=1
  busterAnimStay=0
  airDashDamage=0
}
if xAcc!=0 and (state=STANDING or state=LOOKING_UP)
{
  state=RUNNING
  hopOnCount=0
  canAirDash=1
  busterAnimStay=0
  airDashDamage=0
}
if yVel<0 and platformCharacterIs(IN_AIR)
{
  state=JUMPING
}
if yVel>0 and platformCharacterIs(IN_AIR)
{
  state=FALLING
}
//---------- slow fall effect ----------
if slowFallTime>0
{
  if slowFallEffect<(jumpTime/jumpTimeTotal)*grav
    gravityIntensity=slowFallEffect
  if slowFallEffect<1
    //slowFallEffect+=0.008
    slowFallEffect+=0.008*gDeltaTime //60fps change: per 30fps tick
  //slowFallTime-=1
  slowFallTime-=1*gDeltaTime //60fps change: counts 30fps ticks
}

if (kUp or kDown) and isCollisionLadder() and ladderTimer=0 and bTakingDamage=false
{
  //nullifies the velocity
  xVel=0
  yVel=0
  //nullifies the acceleration
  xAcc=0
  yAcc=0
  state=CLIMBING
}

//---------- ladder ----------
if isCollisionLadder() and state=CLIMBING and kJumpPressed and bTakingDamage=false
{
  if facing=LEFT
    xVel=-departLadderXVel
  else
    xVel=departLadderXVel
  yAcc+=departLadderYVel
  xVelSetTick=1; yVelSetTick=1 //60fps change (added): set velocity + one-off push, a full 30fps tick's worth (see pMoveToWrapNew)
  state=JUMPING
  jumpButtonReleased=0
  jumpTime=0
}
if kRun and (kLeft or kRight) and bTakingDamage=false
{
  //flySpeed+=2
  flySpeed+=2*gDeltaTime //60fps change: per 30fps tick
  if state!=DUCKING and state!=LOOKING_UP and state!=CLIMBING and state!=FALLING
  {
    if kLeft
    {
      if flySpeed<70
        xAcc-=runAcc*flySpeed/70    //you can change the value here
      else
        xAcc-=runAcc    //you can change the value here
      facing=LEFT
    }
    if kRight
    {
      if flySpeed<70
        xAcc+=runAcc*flySpeed/70    //you can change the value here
      else
        xAcc+=runAcc    //you can change the value here
      facing=RIGHT
    }
  }
}
else
{
  //flySpeed-=3
  flySpeed-=3*gDeltaTime //60fps change: per 30fps tick
}
if bTakingDamage=false
{
  //if kJump {flySpeed-=1}
  if kJump {flySpeed-=1*gDeltaTime} //60fps change: per 30fps tick
  if (kLeft and xVel>0) or (kRight and xVel<0)
  {
    //flySpeed-=10
    flySpeed-=10*gDeltaTime //60fps change: per 30fps tick
    flySpeedTimer=0
  }
  //if the character hits a wall
  if (kLeft and isCollisionLeft(1)) or (kRight and isCollisionRight(1))
  {
    //flySpeed-=20
    flySpeed-=20*gDeltaTime //60fps change: per 30fps tick
    flySpeedTimer=0
  }
}
//set flySpeed to 100 if the flySpeedTimer is still ticking
if flySpeedTimer>0
{
  //flySpeedTimer-=1
  flySpeedTimer-=1*gDeltaTime //60fps change: counts 30fps ticks
  flySpeed=100
}
if flyJumpsTimer>0
{
  if flyJumpWasPressed=-1
    flyJumpWasPressed=0
  else if kJumpPressed
    flyJumpWasPressed=1
  flySpeed=100
  //flyJumpsTimer-=1
  flyJumpsTimer-=1*gDeltaTime //60fps change: counts 30fps ticks
  if jumps>1
  {
    gravityIntensity=0.5
  }
}
else if canFly and isCollisionBottom(1)=0 and isCollisionPlatformBottom(1)=0 and isCollisionPlatform()=0 and jumps>0
{
  flySpeed=100
  if jumps>1
    gravityIntensity=0.5
  if (kJumpPressed or flyJumpWasPressed) and flySpeed>80 and jumps<flyMaxJumps
  {
    jumps+=1
    flyInitialHeight-=50
    flyJumpsTimer=15
    flyJumpWasPressed=-1
    flyAcc2Timer=2
  }
}
//stops everything if the character jumps on a ladder (and stops moving) or ducks
if state=CLIMBING or state=DUCKING
{
  flySpeed=0
  flySpeedTimer=0
  flyAccTimer=0
  flyAcc2Timer=0
}
//causes the actual HUGE jump
if flyAccTimer>0
{
  //flyAccTimer-=1
  flyAccTimer-=1*gDeltaTime //60fps change: counts 30fps ticks (yAcc is a per-tick acceleration, scaled where it's applied)
  yAcc-=1
}
if flyAcc2Timer>0
{
  //flyAcc2Timer-=1
  flyAcc2Timer-=1*gDeltaTime //60fps change: counts 30fps ticks
  if yVel>0
    yVel=0
  if y<flyInitialHeight and y<flyInitialHeight+200
    yAcc+=(0.014)*(flyInitialHeight-y)-5.014
  else if y>flyInitialHeight
    yAcc-=5
  if facing=LEFT
  {
    xAcc-=2
  }
  else
  {
    xAcc+=2
  }
}
//apply the limits of flySpeed
if flySpeed>100
{
  flySpeed=100
  flySpeedTimer=60
}
else if flySpeed<0
  flySpeed=0

//Exterior forces on the player
if extForceX!=0
{
  //xVel+=extForceX
  //if extForceX>0 {extForceX-=0.2}
  //else if extForceX<0 {extForceX+=0.2}
  //60fps change: above 30fps the force goes to pMoveToWrapNew as an acceleration (extAccX/extAccY), so it meets friction
  //the way it does at 30fps, (velocity+force)*friction each tick (as in DT3+); it wears off per 30fps tick
  if gDeltaTime==1 {xVel+=extForceX} else {extAccX=extForceX}
  if extForceX>0 {extForceX-=0.2*gDeltaTime}
  else if extForceX<0 {extForceX+=0.2*gDeltaTime}
  if abs(extForceX)<0.4 {extForceX=0}
}
if extForceY!=0
{
  //yVel+=extForceY
  //if extForceY>0 {extForceY-=0.2}
  //else if extForceY<0 {extForceY+=0.2}
  if gDeltaTime==1 {yVel+=extForceY} else {extAccY=extForceY} //60fps change: see above
  if extForceY>0 {extForceY-=0.2*gDeltaTime}
  else if extForceY<0 {extForceY+=0.2*gDeltaTime}
  if abs(extForceY)<0.4 {extForceY=0}
}

//calculates the horizontal and vertical friction, depending on the state of the charater
if state=CLIMBING
{
  xFric=frictionClimbingX
  yFric=frictionClimbingY
}
else
{
  if state=DUCKING
  {
    if xVel<2 and xVel>-2
      xFric=0.2
    else
      xFric=frictionDuckingX
  }
  else
  {
    //decrease the friction when the character is "flying"
    if canFly and jumps>1
      xFric=frictionFlyingX
    else if flySpeed>50
      xFric=frictionRunningFastX
    //else if platformCharacterIs(IN_AIR) and kLeft=0 and kRight=0
    else if (platformCharacterIs(IN_AIR) or landTickHold>0) and kLeft=0 and kRight=0 //60fps change: see the landing code
      xFric=frictionAirX
    else //On ground
    {
      //if dashMomentumTime>8 {xFric=0.96}
      //60fps change: the counter was just counted down for this frame, so between 30fps ticks it holds fractions: compare
      //against the next whole number so the dash friction lasts exactly as many 30fps ticks as at 30fps (same at 30fps)
      if dashMomentumTime>=9 {xFric=0.96}
      else {xFric=frictionRunningX}
    }
  }
  //if the character is underwater
  if isCollisionWaterTop(1)
  {
    if state=FALLING and yVel>0
      yFric=0.5
    else
      yFric=0.9
  }
  else
    yFric=1
}
//limits the acceleration if it is too extreme
if attackState=TECH_EARTH_SLAM
  yVelLimit=16
else
{
  //slow falling speed if facing wall when touching it
  //wallGrabEffect-=1
  wallGrabEffect-=1*gDeltaTime //60fps change: counts 30fps ticks (one smoke cloud every 2 ticks)
  if (isCollisionLeft(3) and facing=LEFT) or (isCollisionRight(3) and facing=RIGHT) and yVel>0 and global.hasWallGrinder=1 and platformCharacterIs(IN_AIR)
  {
    //bWallGrab=1
    if wallGrabEffect<=0
    {
      var facDir;
      if facing=RIGHT
        facDir=10
      else if facing=LEFT
        facDir=-10
      effect=instance_create(oPlayer1.x+facDir,oPlayer1.y,oEffect)
      effect.sprite_index=sMMSmokeCloud
      effect.image_speed=0.35
      wallGrabEffect=2
    }
    yVelLimit=5.5
  }
  else
  {
    //bWallGrab=0
    yVelLimit=12
  }
}

//60fps change: the acceleration, friction and movement that were here are in pMoveToWrapOrig (unchanged, used at 30fps)
//and pMoveToWrapNew (above 30fps)
if gDeltaTime==1
  pMoveToWrapOrig()
else
  pMoveToWrapNew()
//move the character downhill if possible
//we need to multiply maxDownSlope by the absolute value of xVel since the character normally runs at an xVel larger than 1
//60fps change (added): at 30fps this moves the player down at most maxDownSlope pixels per 30fps tick, so a dash-speed run
//(16 pixels a tick) down a 45 degree slope leaves the slope and flies off it. Done every frame above 30fps, it pulled the
//player down onto the slope instead (up to maxDownSlope pixels every frame: glued to it, 8 pixels a frame at 60fps).
//Above 30fps it now only goes as far as the last 30fps tick's other frames haven't (downSnap1-3: this frame and the 1
//(60fps) or 3 (120fps) before it make a tick), which also keeps how far a run follows a slope's edge before flying off
//close to 30fps's (checked with a simulation of DT2's slopes)
var tDownRoom, tSnapY;
tDownRoom=maxDownSlope
if gDeltaTime<1 {tDownRoom-=downSnap1}
if gDeltaTime<0.5 {tDownRoom-=downSnap2+downSnap3}
tSnapY=y
if isCollisionBottom(1)=0 and maxDownSlope>0 and xVelInteger!=0 and platformCharacterIs(ON_GROUND)
{
  //the character is floating just above the slope, so move the character down
  upYPrev=y
  //for(y=y;y<=upYPrev+maxDownSlope;y+=1)
  for(y=y;y<=upYPrev+tDownRoom;y+=1) //60fps change: see above (tDownRoom is maxDownSlope at 30fps)
    if isCollisionBottom(1) //we hit a solid below
    {
      upYPrev=y //I know that this doesn't seem to make sense, because of the name of the variable, but it all works out correctly after we break out of this loop
      break
    }
  y=upYPrev
}
downSnap3=downSnap2; downSnap2=downSnap1; downSnap1=y-tSnapY //60fps change (added): see above
if landTickHold>0 {landTickHold-=gDeltaTime} //60fps change (added): see the landing code
//the character is no longer taking damage when they hit the ground
//if bTakingDamage=true and (state=STANDING or state=RUNNING or state=DUCKING or state=LOOKING_UP) and damageTime<26
//60fps change: damageTime counts down in fractions between 30fps ticks, so <26 let the player recover half/three quarters
//of a tick early (at 25.5/25.25); <=25 is the same tick as at 30fps
if bTakingDamage=true and (state=STANDING or state=RUNNING or state=DUCKING or state=LOOKING_UP) and damageTime<=25
  bTakingDamage=false
if damageTime<=recoverTime
  bTakingDamage=false

//--------------------------------------------------------------------------------

//effect and extra power for Fire Slam Tech
if attackState=TECH_EARTH_SLAM
{
  if kLeft {xVel=-6}
  else if kRight {xVel=6}
  else {xVel=0}
  yVel=14
  xVelSetExt=1; yVelSetExt=1 //60fps change (added): velocity set every frame: use the 30fps formula (see pMoveToWrapNew). This runs after this frame's move, so it uses the flags that last until the next move
}
//check for Fire/Earth Slam Tech
if attackState=TECH_EARTH_SLAM and platformCharacterIs(ON_GROUND)
{
  playSound(global.snd_JumpStrike,0,1)
  effect=instance_create(oPlayer1.x,oPlayer1.y,oEffect)
  effect.sprite_index=sGroundBlast
  effect.image_alpha=0.75
  effect.image_speed=0.85
  spellEffect="EARTH SLAM"
  playerAttack=instance_create(x+34,y-5,oSpellEffects)
  playerAttack=instance_create(x-34,y-5,oSpellEffects)
  yVel=0
  attackState=0
}

//spell use
if bTakingDamage=false
{
  if kFire and kFirePressed=1 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    playerTechUse(1)
  if kWater and kWaterPressed=1 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    playerTechUse(2)
  if kWind and kWindPressed=1 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    playerTechUse(3)
  if kEarth and kEarthPressed=1 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    playerTechUse(4)
}

//flash time after taking damage
if bCanTakeHit=false
{
  //damageTime-=1
  damageTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if sprite_index!=sPlayerDamaged
  {
    if gDeltaDoTicks //60fps change (added): flicker once per 30fps tick (every frame was 2x/4x as fast)
    {
    if image_alpha=0.75
      image_alpha=0.25
    else
      image_alpha=0.75
    } //60fps change (added)
  }
  //if damageTime=0
  if damageTime<=0 //60fps change: <= (the same at 30fps; a count left on a fraction by an F2 frame rate change still ends)
  {
    image_alpha=1
    bCanTakeHit=true
    bTakingDamage=false
  }
}

if attackState=ACT_CASTED
{
  if castRecovering<=0
    attackState=0
  else
    //castRecovering-=1
    castRecovering-=1*gDeltaTime //60fps change: counts 30fps ticks
}

//figures out what sprite index the character should be
if attackState=0 and bTakingDamage=false
{
  if state=STANDING
    sprite_index=sPlayerIdle
  else if state=RUNNING
    sprite_index=sPlayerWalk
  else if state=DUCKING
    sprite_index=sPlayerDuck
  else if state=LOOKING_UP
    sprite_index=sPlayerLookUp
  else if state=CLIMBING
    sprite_index=sPlayerIdle
  else if state=JUMPING
  {
    if airDashRecovery=0
    {
      if facing=RIGHT
      {
        if xVel>11
          sprite_index=sPlayerJumpForward
        else if xVel<-7.5 or walljumpTime>0
          sprite_index=sPlayerJumpBack
        else
          sprite_index=sPlayerJump
      }
      else
      {
        if xVel>7.5 or walljumpTime>0
          sprite_index=sPlayerJumpBack
        else if xVel<-11
          sprite_index=sPlayerJumpForward
        else
          sprite_index=sPlayerJump
      }
    }
    else
      sprite_index=sPlayerAirDash
  }
  else if state=FALLING and statePrev=FALLING and statePrevPrev=FALLING
  {
    if airDashRecovery=0
    {
      if bWallGrab=0
        sprite_index=sPlayerJump
      else
        sprite_index=sPlayerWallGrab
    }
    else
      sprite_index=sPlayerAirDash
  }
  else if flySpeed>90 and jumps>0 and jumps<flyMaxJumps and platformCharacterIs(IN_AIR)
    sprite_index=sPlayerJumpForward
}
//figures out what attack sprite index the character should be
//attack state animations override action states
if bTakingDamage=false
{
  if attackState=TECH_EARTH_SLAM
    sprite_index=sPlayerEarthSlam

  if attackState=ACT_CASTED
    sprite_index=sPlayerCasted
  else if instance_exists(oBlastOff)
    sprite_index=sPlayerLookUp
}
else
  sprite_index=sPlayerDamaged

//figures out which direction the sprite should be facing
if facing=LEFT
  image_xscale=-1
else if facing=RIGHT
  image_xscale=1

//sets the previous state and the previously previous state
statePrevPrev=statePrev
statePrev=state
attackStatePrevPrev=attackStatePrev
attackStatePrev=attackState
//calculates the image_speed based on the character's velocity
//(image_speed stays in 30fps units: oFrameControl scales GameMaker's animation by gDeltaTime)
if state=RUNNING
  image_speed=abs(xVel)*runAnimSpeed+0.1
else if state=CLIMBING
  image_speed=sqrt(sqr(abs(xVel))+sqr(abs(yVel)))*climbAnimSpeed
else if state=STANDING or state=DUCKING or state=LOOKING_UP
  image_speed=idleAnimSpeed
if attackState!=0
  image_speed=attackAnimSpeed
if sprite_index=sPlayerDamaged
  image_speed=0.75
if sprite_index=sPlayerJumpForward
  image_speed=0.5

//limit the image_speed at 1 so the animation always looks good
if image_speed>1
  image_speed=1
