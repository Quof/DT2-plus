#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeAlpha=1
fadeColor=c_black
oPlayer1.image_speed=0.1

charJerry=instance_create(32,288,oMisc)
charJerry.sprite_index=sJerryIdle
charJerry.image_speed=0.1
charJerry.type=1

bkPulsate=0
bkRed=255
bkGreen=128
bkBlue=96
background_blend[0]=make_color_rgb(bkRed,bkGreen,bkBlue)

effectTimeA=irandom_range(0,59)

textAlpha=0
textToDraw=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rEndA //World burning
{
  if global.gameProgress<=36
  {
    //60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime). One-time things keep their checks (they land on the
    //tick's last frame); something done every tick from tick N on (or in ticks N-M) starts right after tick N-1 (>N-1), so
    //it runs on all of tick N's frames and adds up to the same amount as at 30fps (the same checks as before at 30fps)
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay>=10
      sceneDelay+=1*gDeltaTime
      if sceneDelay>9
      {
        oHUD.visible=false
        //fadeAlpha-=0.02
        fadeAlpha-=0.02*gDeltaTime
        if fadeAlpha<=0
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay>=10
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("What's happening out there?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("I don't know... " +string(global.mainCharacters[1]) +string(", what's going on?#Isn't that where The Darkness created the secured zone for everyone?"),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Yes, it is.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("How could this happen?#I thought The Darkness would fix this!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("The Darkness cannot be fixed from here.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("What?! That thing was the Core, right?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("The virus has spread too far through the system.#We never could stop it from here.#On this island there was no way for us to see what was happening to#the rest of the world. The virus blinded us from what it was doing.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("Are you saying it led us here to keep us occupied while it#took control over the rest of the system?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("That's exactly what it did.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("It... knew?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("It knew exactly what it was doing. Now there's no stopping it.#Really the only thing that hasn't been completely corrupt is the#world stability functions. I'm not sure how long that will hold out.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("Like what just happened to Claire,#our abilities will soon be gone as well.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("So it aims to shut down The Darkness completely?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("Yes, and I don't see any way to regain control of the system.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate("There isn't anything we can do?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("I highly doubt it.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate("Oh come on you two!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate("...?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=20 and bWaitForInput=false
    {
      oPlayer1.image_xscale=-1
      msgCreate(global.mainCharacters[0] +string(", remember the game that seemed impossible?#EVERYONE said it was impossible."),1,oMessageCutscene,global.mainCharacters[3])
    }
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("Yeah I remember that.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate("What happened after you refused to give up?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate("I beat it...#I wasn't even as hard as people were saying it was.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate("Exactly! You didn't give up! No matter what the obstacle!#What makes this any different? We're inside a game world, where you#excel at... which still doesn't make up for your lack of skill in certain areas.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate("Excuse me?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate("So you're not giving up, this is our home now!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate("...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate("You're right, we're going to take it all back!#" +string(global.mainCharacters[1]) +string(", are you with us? You can hack anything."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate("I've seen us already overcome the impossible once, let's do it again!#You with us too sis?",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate("Of course! You know what I would do to you if you tried to leave me out.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate("Then it's settled. We're going to stop this virus!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate("Any idea how?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate("There is one thing we can try...",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate("I hope it can work.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=35
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=25
        oPlayer1.image_xscale=1
      else if sceneDelay>=60
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate("We have no choice. Something has to be done...",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=37 //start music
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=1*gDeltaTime //60fps change: on the first frame, as at 30fps
        global.msc_End=SS_LoadSound(working_directory+"\Music\DT_End.ogg",0)
      else if sceneDelay=15
      {
        var tempMplay;
        tempMplay=global.msc_End
        playMusic(tempMplay,0)
      }
      else if sceneDelay>=65
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=38 //show credits
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=1*gDeltaTime //60fps change: on the first frame, as at 30fps
      {
        //(oMisc's built-in speed is scaled by oFrameControl)
        credits=instance_create(320,room_height+8,oMisc)
        credits.type=0
        credits.depth=0
        credits.sprite_index=sCredits
        credits.speed=0.75
        credits.direction=90
      }
      else if sceneDelay>=60
      {
        if credits.y<-credits.sprite_height-24
        {
          with credits
            instance_destroy()
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=39 //fade to black
    {
      //fadeAlpha+=0.02
      fadeAlpha+=0.02*gDeltaTime //60fps change: per 30fps tick
      if fadeAlpha>=1
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=40 //fade music
    {
      //sceneDelay+=1
      //if sceneDelay>=1 and sceneDelay<=200
      //  fadeVolume(global.msc_End,25)
      //else if sceneDelay>=201 and sceneDelay<=300
      //  fadeVolume(global.msc_End,50)
      //60fps change: see sceneProgress 0. The music fades once per 30fps tick (gDeltaDoTicks), in the same whole steps as
      //at 30fps (the sound system's volume is a whole number, so smaller steps every frame wouldn't add up the same)
      sceneDelay+=1*gDeltaTime
      if sceneDelay>0 and sceneDelay<=200
        {if gDeltaDoTicks {fadeVolume(global.msc_End,25)}}
      else if sceneDelay>200 and sceneDelay<=300
        {if gDeltaDoTicks {fadeVolume(global.msc_End,50)}}
      else if sceneDelay>=310
      {
        stopAllMusic()
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=41 //rank check/update
    {
      ini_open("DT2save.dts")
      var sectionWrite,rankOld,rankNew;
      if global.currentQuestLog=1
        sectionWrite="ALPHA"
      else if global.currentQuestLog=2
        sectionWrite="BETA"
      rankOld=global.gameRank
      if global.gamePercent>=100
        rankNew=2
      else
        rankNew=1
      if rankOld<rankNew
        ini_write_real(sectionWrite,"108",rankNew)
      ini_close()
      if rankNew=2
        sceneProgress=200
      else
        sceneProgress=100
    }
    else if sceneProgress=100 //Did not get 100%
    {
      //sceneDelay+=1
      //if sceneDelay>=1 and sceneDelay<=20
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay>0 and sceneDelay<=20
      {
        textToDraw="To see the Extras Room with info about DT3;# beat the game with a 100% Completion Rate."
        //textAlpha+=0.05
        textAlpha+=0.05*gDeltaTime
      }
      //else if sceneDelay>=121 and sceneDelay<=140
      //  textAlpha-=0.05
      else if sceneDelay>120 and sceneDelay<=140
        textAlpha-=0.05*gDeltaTime
      else if sceneDelay>=170
        room_goto(rTitle)
    }
    else if sceneProgress=200 //Completed with 100%
    {
      //sceneDelay+=1
      //if sceneDelay>=1 and sceneDelay<=20
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay>0 and sceneDelay<=20
      {
        //textToDraw="Congratulations on completing the#game with 100%. You will be brought to the#Extras Room. You can go back into the Extras#Room by pressing [P] on the title screen."
        textToDraw="Congratulations on completing the#game with 100%. You will be brought to the#Extras Room. You can go back into the Extras#Room by pressing [Pause] on the title screen." //input text change: [P], or START's icon while the gamepad is in use (drawn by scrDrawInput)
        //textAlpha+=0.05
        textAlpha+=0.05*gDeltaTime
      }
      //else if sceneDelay>=211 and sceneDelay<=230
      //  textAlpha-=0.05
      else if sceneDelay>210 and sceneDelay<=230
        textAlpha-=0.05*gDeltaTime
      else if sceneDelay>=260
      {
        global.lvlCurrent="0-1"
        global.gameProgress=30
        room_goto(rExtrasRoom)
      }
    }
  }
}
keyWaitForInput()

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if room=rEndA
  {
    if global.gameProgress=36
    {
      if sceneProgress<=36
      {
        io_clear()
        scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
        fadeAlpha=0
        sceneDelay=0
        bWaitForInput=false
        with oMessageCutscene
          instance_destroy()
        sceneProgress=37
      }
    }
  }
}

//---------- Background red pulse ----------

//bkPulsate+=1
//if bkPulsate>=1 and bkPulsate<=80
//{
//  bkGreen-=0.5
//  bkBlue-=0.5
//}
//else if bkPulsate>=81 and bkPulsate<=160
//{
//  bkGreen+=0.5
//  bkBlue+=0.5
//  if bkPulsate=160
//    bkPulsate=0
//}
//60fps change: counts 30fps ticks, with the ranges starting right after the tick before them (see sceneProgress 0), so
//the colour pulses as at 30fps (160 ticks)
bkPulsate+=1*gDeltaTime
if bkPulsate>0 and bkPulsate<=80
{
  bkGreen-=0.5*gDeltaTime
  bkBlue-=0.5*gDeltaTime
}
else if bkPulsate>80 and bkPulsate<=160
{
  bkGreen+=0.5*gDeltaTime
  bkBlue+=0.5*gDeltaTime
  if bkPulsate=160
    bkPulsate=0
}
background_blend[0]=make_color_rgb(bkRed,bkGreen,bkBlue)

//---------- effect - explosion ----------
//effectTimeA+=1
effectTimeA+=1*gDeltaTime //60fps change: counts 30fps ticks
if effectTimeA>=60
{
  var efSize; efSize=random_range(0.2,0.5)
  effect=instance_create(random_range(224,room_width-16),random_range(288,room_height-4),oEffect)
  effect.sprite_index=sBombExplosion
  effect.image_alpha=0.6+random(0.3)
  effect.image_blend=background_blend[0]
  effect.image_speed=0.75+random(0.25)
  effect.image_xscale=efSize; effect.image_yscale=efSize
  effectTimeA=irandom_range(0,59)
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

draw_set_font(fnt_Continue)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(textAlpha)
//draw_text(20,120,textToDraw)
scrDrawInput(20,120,textToDraw,-1,-1,1) //input text change: its input [tokens] show the keys, or the gamepad's buttons' icons while it's in use
