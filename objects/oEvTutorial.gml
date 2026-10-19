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
tutorialCounter=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress=0 //Intro to Tutorial
{
  if sceneProgress=0
  {
    //sceneDelay+=1
    //if sceneDelay=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay=1*gDeltaTime //60fps change: on the scene's first frame, as at 30fps
    {
      global.saveOnAuto=1
      global.gamePaused=true
      stopPlayer()
    }
    else if sceneDelay>=15
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=1 and bWaitForInput=false
    msgCreate("Why did you send me here?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate("It's just a training room, the abilities you're using are different than#before so I just wanted to be sure you knew how to utilize them.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("That's thoughtful, but what if I already know what I'm doing?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("If you don't want to go through this, though I recommend you do,#then just run out the exit to your left.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Thanks.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6
  {
    global.gameProgress=1
    sceneProgress=0
    global.gamePaused=false
  }
}
else if global.gameProgress=1 and room=rTutorial //Tutorial
{
  if sceneProgress=0
  {
    if tutorialCounter=0
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutMovement
      sceneProgress+=1
    }
    else if tutorialCounter=1 and oPlayer1.x>=272
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutJump
      sceneProgress+=1
    }
    else if tutorialCounter=2 and oPlayer1.x>=656
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutDash
      sceneProgress+=1
    }
    else if tutorialCounter=3 and oPlayer1.x>=1104
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutAirDash
      sceneProgress+=1
    }
    else if tutorialCounter=4 and oPlayer1.x>=1248
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutDuck
      sceneProgress+=1
    }
    else if tutorialCounter=5 and oPlayer1.x>=1664
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutElements
      newEnemy=instance_create(1472,272,oGoomba)
      newEnemy=instance_create(1824,272,oGreenParatroopa)
      newEnemy.bActive=true
      newEnemy.questType=0
      sceneProgress+=1
    }
    else if tutorialCounter=6 and oPlayer1.x>=1888
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutEnergy
      sceneProgress+=1
    }
    else if tutorialCounter=7 and oPlayer1.x>=2112
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutElemental
      sceneProgress+=1
    }
    else if tutorialCounter=8 and oPlayer1.x>=3104
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutElements2
      sceneProgress+=1
    }
    else if tutorialCounter=9 and oPlayer1.x>=3648
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutWallJump
      sceneProgress+=1
    }
    else if tutorialCounter=10 and oPlayer1.x>=3904
    {
      tutPan=instance_create(view_xview[0]+112,128,oTutorialPanel)
      tutPan.sprite_index=sTutExtra
      sceneProgress+=1
    }
  }
  else if sceneProgress=1
  {
    global.gamePaused=true
    stopPlayer()
    sceneProgress+=1
  }
  else if sceneProgress=2
  {
    //60fps change: the panel's slide and fade are per 30fps tick (12px a tick: it still stops on the same spot)
    if tutPan.image_alpha<1
      //tutPan.image_alpha+=0.1
      tutPan.image_alpha+=0.1*gDeltaTime
    //tutPan.x+=12
    tutPan.x+=12*gDeltaTime
    if tutPan.x>=view_xview[0]+(view_wview[0]/2)
    {
      bWaitForInput=true
      sceneProgress+=1
    }
  }
  else if sceneProgress=3 or sceneProgress=4 and bWaitForInput=false
  {
    //tutPan.image_alpha-=0.1
    //tutPan.x+=12
    tutPan.image_alpha-=0.1*gDeltaTime //60fps change: see sceneProgress 2
    tutPan.x+=12*gDeltaTime
    if tutPan.x>=view_xview[0]+view_wview[0]-112
    {
      global.gamePaused=false
      tutorialCounter+=1
      sceneProgress=0
    }
  }
}
keyWaitForInput()

//if keyboard_check_pressed(ord("M"))
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //gamepad change: and the gamepad (scrGamepadInit)
{
  if global.gameProgress=0
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    sceneProgress=6
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
