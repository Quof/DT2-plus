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

if global.gameProgress<=8
{
  fadeAlpha=1
  fadeColor=c_black

  charJerry=instance_create(288,352,oMisc)
  charJerry.sprite_index=sJerryIdle
  charJerry.image_xscale=-1
  charJerry.image_speed=0.1
  charJerry.type=1
}

if room=rFinal_a6_2
{
  image_speed=0.75
  deathWallX=0
  dwSpd=2
  dwMinSpd=2

  meteorTime=0
  roomProgress=0
  progTime=0
}
else if room=rFinal_aFleetA or room=rFinal_aFleetB or room=rFinal_aFleetC
{
  if room=rFinal_aFleetA
    xScrollSpd=1.5
  else if room=rFinal_aFleetB
    xScrollSpd=2
  else if room=rFinal_aFleetC
    xScrollSpd=5

  yBobDown=0
  yScrollAmt=0
  autoScroll=instance_create(256,192,oMisc) //room_height-(view_hview[0]/2)+32
  autoScroll.type=0
  autoScroll.sprite_index=sNull
  view_object[0]=autoScroll

  cloudTime=0
}
else if room=rFinal_Boss_Core and global.gameProgress<=30
{
  if global.bossTrack=0
  {
    boss=instance_create(384,256,oVirusCore)
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rFinal_a1 //Final Level intro
{
  if global.gameProgress<=8
  {
    //60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime). One-time things keep their checks (they land on the
    //tick's last frame), except the scene's start (=1*gDeltaTime, its first frame). Something done every tick from tick N
    //on starts right after tick N-1 (>N-1), so it runs on all of tick N's frames and adds up as at 30fps. Counts that end
    //a scene use >= (the same as = at 30fps), so they still end if the frame rate changed mid-count.
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1*gDeltaTime
        global.gamePaused=true
      //else if sceneDelay>=20
      else if sceneDelay>19
      {
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
      if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("What do we do now? And what is that thing?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("Hold on, this place has a ton of locked data.#Give me a moment to figure this out.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Will do.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=5
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=40
        oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
      else if sceneDelay>=50
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("Will someone please say something?! This is so awkward.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("Eh... you go first.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("Why do I have to?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("You're better at talking? ... A lot.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("Excuse me?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=11 and bWaitForInput=false
    {
      oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
      msgCreate("Is there any way you two can get along?",1,oMessageCutscene,global.mainCharacters[4])
    }
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("Yeah, if SOMEONE wasn't always in a bad mood.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("You're the one who started this whole thing!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=14 and bWaitForInput=false
    {
      oIdentifier.emoteType=oIdentifier.EM_EMBARRASS
      msgCreate("I merely continued it.",1,oMessageCutscene,global.mainCharacters[0])
    }
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("Okay, I deciphered the data.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate("Continued? I'm in a bad mood all the time because you're#such an ass to me!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("Did I come back at a bad time?",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate("I don't try, lets not forget that one time...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=19 and bWaitForInput=false
    {
      SS_PlaySound(global.snd_Chao_Hey1)
      msgCreate("HEY!",1,oMessageCutscene,global.mainCharacters[4])
    }
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate("AHH, what the heck " +string(global.mainCharacters[4]) +string("! Don't make that sound!"),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("Sorry, but " +string(global.mainCharacters[1]) +string(" is trying to say something."),1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate("Oh right, continue.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate("I've found what happened to The Darkness, and it isn't good.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate("What happened?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate("I don't know how, but a virus has infected its systems.#It went after The Darkness' ability to send messages to the world as well#as manipulate it.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate("A virus is causing all the problems?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate("Yes and it's spreading. I don't know how much, but we need to stop it.#I've pinpointed that the source is here. I think that if we can get#to it and destroy it, that should do the trick.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=28 and bWaitForInput=false
      msgCreate("That simple?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate("In theory, yes. I'm going to have you target the section that is blocking#The Darkness' control functions. If we can get those back, The Darkness can#wipe the virus from its systems on its own.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate("Sounds like a plan, just direct us on what to do.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate("I'm gonna need you two to split up. I'm going to have you go to the area below.#The area is more dense with the virus, so I think you should handle it.#No offense to you " +string(global.mainCharacters[3]) +string(", I'm just bringing you two to places that I think suit your#abilities better."),1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate("No offense taken.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate(global.mainCharacters[0] +string(", I'll give you more info once you've started."),1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate("Sounds good.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate(global.mainCharacters[3] +string(", I'm going to have you stay on the top level and go after#the virus' lock on The Darkness'. Before you can get to it, there is a#security function in place that you need to shut down first."),1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate("I'm going after the virus?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate("Just the part blocking The Darkness' communication functions.#There shouldn't be a lot of resistance from it.#What I'm having " +string(global.mainCharacters[0]) +string(" do will slow it down and draw its attention."),1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate("Okay, how do I get there?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate("I'll show you the layout. It isn't too complicated.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=40
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=20
      {
        areaMap=instance_create(256,124,oMisc)
        areaMap.sprite_index=sFLGrid
        areaMap.type=1
      }
      else if sceneDelay>=50
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate("Section 1 is where we are now. The green paths you see are unlocked now.#You just need to unlock the three red paths. Once you've done that,#the route we want will open up in this one.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=42 and bWaitForInput=false
      msgCreate("I think I understand.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate("You'll understand fully in a bit.#We need to hurry, that virus is spreading more and more.#I'll provide data for you both, just ask.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=44 and bWaitForInput=false
      msgCreate("All right, I'll head down now.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=45
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=20
      {
        charJerry.sprite_index=sPlayerDiscombobulate
        charJerry.image_index=1
        charJerry.image_speed=0
      }
      else if sceneDelay=21
        charJerry.image_index=0
      //else if sceneDelay>=22
      else if sceneDelay>21 //60fps change: see sceneProgress 0
      {
        //charJerry.y-=14
        charJerry.y-=14*gDeltaTime
        if charJerry.y<=-14
        {
          with charJerry
            instance_destroy()
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=46 and bWaitForInput=false
      msgCreate("To move to other sections, just check out that map grid over there.#A selection menu will appear at the top. More paths will open as you unlock them.#Keep in mind, that progressing to a new section does not mean it will appear here.#The path must be opened from within the sections, which are only 3, 5, and 6.#Also, if you want to save your progress, just find the save icons I've placed down.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=47 and bWaitForInput=false
      msgCreate("Gotcha, thanks for the help.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=48 and bWaitForInput=false
      msgCreate("We need to work together.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=49 and bWaitForInput=false
      msgCreate("I can still help you out too!",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=50
    {
      with oMisc
        instance_destroy()
      sceneProgress=0
      if global.gameProgress<=8
        global.gameProgress=9
      global.gamePaused=false
    }
  }
}
else if room=rFinal_a3_1 //Distortion?
{
  if global.gameProgress<=12
  {
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks (see rFinal_a1's sceneProgress 0)
      if sceneDelay=1*gDeltaTime
        global.gamePaused=true
      else if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate("Why is this place changing?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("It looks like the virus started here, so it has distorted this place.#Watch yourself, anything can happen here.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("Oh and what's that thing over there?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Destroy it and the path from the main room will open up.#You'll get a checkpoint to this area.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("Ah, now it makes sense.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6
    {
      sceneProgress=0
      if global.gameProgress<=12
        global.gameProgress=13
      global.gamePaused=false
    }
  }
}
else if room=rFinal_a6_1 //One more path to open after this
{
  if global.gameProgress<=19
  {
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks (see rFinal_a1's sceneProgress 0)
      if sceneDelay=1*gDeltaTime
        global.gamePaused=true
      else if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate("This is easy.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("Unfortunately it's not going to be as easy as it looks.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("Why not?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("While destroying this one will open the 3rd path, there is one more through#the doorway that will open the way for us to the virus.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("This is too much. There isn't much left is there?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("Not that I can see. It looks like the path to the virus is very short.#I can alter some things to make a direct path.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("That sounds nice.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("I won't be able to help you on this route though.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("I can do it.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("If I can help, I will.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=11
    {
      sceneProgress=0
      if global.gameProgress<=19
        global.gameProgress=20
      global.gamePaused=false
    }
  }
}
else if room=rFinal_a6_3 //What just happened?
{
  if global.gameProgress<=23
  {
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks (see rFinal_a1's sceneProgress 0)
      if sceneDelay=1*gDeltaTime
        global.gamePaused=true
      else if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate("What just happened?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=2 and bWaitForInput=false
    {
      oIdentifier.emoteType=oIdentifier.EM_IDEA
      msgCreate("I... don't know.",1,oMessageCutscene,global.mainCharacters[4])
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("Sorry about being so late.#I changed the way the advancing wall worked just before it reached you.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Oh, well thanks. I was freaking out for a moment there.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("I can imagine. I laughed though.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("...",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("Anyway, just destroy that last one and the way to the virus will be open#in the main room. I've got you a direct path.#Though you will have to get past its defense fleet.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("Just one last trial and this will all be over.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=9
    {
      sceneProgress=0
      if global.gameProgress<=23
        global.gameProgress=24
      global.gamePaused=false
    }
  }
}
else if room=rFinal_Boss_Core //You can go back if needed
{
  if global.gameProgress=29
  {
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks (see rFinal_a1's sceneProgress 0)
      if sceneDelay=1*gDeltaTime
        global.gamePaused=true
      else if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate("I made it!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("We knew you could do it.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("What now?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("First off, that door can be used to take you out if you need.#You can return here any time. If there's anything you want#to do, do it now. There's no turning back after this.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("Okay.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("You just need to destroy the core part of the virus that's holding back#The Darkness' control functions. After that, The Darkness will take#care of the rest.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("Got it, but are you sure The Darkness will do that?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("Yes, The Darkness primary function is to keep itself running in#whatever state it chooses is optimal. The virus is keeping it from doing this.#It will wipe the virus from its systems the moment it has control.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("And just like that everything will go back to normal?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("Yep, won't be a problem for it.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("Okay, I'm ready.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=12
    {
      sceneProgress=0
      if global.gameProgress<=29
        global.gameProgress=30
      global.gamePaused=false
    }
  }
  if global.gameProgress=30
  {
    if global.bossTrack=0
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=192
        {
          global.gamePaused=true
          stopPlayer()
          xVel=0
          yVel=0
          oPlayer1.sprite_index=sPlayerJump
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        if oPlayer1.y<480
          //oPlayer1.y+=4
          oPlayer1.y+=4*gDeltaTime //60fps change: per 30fps tick
        else
        {
          //sceneDelay+=1
          //if sceneDelay=1
          //60fps change: see rFinal_a1's sceneProgress 0 (the afterimages land on the same whole ticks: sceneDelay mod 3
          //is only 0 on whole numbers)
          sceneDelay+=1*gDeltaTime
          if sceneDelay=1*gDeltaTime
          {
            oPlayer1.y=480
            oPlayer1.sprite_index=sPlayerIdle
          }
          else if sceneDelay>=40 and sceneDelay<=70 and sceneDelay mod 3=0
          {
            afterImage=instance_create(boss.x,boss.y,oSceneAfterImage)
            afterImage.image_alpha=0.7
            afterImage.sprite_index=boss.sprite_index
            afterImage.image_index=boss.image_index
            afterImage.imageFade=0.05
            afterImage.xScalingSet=0.1+((sceneDelay-40)*0.05)
            afterImage.yScalingSet=0.1+((sceneDelay-40)*0.05)
          }
          else if sceneDelay>=110
          {
            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
      else if sceneProgress=2 and bWaitForInput=false
      {
        oIdentifier.emoteType=oIdentifier.EM_EXCITE
        msgCreate("Your arrival has been foreseen.",1,oMessageCutscene,"Core")
      }
      else if sceneProgress=3 and bWaitForInput=false
        msgCreate("Whoa, wait a minute. It just spoke!",1,oMessageCutscene,global.mainCharacters[1])
      else if sceneProgress=4 and bWaitForInput=false
        msgCreate("What does that mean?",1,oMessageCutscene,global.mainCharacters[4])
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate("Eh, I don't know!",1,oMessageCutscene,global.mainCharacters[1])
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate("Your attempts to regain control have not gone unnoticed.#The procedures have been put in motion to see that it does not occur.",1,oMessageCutscene,"Core")
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate("What do we do?",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate("Kick its ass " +string(global.mainCharacters[3]) +string("! It's bluffing.#You can beat that thing no problem!"),1,oMessageCutscene,global.mainCharacters[0])
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate("He's right. Destroy the core and The Darkness won't be blocked.",1,oMessageCutscene,global.mainCharacters[1])
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate("Okay, I'm going to do this! I won't lose!",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=11 and bWaitForInput=false
        msgCreate("How futile your attempts are.#Deleting you is the only appropriate action.",1,oMessageCutscene,"Core")
      else if sceneProgress=12
      {
        //sceneDelay+=1
        //if sceneDelay=3
        sceneDelay+=1*gDeltaTime //60fps change: see rFinal_a1's sceneProgress 0
        if sceneDelay>=3
        {
          with oSceneAfterImage
            instance_destroy()
          barrier1=instance_create(144,384,oBossBarrier)
          barrier2=instance_create(608,384,oBossBarrier)
          global.bossTrack=1
          boss.activateBoss=1
          sceneDelay=0
          sceneProgress=0
          global.currentBoss="Core"
          var tempMplay;
          tempMplay=findMusic()
          playMusic(tempMplay,0)
          global.gamePaused=false
        }
      }
    }
    else if global.bossTrack=1 //boss fight ends (Virus Core)
    {
      if sceneProgress=0 and enemyCount=0
      {
        global.gamePaused=true
        playSound(global.snd_EnemyDie,0,1)
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
          fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
        else if fadeAlpha>=1
          sceneProgress+=1
      }
      else if sceneProgress=2
      {
        //sceneDelay+=1
        //if sceneDelay=20
        sceneDelay+=1*gDeltaTime //60fps change: see rFinal_a1's sceneProgress 0
        if sceneDelay>=20
        {
          endBoss()
          barrier=instance_create(144,384,oEventBarrier)
          oPlayer1.x=384
          oPlayer1.y=480
          oPlayer1.image_xscale=1
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=3
      {
        if fadeAlpha>0
          //fadeAlpha-=0.05
          fadeAlpha-=0.05*gDeltaTime //60fps change: per 30fps tick
        else if fadeAlpha<=0
          sceneProgress+=1
      }
      else if sceneProgress=4
      {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: see rFinal_a1's sceneProgress 0
        if sceneDelay>=25
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 and bWaitForInput=false
        msgCreate("I... we did it!",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=6 and bWaitForInput=false
        msgCreate("Yay! It didn't stand a chance against us!",1,oMessageCutscene,global.mainCharacters[4])
      else if sceneProgress=7 and bWaitForInput=false
        msgCreate("How long will it take for The Darkness to take back control?",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=8 and bWaitForInput=false
        msgCreate("It should have been instantaneous, but nothing has changed...#I don't get it.",1,oMessageCutscene,global.mainCharacters[1])
      else if sceneProgress=9 and bWaitForInput=false
        msgCreate("I'm coming back up to your area, the virus hasn't changed down here either.#It's becoming overwhelming down here.",1,oMessageCutscene,global.mainCharacters[0])
      else if sceneProgress=10 and bWaitForInput=false
        msgCreate("What's going to happen then?",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=11 and bWaitForInput=false
        msgCreate("Just get out of there, use the exit to your right.#I found something that's now unblocked. If I can hack past the Virus'#defenses then I should be able to get The Darkness back in control.",1,oMessageCutscene,global.mainCharacters[1])
      else if sceneProgress=12 and bWaitForInput=false
        msgCreate("Okay, I'm going.",1,oMessageCutscene,global.mainCharacters[3])
      else if sceneProgress=13
      {
        if global.gameProgress<31
          global.gameProgress=31
        with oZapTrap
          instance_destroy()
        rightDoor=instance_create(680,416,oExit)
        rightDoor.sprite_index=sKirbyDoorway
        rightDoor.bShowArrow=true
        rightDoor.exitType=0
        rightDoor.newMapX=0
        rightDoor.newMapY=0
        rightDoor.toRoom=rFinal_EscapeA
        global.gamePaused=false
      }
    }
  }
}
keyWaitForInput()

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if room=rFinal_a1
  {
    if global.gameProgress<=8
    {
      fadeAlpha=0
      sceneDelay=0
      bWaitForInput=false
      with oEffect
        instance_destroy()
      with oMisc
        instance_destroy()
      with oMessageCutscene
        instance_destroy()
      sceneProgress=50
    }
  }
  else if room=rFinal_a3_1
  {
    if global.gameProgress<=12
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=6
    }
  }
  else if room=rFinal_a6_1
  {
    if global.gameProgress<=19
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=11
    }
  }
  else if room=rFinal_a6_3
  {
    if global.gameProgress<=23
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=9
    }
  }
  else if room=rFinal_Boss_Core
  {
    if global.gameProgress<=29
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=12
    }
    else if global.gameProgress<=30
    {
      if global.bossTrack=0
      {
        sceneDelay=0
        bWaitForInput=false
        oPlayer1.y=480
        oPlayer1.sprite_index=sPlayerIdle
        with oMessageCutscene
          instance_destroy()
        sceneProgress=12
      }
      else if global.bossTrack=2
      {
        sceneDelay=0
        fadeAlpha=0
        bWaitForInput=false
        endBoss()
        oPlayer1.x=384
        oPlayer1.y=480
        oPlayer1.image_xscale=1
        oPlayer1.sprite_index=sPlayerIdle
        with oMessageCutscene
          instance_destroy()
        sceneProgress=13
      }
    }
  }
}

//---------- LEVEL EVENTS ----------
if global.gamePaused=false
{
  if room=rFinal_a6_2
  {
    //-------------------- Check Death Wall --------------------
    if deathWallX<7000
    {
      if dwMinSpd<3 and oPlayer1.x>=384
        dwMinSpd=3
      else if dwMinSpd<4 and oPlayer1.x>=1024
        dwMinSpd=4
      else if dwMinSpd<5 and oPlayer1.x>=1792
        dwMinSpd=5
      else if dwMinSpd<6 and oPlayer1.x>=3376
        dwMinSpd=6
      else if dwMinSpd<7 and oPlayer1.x>=4368
        dwMinSpd=7
      else if dwMinSpd<8 and oPlayer1.x>=5354
        dwMinSpd=8
      else if dwMinSpd<10 and oPlayer1.x>=6144
        dwMinSpd=10
    }

    pdwDist=point_distance(oCharacter.x,0,x,0)<256
    if pdwDist<=127
      dwSpd=dwMinSpd-1
    else if pdwDist>=128 and pdwDist<=223
      dwSpd=dwMinSpd
    else if pdwDist>=224 and pdwDist<=335
      dwSpd=dwMinSpd+1
    else if pdwDist>=336 and pdwDist<=447
      dwSpd=dwMinSpd+2
    else if pdwDist>=448
      dwSpd=dwMinSpd+4

    //deathWallX+=dwSpd
    deathWallX+=dwSpd*gDeltaTime //60fps change: per 30fps tick
    if deathWallX>=oPlayer1.x
    {
      if oPlayer1.x>=7088 //fake Game Over
        fakeGO=instance_create(0,0,oFakeGameOver)
      else
        oPlayer1.life-=oPlayer1.maxLife
    }
    //-------------------- Room events: Meteors falling  --------------------
    if roomProgress=0 and oPlayer1.x>=400
    {
      var tMeteorX; tMeteorX=480
      for(i=0;i<3;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=250+(i*10)
        newMeteor.newSpd=0
        tMeteorX+=48
      }
      tMeteorX+=48
      newMeteor=instance_create(tMeteorX,-256,oS6Meteor)
      newMeteor.direction=270
      newMeteor.newSpd=4
      roomProgress+=1
    }
    else if roomProgress=1 and oPlayer1.x>=992
    {
      newPlatform=instance_create(1312,-48,oS6FallPlatform)
      newPlatform.image_xscale=6; newPlatform.image_yscale=5
      newPlatform.bStartOn=1; newPlatform.newTime=15

      var tMeteorX; tMeteorX=1088
      for(i=0;i<3;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=250+(i*10)
        newMeteor.newSpd=0
        tMeteorX+=48
      }
      newMeteor=instance_create(1360,-256,oS6Meteor)
      newMeteor.direction=270
      newMeteor.newSpd=4
      roomProgress+=1
    }
    else if roomProgress=2 and oPlayer1.x>=1520
    {
      newPlatform=instance_create(1680,-96,oS6FallPlatform)
      newPlatform.image_xscale=12; newPlatform.image_yscale=2
      newPlatform.bStartOn=1; newPlatform.newTime=15
      roomProgress+=1
    }
    else if roomProgress=3 and oPlayer1.x>=1792
    {
      var tMeteorX; tMeteorX=1664
      for(i=0;i<4;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=245+(i*10)
        newMeteor.newSpd=0
        tMeteorX+=64
      }
      roomProgress+=1
    }
    else if roomProgress=4
    {
      //progTime+=1
      progTime+=1*gDeltaTime //60fps change: counts 30fps ticks (lands on each spawn time)
      if progTime=1
      {
        newMeteor=instance_create(2000,-32,oS6Meteor)
        newMeteor.direction=280
        newMeteor.newSpd=0
        newPlatform=instance_create(2080,-32,oS6FallPlatform)
        newPlatform.image_xscale=4; newPlatform.image_yscale=2
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(1952,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=30
      {
        newPlatform=instance_create(2240,-64,oS6FallPlatform)
        newPlatform.image_xscale=2; newPlatform.image_yscale=4
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2192,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=60
      {
        newPlatform=instance_create(2384,-64,oS6FallPlatform)
        newPlatform.image_xscale=4; newPlatform.image_yscale=4
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2336,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=70
      {
        newPlatform=instance_create(2480,-192,oS6FallPlatform)
        newPlatform.image_xscale=2; newPlatform.image_yscale=12
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2432,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=115
      {
        newPlatform=instance_create(2608,-64,oS6FallPlatform)
        newPlatform.image_xscale=6; newPlatform.image_yscale=4
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2560,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=150
      {
        newPlatform=instance_create(2800,-32,oS6FallPlatform)
        newPlatform.image_xscale=2; newPlatform.image_yscale=2
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2752,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=160
      {
        newPlatform=instance_create(2960,-320,oS6FallPlatform)
        newPlatform.image_xscale=2; newPlatform.image_yscale=20
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(2912,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=270
      {
        newPlatform=instance_create(3392,-32,oS6FallPlatform)
        newPlatform.image_xscale=4; newPlatform.image_yscale=2
        newPlatform.bStartOn=1; newPlatform.newTime=1
        newMeteor=instance_create(3344,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      //else if progTime=310
      else if progTime>=310 //60fps change: >=, so the room still goes on if the frame rate changed mid-count (the same at 30fps)
      {
        newPlatform=instance_create(2064,-32,oS6FallPlatform)
        newPlatform.image_xscale=62; newPlatform.image_yscale=2
        newPlatform.bStartOn=1; newPlatform.newTime=1; newPlatform.newDrawX=1536
        progTime=0
        roomProgress+=1
      }
    }
    else if roomProgress=5 and oPlayer1.x>=3232
    {
      var tMeteorX; tMeteorX=3264
      for(i=0;i<3;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=260+(i*10)
        newMeteor.newSpd=0
        tMeteorX+=64
      }
      roomProgress+=1
    }
    else if roomProgress=6 and oPlayer1.x>=4288
    {
      newMeteor=instance_create(4416,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=0
      roomProgress+=1
    }
    else if roomProgress=7 and oPlayer1.x>=4784
    {
      newMeteor=instance_create(5056,-32,oS6Meteor)
      newMeteor.direction=260
      newMeteor.newSpd=3
      roomProgress+=1
    }
    else if roomProgress=8 and oPlayer1.x>=5248
    {
      var tMeteorX; tMeteorX=5312
      for(i=0;i<3;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=250+(i*20)
        newMeteor.newSpd=4
        tMeteorX+=32
      }
      roomProgress+=1
    }
    else if roomProgress=9 and oPlayer1.x>=6080
    {
      if deathWallX<5792
        deathWallX=5792
      roomProgress+=1
    }
    else if roomProgress=10 and deathWallX>=7104
    {
      dwMinSpd=5
      roomProgress+=1
    }

    if roomProgress>=10 //meteor shower
    {
      //meteorTime+=1
      meteorTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      if meteorTime>=4
      {
        newMeteor=instance_create(oPlayer1.x-288+random(576),-32,oS6Meteor)
        newMeteor.direction=random_range(240,300)
        newMeteor.newSpd=0
        meteorTime=0
      }
    }
  }
  else if (room=rFinal_aFleetA or room=rFinal_aFleetB or room=rFinal_aFleetC) and global.gamePaused=false //autoscroll
  {
    //60fps change: the autoscroll, its bobbing and the clouds are per 30fps tick
    if autoScroll.x<room_width-256
      //autoScroll.x+=xScrollSpd
      autoScroll.x+=xScrollSpd*gDeltaTime
    else
    {
      instance_deactivate_object(oM3Cannon)
      oM3FourShot.stopFiring=1
    }
    if autoScroll.x-(view_wview[0]/2)-20>oPlayer1.x
      oPlayer1.life-=oPlayer1.maxLife

    if yBobDown=0
    {
      //yScrollAmt+=0.018
      yScrollAmt+=0.018*gDeltaTime
      if yScrollAmt>=1
        yBobDown=1
    }
    else
    {
      //yScrollAmt-=0.018
      yScrollAmt-=0.018*gDeltaTime
      if yScrollAmt<=-1
        yBobDown=0
    }
    //autoScroll.y+=yScrollAmt
    autoScroll.y+=yScrollAmt*gDeltaTime

    //cloudTime+=1
    cloudTime+=1*gDeltaTime
    if cloudTime>=100
    {
      instance_create(view_xview[0]+512,random(room_height),oM3Cloud)
      cloudTime=irandom_range(0,50)
    }
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

if room=rFinal_a6_2
{
  for(i=0;i<12;i+=1)
  {
    draw_sprite(sS6Spike,image_index,deathWallX,i*32)
  }
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(255,108,0))
  draw_rectangle(0,0,deathWallX,room_height,0)
}
