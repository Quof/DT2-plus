/*
This script should be placed in the "Create Event" of the character.
It sets the variables needed for character.

You can edit the "user variables" if you don't want to use the default values.  

This script sets the collision bounds using this code: setCollisionBounds(-5,-7,5,8)
You can modify the arguments to make a collsion bounds that fits your own sprites.
If you are just going to use the default sprites, there is no reason to edit
the arguments.
*/
gameControl=instance_create(0,0,oGame) //game control
identifier=instance_create(mouse_x,mouse_y,oIdentifier) //follow mouse target
HUD=instance_create(0,0,oHUD)
//constant states that the platform character may be (don't edit)
STANDING=10
RUNNING=11
DUCKING=12
LOOKING_UP=13
CLIMBING=14
JUMPING=15
FALLING=16
DYING=17
LEFT=18
RIGHT=19
ON_GROUND=20
IN_AIR=21
ON_LADDER=22

//constant attack states the character may be (don't edit)
attackState=0 //The attack type the character is performing

//constant action states
ACT_CASTED=31
ACT_MORPHBALL=32
//constant action states
TECH_EARTH_SLAM=50

//the keys that the platform character will use (don't edit)
kLeft=0
kRight=0
kUp=0
kDown=0
kJump=0
kJumpPressed=0
kRun=0
kFire=0
kFirePressed=0
kWater=0
kWaterPressed=0
kWind=0
kWindPressed=0
kEarth=0
kEarthPressed=0
kDashLeft=0
kDashLeftPressed=0
kDashRight=0
kDashRightPressed=0

kLeftPushedSteps=0
kRightPushedSteps=0

//user variables (you can edit these)
player=1                   //player number (player 2 uses different keyboard keys than player 1)
state=FALLING              //the character state, must be one of the following: STANDING, RUNNING, DUCKING, LOOKING_UP, CLIMBING, JUMPING, or FALLING
facing=RIGHT               //which direction the character is facing, must be either LEFT or RIGHT
runAcc=7.35 //4.9                 //the running acceleration
grav=1.15                  //the gravity
initialJumpAcc=-7.4        //relates to how high the character will jump
jumpTimeTotal=22           //how long the user must hold the jump button to get the maximum jump height
climbAcc=0.8               //how fast the character will climb
runAnimSpeed=0.045         //relates to how fast the running animation should go
climbAnimSpeed=0.1         //relates to how fast the climbing animation should go
departLadderXVel=4         //how fast character should be moving horizontally when he leaves the ladder
departLadderYVel=-4        //how fast the character should be moving vertically when he leaves the ladder
maxSlope=4                 //approximately how many pixels the character can climb UPWARDS per step (a value of 5 means the character can climb up a slope of 5)
maxDownSlope=8             //approximately how many pixels the character can climb DOWNWARDS per step (a value of 5 means the character can climb down a slope of 5)
canRun=1                   //when the user presses the shift button, should the character be allowed to run?
canFly=0                   //whether the character can do a fly jump when running at full speed
canFlyJump=0               //whether the character can do continuous fly jumps (mid-air)
flyMaxJumps=5              //the maximum number of jumps the character can perform while flying
frictionAirX=0.82          //friction obtained while in the air while no keys are pressed
frictionRunningX=0.5       //friction obtained while running
frictionRunningFastX=0.98  //friction obtained while holding the shift button for some time while running
frictionClimbingX=0.5      //friction obtained while climbing
frictionClimbingY=0.8      //friction obtained while climbing
frictionDuckingX=0.9       //friction obtained while ducking
frictionFlyingX=0.98       //friction obtained while "flying"
xVelLimit=16               //limits the xVel
yVelLimit=12               //limits the yVel
xAccLimit=10               //limits the xAcc
yAccLimit=10               //limits the yAcc
attackAnimSpeed=0.5        //relates to how fast the attack animations should be
attackSpeed=1              //how fast the character can attack again
attackFinishSpeed=2        //how fast the character can attack again after finishing a combo
dashVel=14                 //the initial dash velocity
lowHealthThreshold=7       //relates to the health percent the character must be at before the low health warning will sound
dashInvulnerability=9      //how long character is invulnerable after dashing
idleAnimSpeed=0.1          //relates to how fast the idle animations should be
castRecoveryTime=2         //how long till the player recovers after casting a spell
dashRecovery=30            //how long it takes to recover 1 dash point
canAirDash=1               //whether the character can dash in the air
chainingTime=130           //time for kill chains

//sets the collision bounds to fit the default sprites (you can edit the arguments of the script)
setCollisionBounds(-8,-39,8,-1)

