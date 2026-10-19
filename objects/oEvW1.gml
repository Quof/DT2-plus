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
//as = at 30fps), so they still end if the frame rate changed mid-count. Something done every tick from tick N on starts
//right after tick N-1 (>N-1), so it runs on all of tick N's frames and adds up as at 30fps. Fades are per 30fps tick.
if global.bossTrack=0 //Boss Fight (Garbage Tracker)
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
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
    msgCreate("Something is different here.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("I feel it too. Something big.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=4
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=1
    if sceneDelay=1*gDeltaTime
    {
      shakeScreen=instance_create(oPlayer1.x,oPlayer1.y,oCutsceneShake)
      shakeScreen.shakePower=4
      view_object[0]=oCutsceneShake
    }
    else if sceneDelay=3
      oPlayer1.sprite_index=sPlayerDuck
    else if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Look out, here it comes!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=6
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=1
    if sceneDelay=1*gDeltaTime
    {
      sceneFlash=instance_create(view_xview[0],view_yview[0],oScreenFlash)
      sceneFlash.fadeSpeed=0.04
      view_object[0]=oPlayer1
      with shakeScreen
        instance_destroy()
      boss=instance_create(384,192,oGarbageTracker)
      oPlayer1.sprite_index=sPlayerIdle
    }
    else if sceneDelay>=50
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("It has a very strong Elemental Shield, be careful.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("I will, thanks.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=9
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=3
    if sceneDelay>=3
    {
      global.bossTrack=1
      sceneDelay=0
      sceneProgress=0
      boss.activateBoss=1
      view_object[0]=oPlayer1
      global.currentBoss="Garbage Tracker"
      var tempMplay;
      tempMplay=findMusic()
      playMusic(tempMplay,0)
      global.gamePaused=false
    }
  }
}
else if global.bossTrack=1 //boss fight ends (Garbage Tracker)
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
      oPlayer1.x=256
      oPlayer1.y=337
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
    msgCreate("I did it!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("You were great!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("That was pretty rough, but not quite as hard as I thought#it would be.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("Whoa!!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("What now?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate("Two more coming in at high speeds!",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate("I can't fight two of them.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=12 and bWaitForInput=false
    msgCreate("Get ready, here they come.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=13
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=1
    if sceneDelay=1*gDeltaTime
    {
      sceneFlash=instance_create(view_xview[0],view_yview[0],oScreenFlash)
      sceneFlash.fadeSpeed=0.07
      effect=instance_create(352,32,oEffect)
      effect.sprite_index=sDustCloud
      effect.image_xscale=2
      effect.image_yscale=2
      effect.image_alpha=0.85
      charJerry=instance_create(352,48,oMisc)
      charJerry.sprite_index=sJerryJumpForward
      charJerry.type=1

      effect=instance_create(416,32,oEffect)
      effect.sprite_index=sDustCloud
      effect.image_xscale=2
      effect.image_yscale=2
      effect.image_alpha=0.85
      charJeremy=instance_create(432,48,oMisc)
      charJeremy.sprite_index=sJeremyIdle
      charJeremy.image_xscale=-2
      charJeremy.image_yscale=2
      charJeremy.image_speed=0
      charJeremy.type=1
    }
    //else if sceneDelay>=2
    else if sceneDelay>1
    {
      //charJerry.y+=8
      //charJeremy.y+=8
      charJerry.y+=8*gDeltaTime
      charJeremy.y+=8*gDeltaTime
      if charJerry.y>=336
      {
        charJerry.sprite_index=sJerryKneel
        charJerry.y=336
      }
      if charJeremy.y>=336
        charJeremy.y=336

      if charJerry.y>=336 and charJeremy.y>=336
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if sceneProgress=14 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_EXCITE
    oIdentifier.followTarget=charJeremy
    msgCreate("BAM!!",1,oMessageCutscene,global.mainCharacters[0])
  }
  else if sceneProgress=15
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay=15
    {
      charJerry.sprite_index=sJerryIdle
      charJerry.image_speed=0.1
    }
    //else if sceneDelay=30
    else if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=16 and bWaitForInput=false
    msgCreate("You were right, this was definitely a quicker way through.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=17 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_LOVE
    msgCreate("All the scans were fairly accurate.",1,oMessageCutscene,global.mainCharacters[1])
  }
  else if sceneProgress=18 and bWaitForInput=false
    msgCreate("We should use them more often.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=19 and bWaitForInput=false
    msgCreate("I would, but they are getting really fuzzy from here on it looks like.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=20 and bWaitForInput=false
    msgCreate("Figured out what's causing it yet?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=21 and bWaitForInput=false
    msgCreate("No, but if we keep going, I'm sure we will... ... ...#look behind you.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=22 and bWaitForInput=false
    msgCreate("So not falling for that.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=23 and bWaitForInput=false
    msgCreate("No seriously.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=24 and bWaitForInput=false
    msgCreate("Right...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=25
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=15
    if sceneDelay>=15
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=26 and bWaitForInput=false
    msgCreate(global.mainCharacters[0] +string("?"),1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=27 and bWaitForInput=false
    msgCreate("...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=28
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay=5
      charJerry.image_xscale=-1
    //else if sceneDelay=20
    else if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=29 and bWaitForInput=false
    msgCreate("Uh, hi... Apparently you know who I am?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=30 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
    msgCreate("Oh! Um... Lucky guess.",1,oMessageCutscene,global.mainCharacters[3])
  }
  else if sceneProgress=31 and bWaitForInput=false
    msgCreate("Yeah right, who are you?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=32 and bWaitForInput=false
    msgCreate("I figured it out.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=33 and bWaitForInput=false
  {
    charJerry.image_xscale=1
    msgCreate("When DON'T you figure things out before me?",1,oMessageCutscene,global.mainCharacters[0])
  }
  else if sceneProgress=34 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_EXCITE
    msgCreate(string_upper(global.mainCharacters[0]) +string("!"),1,oMessageCutscene,global.mainCharacters[3])
  }
  else if sceneProgress=35 and bWaitForInput=false
    msgCreate("Oh no...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=36
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay=5
      charJerry.image_xscale=-1
    //else if sceneDelay=15
    else if sceneDelay>=15
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=37 and bWaitForInput=false
    msgCreate("...",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=38 and bWaitForInput=false
    msgCreate("Eh... Long time no see " +string(global.mainCharacters[3]) +string("."),1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=39 and bWaitForInput=false
    msgCreate("... Hi.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=40 and bWaitForInput=false
    msgCreate("Hold up, what are you doing here?#You shouldn't be in a place like this.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=41 and bWaitForInput=false
    msgCreate("Why not " +string(global.mainCharacters[0]) +string(", WHY NOT?!"),1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=42 and bWaitForInput=false
    msgCreate(global.mainCharacters[3] +string(", maybe drop it this time."),1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=43 and bWaitForInput=false
    msgCreate("No, I won't.#Why shouldn't I be here?!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=44 and bWaitForInput=false
    msgCreate("Ugh... This is no place for you.#It's dangerous here!",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=45 and bWaitForInput=false
    msgCreate("I'm perfectly capable of handling myself!#This isn't even real anyway!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=46 and bWaitForInput=false
    msgCreate("You know very well this is about as real as it gets these days.#And you're not...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=47 and bWaitForInput=false
    msgCreate("Don't stop, not what?!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=48 and bWaitForInput=false
    msgCreate("Just leave.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=49 and bWaitForInput=false
    msgCreate("I'm a gamer too " +string(global.mainCharacters[0]) +string("!#Of all places, I can handle myself here."),1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=50 and bWaitForInput=false
    msgCreate("...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=51 and bWaitForInput=false
    msgCreate("Ugh, you do this with EVERYTHING!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=52 and bWaitForInput=false
    msgCreate("I'm sorry that I care enough to worry!",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=53 and bWaitForInput=false
    msgCreate("DAMN IT!!# Why did I even save you back there?!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=54 and bWaitForInput=false
    msgCreate("What?... When?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=55 and bWaitForInput=false
    msgCreate("Oh come on, the Primary Memory!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=56 and bWaitForInput=false
    msgCreate("... ... ... So that really was you!#How did you get out of that?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=57 and bWaitForInput=false
    msgCreate("Shine Spark, how do you think?#That thing stood no chance!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=58 and bWaitForInput=false
    msgCreate("...",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=59 and bWaitForInput=false
    msgCreate("I think we know who won this argument.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=60 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
    msgCreate("Seriously Claire, just leave this place!",1,oMessageCutscene,global.mainCharacters[0])
  }
  else if sceneProgress=61 and bWaitForInput=false
    msgCreate("I will not and you can't change my mind.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=62 and bWaitForInput=false
    msgCreate("Might I suggest we put aside this lover's quarrel#and work together on this?",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=63 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_IDEA
    msgCreate("I agree, we can fix this quicker if we all work together.",1,oMessageCutscene,global.mainCharacters[4])
  }
  else if sceneProgress=64 and bWaitForInput=false
    msgCreate("I doubt it's going to happen.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=65 and bWaitForInput=false
    msgCreate("It's not.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=66 and bWaitForInput=false
    msgCreate("Can we agree to stay out of each other's way?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=67 and bWaitForInput=false
    msgCreate("Yes, I can do that.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=68 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
    msgCreate("... I suppose.",1,oMessageCutscene,global.mainCharacters[4])
  }
  else if sceneProgress=69 and bWaitForInput=false
    msgCreate("It's decided then. " +string(global.mainCharacters[3]) +string(", which way were you two going?"),1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=70 and bWaitForInput=false
    msgCreate("Down south, there's this deserted ruin down there that we want to check out.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=71 and bWaitForInput=false
    msgCreate("Convenient! We're not.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=72 and bWaitForInput=false
    msgCreate("I suppose this is good bye then.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=73 and bWaitForInput=false
    msgCreate("We'll run into each other again, it's okay.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=74 and bWaitForInput=false
  {
    charJerry.image_xscale=1
    oIdentifier.emoteType=oIdentifier.EM_LOVE
    msgCreate("Okay! I'll keep my hopes up!",1,oMessageCutscene,global.mainCharacters[4])
  }
  else if sceneProgress=75 and bWaitForInput=false
    msgCreate("Next time I'll tell you about all the things we've done.#I know I didn't get a lot of time to see you before#all this happened.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=76 and bWaitForInput=false
    msgCreate("I'm not upset, I know you had a lot going on.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=77 and bWaitForInput=false
    msgCreate("We should go.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=78 and bWaitForInput=false
  {
    oIdentifier.emoteType=oIdentifier.EM_MAD
    msgCreate("Okay...",1,oMessageCutscene,global.mainCharacters[4])
  }
  else if sceneProgress=79 and bWaitForInput=false
  {
    charJerry.image_xscale=-1
    oIdentifier.followTarget=oPlayer1
    msgCreate("Hey " +string(global.mainCharacters[3]) +string("..."),1,oMessageCutscene,global.mainCharacters[0])
  }
  else if sceneProgress=80 and bWaitForInput=false
    msgCreate("Yes?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=81 and bWaitForInput=false
    msgCreate("Be careful. " +string(global.mainCharacters[1]) +string(" isn't able to pinpoint what is causing this problem#and that has me worried."),1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=82 and bWaitForInput=false
    msgCreate("... Thanks.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=83
  {
    fadeColor=c_black
    if fadeAlpha<1
      //fadeAlpha+=0.02
      fadeAlpha+=0.02*gDeltaTime
    else if fadeAlpha>=1
    {
      if global.lvlComplete[3]=0 {sceneProgress+=1}
      else {sceneProgress=85}
    }
  }
  else if sceneProgress=84 and bWaitForInput=false
    msgCreate("BONUS CHALLENGE UNLOCKED!!",1,oMessageCutscene,"")
  else if sceneProgress=85
  {
    global.saveOnAuto=1
    if global.gameProgress<2
      global.gameProgress=2
    global.lvlComplete[3]=1
    if global.levelTimeFrameCount<global.lvlTime[3]
      global.lvlTime[3]=global.levelTimeFrameCount
    else if global.lvlTime[3]=0
      global.lvlTime[3]=global.levelTimeFrameCount
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
    if !instance_exists(oGarbageTracker)
      boss=instance_create(384,192,oGarbageTracker)
    sceneProgress=9
  }
  else if global.bossTrack=2 and sceneProgress<83
  {
    sceneDelay=0
    bWaitForInput=false
    with oCutsceneShake
      instance_destroy()
    with oMessageCutscene
      instance_destroy()
    sceneProgress=83
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
