#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(0,0,oScreenCutIn)
y+=1
//set character in proper position on new map
if global.newMapX!=0 and global.newMapY!=0
{
  x=global.newMapX
  y=global.newMapY
}
//set initial values
bPlayable=true //whether the character is playable
parent="player"
charEnemyCreateEvent()
characterCreateEvent()
image_speed=attackAnimSpeed
weight=130
//init run
canRun=0
yVelInteger=0

//variables pertaining to the character's status and inventory
maxLife=global.p1MaxLife
life=global.p1Life
atkPower=global.p1Power
atkDefense=global.p1Defense

maxFireEnergy=global.p1MaxFireEnergy
maxWaterEnergy=global.p1MaxWaterEnergy
maxWindEnergy=global.p1MaxWindEnergy
maxEarthEnergy=global.p1MaxEarthEnergy
fireEnergy=global.p1FireEnergy
waterEnergy=global.p1WaterEnergy
windEnergy=global.p1WindEnergy
earthEnergy=global.p1EarthEnergy
elementCast=0 //Which element is cast

global.currentScore=global.recordScore
global.levelTimeFrameCount=global.recordTime

fireRecharge=0
waterRecharge=0
windRecharge=0
earthRecharge=0

hopOnCount=0
jumpSound=0
if room=rFinal_aFleetA or room=rFinal_aFleetB or room=rFinal_aFleetC
  jumpSound=1

if global.gameOver=true
{
  var tempMplay;
  tempMplay=findMusic()
  playMusic(tempMplay,0)
  global.gameOver=false
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ditherCounter+=1 //60fps change (added): frames counted for pMoveTo's pixel rounding above 30fps
if global.cutscene=true
  characterStepEvent()
//health and spirit percent
/*lifePercent=life/maxLife
firePercent=fireEnergy/maxFireEnergy
waterPercent=waterEnergy/maxWaterEnergy
windPercent=windEnergy/maxWindEnergy
earthPercent=earthEnergy/maxEarthEnergy*/

//check max life
if life>maxLife
  life=maxLife

//death
if life<=0
{
  if room=rBonusC1 or room=rBonusC3 //Challenges
  {
    if oEvBonusChallenge.challengeProg<100
    {
      stopLoopingSounds()
      global.gamePaused=true
      oEvBonusChallenge.challengeProg=100
    }
  }
  else if room=rFinal_EscapeA //Final boss when Claire loses all life
  {
    if instance_exists(oHorrorVirus) //Check if Horror Virus exists
    {
      if oHorrorVirus.bossProgress=28 //All abilities drained
      {
        if oEvEscape.sceneProgress=0 {oEvEscape.sceneProgress=1}
      }
      else //Lost to Horror Virus
      {
        if !instance_exists(oGameOver)
        {
          stopLoopingSounds()
          gameOver=instance_create(0,0,oGameOver)
        }
      }
    }
    else //Before Horror Virus
    {
      if !instance_exists(oGameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oGameOver)
      }
    }
  }
  else //Normal
  {
    if !instance_exists(oGameOver)
    {
      stopLoopingSounds()
      gameOver=instance_create(0,0,oGameOver)
    }
  }
}