//hidden variables (don't edit)
statePrev=state
statePrevPrev=statePrev
attackStatePrev=attackState
attackStatePrevPrev=attackStatePrev
gravityIntensity=grav      //this variable describes the current force due to gravity (this variable is altered for variable jumping)
jumpTime=jumpTimeTotal     //current time of the jump (0=start of jump, jumpTimeTotal=end of jump)
jumpButtonReleased=0       //whether the jump button was released. (Stops the user from pressing the jump button many times to get extra jumps)
ladderTimer=0              //relates to whether the character can climb a ladder
jumps=0
flySpeed=0                 //ranges between 0 and 100. When the flySpeed is approximately 100, the character can "fly."
flySpeedTimer=0
flyAccTimer=0
flyAcc2Timer=0
flyJumpsTimer=0
flyJumpWasPressed=0
dashInvulnerabilityTime=0  //current time till character is no longer invulnerable from dashing
slowFallEffect=0           //amount of forced gravity on the character from show fall
slowFallTime=0             //amount of slow fall time
walljumpTime=0             //amount of time to disable left/right after a wall jump
wallGrabEffect=0           //time to replay the wall grab effect
bWallGrab=0                //if the character is wall grabbing
extForceX=0                //external force applied to xVel
extForceY=0                //external force applied to yVel
clingTime=0                //increment wall cling time when pressing away from the wall
clingMax=4                 //time (in frames) before the player can break away from the wall when pressing away from it
bCanStick=1                //if the player can stick to the wall (Prevents the clingtime counter from prematurely resetting)
bSticking=0                //if the player is sticking to the wall
walljumpExtVel=0           //extra velocity from a boosted wall jump time
extVelAmt=1.33             //extra velocity from a boosted wall jump (if the player presses the key away from the wall
dashWarnSound=0            //if the dash warn sound can play
//60fps change (added): above 30fps only (see characterStepEvent and pMoveToWrapNew; the same as in DT3+)
jumpBodge60=1.07           //multiplier on initialJumpAcc (pMoveJump)
jumpGravComp60=0.5         //multiplier on grav added at jump time (pMoveJump)
xVelSetTick=0              //code set xVel/yVel directly this frame: pMoveToWrapNew uses the 30fps formula for it
yVelSetTick=0
xVelSetExt=0               //same, but set by other objects or after the move (knockback, springs, the Earth Slam); cleared once pMoveToWrapNew has used it
yVelSetExt=0
xVelHold=0                 //how long a velocity set just once is kept unchanged (pMoveToWrapNew)
yVelHold=0
xVelSetPrev=0              //whether the last move had a set velocity (pMoveToWrapNew)
yVelSetPrev=0
extAccX=0                  //this frame's external force, applied as acceleration by pMoveToWrapNew
extAccY=0
xAccInputWalk=0            //the walking input's acceleration this frame (pMoveToWrapNew)
airDashKick=0              //the air dash's upward kick, applied during its first tick (pMoveAirDash)
dashTickTime=0             //rest of a dash's first 30fps tick (pMoveDashForward/pMoveDashBack/pMoveAirDash)
dashTickXAcc=0             //the dash frame's xAcc, kept for the rest of that tick
landTickHold=0             //rest of the 30fps tick a dash-momentum landing still counts as in the air
ditherCounter=0            //frames counted for pMoveTo's pixel rounding (oPlayer1's Step)
slopeUpRoom=maxSlope+1     //what's left of a 30fps tick's climb up slopes and steps (pMoveToWrapNew)
downSnap1=0                //how far the move downhill took the player on each of the last 3 frames (characterStepEvent)
downSnap2=0
downSnap3=0

//variables pertaining to attacking
recoverTime=21             //time till character recovers from damage
castRecovering=0           //current time till character recovers
hitCombo=0                 //current hits in combo
killChain=0                //current kills in chain
maxDashPoints=6            //maximum consecutive dashes allowed
dashPoints=maxDashPoints   //current dashes available
dashRecoveryTime=0         //current time till 1 dash point is recovered
tookHitAmount=0            //times character took damage in current room
dashMomentumTime=0         //holds the dash momentum for a bit
backDashRec=0              //used for controlling when the player can stop back dash momentum
airDashRecovery=0          //movement input delay after air dash
idleTime=0                 //how long the character has not moved
hitFontEffect=0            //hit combo font effect time
blastOffRecoveryTime=0     //time till Blast Off can be used again
floatTime=0                //time till gravity doesn't take effect
airDashDamage=0            //power built from air dashing
currentSpell=""            //the current spell being used

//makes the object "active" (don't edit)
makeActive()
