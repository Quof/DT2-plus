#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeAlpha=0
fadeColor=c_white
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime). One-time things keep their checks (they land on the
//tick's last frame), except a scene's start (=1*gDeltaTime, its first frame); counts that end a scene use >= (the same
//as = at 30fps), so they still end if the frame rate changed mid-count. Fades are per 30fps tick.
if global.bossTrack=0 //Boss Fight (Quadradic Wall Shifting Golem)
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    stopAllMusic()
    oPlayer1.y+=1
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate("Well that was a bust. Nothing was in this place except a few#gross looking monkeys.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("Those and...",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("What is that up there?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("I think we were led into a trap...",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=6
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=3
    if sceneDelay>=3
    {
      global.bossTrack=1
      sceneDelay=0
      sceneProgress=0
      global.currentBoss="TWSG"
      var tempMplay;
      tempMplay=findMusic()
      playMusic(tempMplay,0)
      global.gamePaused=false
    }
  }
}
else if global.bossTrack=1 //boss fight ends (Quadradic Wall Shifting Golem)
{
  if sceneProgress=0 and enemyCount=0
  {
    global.gamePaused=true
    oPlayer1.image_speed=0
    oPlayer1.bCanTakeDamage=false
    stopAllMusic()
    global.bossTrack=2
    sceneProgress+=1
  }
}
else if global.bossTrack=2
{
  if sceneProgress=1
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=2
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=1
    if sceneDelay=1*gDeltaTime
    {
      endBoss()
      oPlayer1.x=320
      oPlayer1.y=273
      oPlayer1.image_xscale=1
    }
    if sceneDelay>=60
    {
      oPlayer1.life=oPlayer1.maxLife
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=3
  {
    if fadeAlpha>0
      //fadeAlpha-=0.05
      fadeAlpha-=0.05*gDeltaTime
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=4
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=25
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("You mentioned this was a trap...",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("I think it was anyway. Something just doesn't feel right.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("The trap failed if that's the case.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("Yeah, but still. Something about this island doesn't seem right.#I feel like we're being watched.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("Jerry's on the island and you know he likes to perv.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate("You know that's not what I mean. And the signal that#this 'disturbance' came from suddenly moved!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate("Any idea where?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate("Some desert to the south.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=13 and bWaitForInput=false
    msgCreate("Wasn't it a bog?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=14 and bWaitForInput=false
    msgCreate("Nope, definately a desert!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=15 and bWaitForInput=false
    msgCreate("Well let's go then. I wanna solve this before Jerry does.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=16
  {
    fadeColor=c_black
    if fadeAlpha<1
      //fadeAlpha+=0.02
      fadeAlpha+=0.02*gDeltaTime
    else if fadeAlpha>=1
    {
      if global.lvlComplete[6]=0 {sceneProgress+=1}
      else {sceneProgress=18}
    }
  }
  else if sceneProgress=17 and bWaitForInput=false
    msgCreate("BONUS CHALLENGE UNLOCKED!!",1,oMessageCutscene,"")
  else if sceneProgress=18
  {
    global.saveOnAuto=1
    if global.gameProgress<2
      global.gameProgress=2
    global.lvlComplete[6]=1
    if global.levelTimeFrameCount<global.lvlTime[6]
      global.lvlTime[6]=global.levelTimeFrameCount
    else if global.lvlTime[6]=0
      global.lvlTime[6]=global.levelTimeFrameCount
    transition_steps=30
    transition_kind=20
    //room_goto(rWorldMap)
    room_goto_fixed(rWorldMap) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
  }
}

keyWaitForInput()

//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if global.bossTrack=0
  {
    sceneDelay=0
    bWaitForInput=false
    with oCutsceneShake
      instance_destroy()
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=6
  }
  else if global.bossTrack=2 and sceneProgress<16
  {
    sceneDelay=0
    bWaitForInput=false
    with oCutsceneShake
      instance_destroy()
    with oMessageCutscene
      instance_destroy()
    sceneProgress=16
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)
}