if global.gamePaused=false
{
  characterStepEvent()
  //keep player inside room
  if y>room_height+64
  {
    if room!=rExtrasRoom
      life-=maxLife
    else
      y=0
  }
  else if y<-8
    yVel=0

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

  //recharge spirit/element
  //60fps change: the recharge counts below count 30fps ticks (they ran 2x/4x as fast at 60/120fps)
  if fireEnergy<maxFireEnergy //fire
  {
    //fireRecharge+=1
    fireRecharge+=1*gDeltaTime
    if fireRecharge>=30
    {
      fireEnergy+=1
      fireRecharge=0
    }
  }
  else if fireEnergy>maxFireEnergy
    fireEnergy=maxFireEnergy
  if waterEnergy<maxWaterEnergy //water
  {
    //waterRecharge+=1
    waterRecharge+=1*gDeltaTime
    if waterRecharge>=30
    {
      waterEnergy+=1
      waterRecharge=0
    }
  }
  else if waterEnergy>maxWaterEnergy
    waterEnergy=maxWaterEnergy
  if windEnergy<maxWindEnergy //wind
  {
    //windRecharge+=1
    windRecharge+=1*gDeltaTime
    if windRecharge>=30
    {
      windEnergy+=1
      windRecharge=0
    }
  }
  else if windEnergy>maxWindEnergy
    windEnergy=maxWindEnergy
  if earthEnergy<maxEarthEnergy //earth
  {
    //earthRecharge+=1
    earthRecharge+=1*gDeltaTime
    if earthRecharge>=30
    {
      earthEnergy+=1
      earthRecharge=0
    }
  }
  else if earthEnergy>maxEarthEnergy
    earthEnergy=maxEarthEnergy

  //blast off recovery
  if blastOffRecoveryTime>0
  {
    //blastOffRecoveryTime-=1
    blastOffRecoveryTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    if blastOffRecoveryTime<=0
    {
      newDamage=instance_create(x,bbox_bottom-sprite_height+4,oStatusAlert);
      newDamage.statusEffect="Blast Off#Recovered"
      newDamage.statusColor=make_color_rgb(78,192,34)
    }
  }

  //dash invulnerability time
  if dashInvulnerabilityTime>0
  {
    //instance_create(x,y,oPlayerAfterImage)
    //dashInvulnerabilityTime-=1
    if gDeltaDoTicks {instance_create(x,y,oPlayerAfterImage)} //60fps change: one after image per 30fps tick (every frame made 2x/4x as many)
    dashInvulnerabilityTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  }

  //after image effect
  //if attackState=TECH_EARTH_SLAM
  if attackState=TECH_EARTH_SLAM and gDeltaDoTicks //60fps change: one after image per 30fps tick
    instance_create(x,y,oPlayerAfterImage)

  //dash recovery
  if dashPoints<maxDashPoints and walljumpTime=0
  {
    //if dashRecoveryTime>=dashRecovery
    //60fps change: the count is checked before it's added to, so at 30fps a point takes dashRecovery+1 ticks (the tick
    //that reaches dashRecovery, then the one that gives the point). Counting fractions of a tick, the point came one frame
    //after reaching it (half/three quarters of a tick early); the threshold is that much higher so it comes on the same
    //tick as at 30fps (dashRecovery at 30fps)
    if dashRecoveryTime>=dashRecovery+1-gDeltaTime
    {
      dashRecoveryTime=0
      dashPoints+=1
    }
    else
      if dashInvulnerabilityTime=0
        //dashRecoveryTime+=1
        dashRecoveryTime+=1*gDeltaTime //60fps change: counts 30fps ticks

    if global.optDashWarn=1 //Low dash warning
    {
      if dashWarnSound=0 and dashPoints=0 //Ready the sound (For low dash warning)
      {
        playSound(global.snd_DashWarn,0,1,1)
        dashWarnSound=1
      }

      /*if dashWarnSound>=1 and dashWarnSound<=20 //Repeat sound
      {
        dashWarnSound+=1
        if dashWarnSound=10 {playSound(global.snd_DashWarn,0,1,1)}
        else if dashWarnSound=19 {playSound(global.snd_DashWarn,0,1,1)}
      }*/

      if dashWarnSound=1 and dashPoints>=1 //Dash sound ready
      {
        playSound(global.snd_DashWarn,0,1,11025)
        dashWarnSound=0
      }
    }
  }
  //idle time
  /*if xVel=0 and yVel=0
  {
    idleTime+=1
    if idleTime>global.recLongestIdleTime
      global.recLongestIdleTime=idleTime
  }*/
  //---------- STATUS EFFECTS ----------
  if statusPoison>0
  {
    //statusPoison-=1
    statusPoison-=1*gDeltaTime //60fps change: counts 30fps ticks (the "mod 2" below still hits once every other tick: the count lands on every whole number)
    if statusPoison mod 2=0
      life-=1
    if statusPoison<=0
    {
      newDamage=instance_create(x,y-(sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Poison#Recovered"
      newDamage.statusColor=make_color_rgb(78,192,34)
    }
  }
  /*if statusSpiritDrain>0
  {
    statusSpiritDrain-=1
    fireEnergy-=2
    waterEnergy-=2
    windEnergy-=2
    earthEnergy-=2
    if fireEnergy<0
      fireEnergy=0
    if waterEnergy<0
      waterEnergy=0
    if windEnergy<0
      windEnergy=0
    if earthEnergy<0
      earthEnergy=0
    if statusSpiritDrain<=0
    {
      newDamage=instance_create(x,y-(sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Spirit Drain#Recovered"
      newDamage.statusColor=make_color_rgb(78,192,34)
    }
  }
  if statusSkillLock>0
  {
    statusSkillLock-=1
    if statusSkillLock<=0
    {
      newDamage=instance_create(x,y-(sprite_height/2),oStatusAlert);
      newDamage.statusEffect="Skill Lock#Recovered"
      newDamage.statusColor=make_color_rgb(78,192,34)
    }
  }*/
}
#define Mouse_50
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMouseMove=1
{
  x=oIdentifier.x
  y=oIdentifier.y
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  debugMenu=show_menu_pos(320,240,"[0] Change Game Progress|[1] Change Life/Spirit...|[2] Change Items...|[3] Teleport...|[4] Kill All|[5] Set to test values|[6] Go to Test Room|[7] Pause/Unpause|[8] Room Speed|[9] Activate Mouse Movement",-1)
  if debugMenu=0 //==================== CHANGE GAME PROGRESS ====================
    global.gameProgress=get_integer("Change Game Progress",global.gameProgress)
  else if debugMenu=1 //==================== CHANGE LIFE/SPIRIT... ====================
  {
    status=show_menu_pos(320,240,"[0] Change Max Life|[1] Change Max Elemental Energy",-1)
    if status=0
    {
      valueChange=get_integer("Change Max Life",maxLife)
      maxLife=valueChange
      fullhealth=show_question("Restore Health?")
      if fullhealth=true
        life=maxLife
      if life>maxLife
        life=maxLife
    }
    else if status=1
    {
      valueChange=get_integer("Change Max Spirit",maxFireEnergy)
      maxFireEnergy=valueChange
      maxWaterEnergy=valueChange
      maxWindEnergy=valueChange
      maxEarthEnergy=valueChange
      if fireEnergy>maxFireEnergy
        fireEnergy=maxFireEnergy
      if waterEnergy>maxWaterEnergy
        waterEnergy=maxWaterEnergy
      if windEnergy>maxWindEnergy
        windEnergy=maxWindEnergy
      if earthEnergy>maxEarthEnergy
        earthEnergy=maxEarthEnergy
    }
  }
  else if debugMenu=2 //==================== CHANGE ITEMS... ====================
  {
    items=show_menu_pos(320,240,"[0] Suave Token",-1)
    if items=0
      global.hasSuaveToken=get_integer("Suave Token#0:Remove, 1:Equip",global.hasSuaveToken)
  }
  else if debugMenu=3 //==================== TELEPORT ====================
  {
    teleport=show_menu_pos(320,240,"[0] X/Y Position|[1] Change Rooms",-1)
    if teleport=0
    {
      xCoord=get_integer("Enter target x coordinate.",x)
      yCoord=get_integer("Enter target y coordinate.",y)
      x=xCoord
      y=yCoord
    }
    else if teleport=1
    {
      teleport=get_integer("Teleport - 0 for cancel#Note: Will crash the game if roomID does not exist.",room)
      if teleport!=0
      {
        xCoord=get_integer("Enter target x coordinate.",0)
        yCoord=get_integer("Enter target y coordinate.",0)
        global.newMapX=xCoord
        global.newMapY=yCoord
        writeToPlayerGlobals()
        room_goto(teleport)
      }
    }
  }
  else if debugMenu=4 //==================== KILL ALL ====================
  {
    destroy=show_question("This will destroy all objects that extend the oEnemyBase object. Kill?")
    if destroy=true
      with oEnemyBase
        instance_destroy()
  }
  else if debugMenu=5 //==================== TEST VALUES ====================
  {
    setValues=show_question("This will set all relevant variables to the current progress of the game. Proceed?")
    if setValues=true
    {

    }
  }
  else if debugMenu=6 //==================== GO TO TEST ROOM ====================
  {
    setValues=show_question("This will bring you to the testing room. Proceed?")
    if setValues=true
    {
      writeToPlayerGlobals()
      room_goto(rTestRoom)
    }
  }
  else if debugMenu=7 //==================== PAUSE/UNPAUSE ====================
  {
    if global.gamePaused=0
      global.gamePaused=1
    else
      global.gamePaused=0
  }
  else if debugMenu=8 //==================== ROOM SPEED ====================
  {
    room_speed=get_integer("Change Room Speed.",room_speed)
  }
  else if debugMenu=9 //==================== ACTIVATE MOUSE MOVEMENT ====================
  {
    if global.debugMouseMove=0
      global.debugMouseMove=1
    else
      global.debugMouseMove=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if global.optShowGlow=1 and global.p1CurrentElement!=0
{
  draw_set_alpha(0.85)
  draw_set_blend_mode(bm_add)
  if global.p1CurrentElement=1
    draw_circle_color(x,y-26,32,make_color_rgb(255,0,0),c_black,false)
  else if global.p1CurrentElement=2
    draw_circle_color(x,y-26,32,make_color_rgb(0,0,255),c_black,false)
  else if global.p1CurrentElement=3
    draw_circle_color(x,y-26,32,make_color_rgb(0,255,0),c_black,false)
  else if global.p1CurrentElement=4
    draw_circle_color(x,y-26,32,make_color_rgb(220,110,0),c_black,false)
  draw_set_blend_mode(bm_normal)
  draw_set_alpha(1)
}*/
characterDrawEvent()
if bRaveActive=1 //rave glow
{
  draw_set_alpha(0.35)
  raveColor=make_color_rgb(247,190,74)
  draw_set_blend_mode(bm_add)
  draw_circle_color(x,y-27,48,raveColor,c_black,false)
  draw_set_blend_mode(bm_normal)
}
