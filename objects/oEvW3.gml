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

if global.lvlCurrent="3-2"
{
  sandBallTime=0
}
else if global.lvlCurrent="3-3"
  bStarted=0
else if global.lvlCurrent="3-B"
{
  teleportTime=0
  teleView=0
  enFire=instance_create(160,264,oMisc)
  enFire.sprite_index=sFBloomIdle
  enFire.image_speed=0.16
  enFire.image_alpha=0
  enFire.type=1
  enWater=instance_create(544,264,oMisc)
  enWater.sprite_index=sWBloomIdle
  enWater.image_xscale=-1
  enWater.image_speed=0.16
  enWater.image_alpha=0
  enWater.type=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: sceneDelay and teleportTime count 30fps ticks (+=1*gDeltaTime). One-time things keep their checks
//(they land on the tick's last frame), except a scene's start (=1*gDeltaTime, its first frame); counts that end a scene
//use >= (the same as = at 30fps), so they still end if the frame rate changed mid-count. Something done every tick from
//tick N on (or in ticks N-M) starts right after tick N-1 (>N-1), so it runs on all of tick N's frames and adds up as at
//30fps. Fades and cutscene moves are per 30fps tick.
if global.lvlCurrent="3-B"
{
  if global.bossTrack=0 //Boss Fight (Twin Bloom)
  {
    if sceneProgress=0
    {
      global.gamePaused=true
      stopPlayer()
      oPlayer1.sprite_index=sPlayerWalk
      oPlayer1.image_speed=0.5
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      //oPlayer1.x+=8
      sceneDelay+=1*gDeltaTime
      oPlayer1.x+=8*gDeltaTime
      if sceneDelay>=20
      {
        oPlayer1.sprite_index=sPlayerIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      //if sceneDelay>=20
      //{
      //  teleportTime+=1
      if sceneDelay>19
      {
        teleportTime+=1*gDeltaTime
        if teleportTime>=75
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("They're hostile.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("I figured as much.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=5
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      //if sceneDelay=3
      if sceneDelay>=3
      {
        teleportTime=0
        teleView=0
        with oMisc
          instance_destroy()
        global.bossTrack=1
        boss=instance_create(0,0,oTwinBloom)
        sceneDelay=0
        sceneProgress=0
        global.currentBoss="Twin Bloom"
        var tempMplay;
        tempMplay=findMusic()
        playMusic(tempMplay,0)
        global.gamePaused=false
      }
    }
  }
  else if global.bossTrack=1 //boss fight ends (Twin Bloom)
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
        oPlayer1.x=208
        oPlayer1.y=305
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
      msgCreate("This is getting harder.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("But you were able to do it.#And 'he' was watching the whole time.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(global.mainCharacters[0] +string(" was watching?"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("Mhmm.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("And do you know how hard it was for me to not step in?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=10
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=20
      {
        oIdentifier.emoteType=oIdentifier.EM_EXCITE
        effect=instance_create(272,273,oEffect)
        effect.sprite_index=sBomberExplosion
        effect.image_xscale=2
        effect.image_yscale=2
        effect.image_alpha=0.65
        charJerry=instance_create(272,297,oMisc)
        charJerry.sprite_index=sJerryDamaged
        charJerry.image_speed=0.1
        charJerry.image_xscale=-1
        charJerry.type=1
      }
      //else if sceneDelay>=21 and sceneDelay<=24
      //  charJerry.y+=2
      else if sceneDelay>20 and sceneDelay<=24
        charJerry.y+=2*gDeltaTime
      else if sceneDelay=25
        charJerry.sprite_index=sJerryGetUp
      else if sceneDelay>=45
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("Are you okay " +string(global.mainCharacters[0]) +string("?"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("Yeah, " +string(global.mainCharacters[1]) +string(" just brought me here in a weird way."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("Where is he?",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("Keeping an eye on things.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("Oh, that's good.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=16
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=20
        charJerry.sprite_index=sJerryIdle
      else if sceneDelay>=22
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("Hold it!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=18
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      //if sceneDelay>=1 and sceneDelay<=8
      if sceneDelay>0 and sceneDelay<=8
      {
        //if sceneDelay=1
        if sceneDelay=1*gDeltaTime
        {
          oPlayer1.sprite_index=sPlayerWalk
          oPlayer1.image_speed=0.5
        }
        //oPlayer1.x+=5
        oPlayer1.x+=5*gDeltaTime
      }
      else if sceneDelay=9
      {
        oPlayer1.sprite_index=sPlayerCasting
        oPlayer1.image_speed=0
        charJerry.sprite_index=sJerryGetUp
        charJerry.x+=4
      }
      //else if sceneDelay=14
      else if sceneDelay>=14
      {
        oPlayer1.sprite_index=sPlayerIdle
        oPlayer1.image_speed=0.1
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate("What the hell?!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate("What the hell indeed! Why are you following me?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("A bit big headed aren't we? I wasn't following you.#We took a wrong turn and found this place.#" +string(global.mainCharacters[1]) +string(" picked up your signal and now here we are."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate("So you just watched?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate("You had it handled. I'm sure you would have just been pissed if I butted in.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate("Yeah well... thanks.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate("For what?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=26 and bWaitForInput=false
      msgCreate("For believing I could do it.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=27 and bWaitForInput=false
      msgCreate("I was just waiting for you to mess up.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=28 and bWaitForInput=false
    {
      oIdentifier.emoteType=oIdentifier.EM_MAD
      msgCreate("You are such an ASS!",1,oMessageCutscene,global.mainCharacters[3])
    }
    else if sceneProgress=29 and bWaitForInput=false
      msgCreate("Well yeah, but anyway, I came to tell you that Jeremy found the#source of the disturbances... well the location anyway.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=30 and bWaitForInput=false
      msgCreate("Yay!",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=31 and bWaitForInput=false
      msgCreate("It's at the northern part of this island.#We could go straight through the middle, but Jeremy#said something about those things in the desert roaming around that area too.#Which... we really don't want to mess around with those.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=32 and bWaitForInput=false
      msgCreate("Tell me about it.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=33 and bWaitForInput=false
      msgCreate("I guess you saw them as well.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=34 and bWaitForInput=false
      msgCreate("You can't miss them!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=35 and bWaitForInput=false
      msgCreate("Well anyway, we're heading north-east around that area.#I suggest if you want to find the source as well, you go the same way.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=36 and bWaitForInput=false
      msgCreate("And work together?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=37 and bWaitForInput=false
      msgCreate("Sorta... the path splits off again.#How about " +string(global.mainCharacters[1]) +string(" and I take one way, and you two take the other?#Lets meet up where the path crosses again."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=38 and bWaitForInput=false
      msgCreate("That sounds like a fair plan. I'd rather us not work together directly.#We would just get in each other's way.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=39 and bWaitForInput=false
      msgCreate("Agreed...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=40
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay>=20
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=41 and bWaitForInput=false
      msgCreate("What?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=42 and bWaitForInput=false
      msgCreate("You going to let me up?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=43 and bWaitForInput=false
      msgCreate("No, " +string(global.mainCharacters[4]) +string(" and I are leaving first."),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=44 and bWaitForInput=false
      msgCreate("Whatever, just go.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=45 and bWaitForInput=false
      msgCreate("Plan on it!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=46 and bWaitForInput=false
      msgCreate(global.mainCharacters[4] +string(", I'll tell ") +string(global.mainCharacters[1]) +string(" you said hi."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=47 and bWaitForInput=false
      msgCreate("Thanks " +string(global.mainCharacters[0]) +string("."),1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=48
    {
      fadeColor=c_black
      if fadeAlpha<1
        //fadeAlpha+=0.02
        fadeAlpha+=0.02*gDeltaTime
      else if fadeAlpha>=1
      {
        if global.lvlComplete[10]=0 {sceneProgress+=1}
        else {sceneProgress=50}
      }
    }
    else if sceneProgress=49 and bWaitForInput=false
    msgCreate("BONUS CHALLENGE UNLOCKED!!",1,oMessageCutscene,"")
    else if sceneProgress=50
    {
      global.saveOnAuto=1
      if global.gameProgress<3
        global.gameProgress=3
      global.lvlComplete[10]=1
      if global.levelTimeFrameCount<global.lvlTime[10]
        global.lvlTime[10]=global.levelTimeFrameCount
      else if global.lvlTime[10]=0
        global.lvlTime[10]=global.levelTimeFrameCount
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
      with oMessageCutscene
        instance_destroy()
      oPlayer1.x=272
      fadeAlpha=0
      sceneProgress=5
    }
    else if global.bossTrack=2 and sceneProgress<48
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=48
    }
  }
}

//---------- LEVEL EVENTS ----------
if global.gamePaused=false
{
  if global.lvlCurrent="3-1"
  {
    if oPlayer1.y>=286 and !instance_exists(oSandCrawler)
      instance_create(oPlayer1.x,298,oSandCrawler)
  }
  else if global.lvlCurrent="3-2"
  {
    //sandBallTime+=1
    sandBallTime+=1*gDeltaTime //60fps change: counts 30fps ticks ("mod 90=0" is only true on whole numbers)
    if room=r3_2a1
    {
      if sandBallTime mod 90=0
      {
        instance_create(624,-8,oSandBall)
        instance_create(880,-8,oSandBall)
        instance_create(1536,-8,oSandBall)
        instance_create(1728,-8,oSandBall)
      }

      if sandBallTime mod 90=0
      {
        for(i=0;i<4;i+=1)
          instance_create(2096+(i*64),-8,oSandBall)
      }

      if sandBallTime mod 25=0
      {
        for(i=0;i<5;i+=1)
          instance_create(2512+(i*128),-8,oSandBall)
      }
    }
  }
  else if global.lvlCurrent="3-3"
  {
    if room=r3_3a1
    {
      if oPlatformTouch.x>=3856
        oPlatformTouch.xVel=0
    }
    else if room=r3_3a2 //make platforms appear
    {
      //instance id fix: (341805) is the platform the player rides up, by its id in the original game: GID(341805) here
      //and in the Draw event
      view_object[0]=noone
      //view_yview[0]=(341805).y-240
      view_yview[0]=(GID(341805)).y-240
      if bStarted=0
      {
        //if (341805).moving=true
        if (GID(341805)).moving=true
        {
          newPlatform[0]=instance_create(48,4016,oPlatformTouch)
          newPlatform[0].sprite_index=sInvisibleSolidMask
          newPlatform[0].yVel=-2
          newPlatform[0].spriteChange=1
          newPlatform[0].image_xscale=6
          newPlatform[0].moving=1
          newPlatform[1]=instance_create(368,4016,oPlatformTouch)
          newPlatform[1].sprite_index=sInvisibleSolidMask
          newPlatform[1].yVel=-2
          newPlatform[1].spriteChange=1
          newPlatform[1].image_xscale=6
          newPlatform[1].moving=1
          bStarted=1
        }
      }

      //if (341805).y<=240
      if (GID(341805)).y<=240
      {
        //(341805).yVel=0
        (GID(341805)).yVel=0
        newPlatform[0].yVel=0
        newPlatform[1].yVel=0
      }
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

if global.lvlCurrent="3-3"
{
  if room=r3_3a2
  {
    for(i=0;i<32;i+=1)
    {
      //draw_sprite(sStaticSpike,0,i*16,(341805).y+128)
      draw_sprite(sStaticSpike,0,i*16,(GID(341805)).y+128) //instance id fix: see the Step event
    }
    //if oPlayer1.y>=(341805).y+128
    if oPlayer1.y>=(GID(341805)).y+128 //instance id fix: see the Step event
    {
      oPlayer1.life-=oPlayer1.maxLife
    }
  }
}
else if global.lvlCurrent="3-B"
{
  //if teleportTime>=1 and teleportTime<=15
  //  teleView+=1.5
  //else if teleportTime>=21 and teleportTime<=40
  //{
  //  enFire.y+=2
  //  enFire.image_alpha+=0.05
  //  enWater.y+=2
  //  enWater.image_alpha+=0.05
  //}
  //else if teleportTime>=51 and teleportTime<=65
  //  teleView-=1.5
  //60fps change: per 30fps tick, in the ticks teleportTime counts (see Step)
  if teleportTime>0 and teleportTime<=15
    teleView+=1.5*gDeltaTime
  else if teleportTime>20 and teleportTime<=40
  {
    enFire.y+=2*gDeltaTime
    enFire.image_alpha+=0.05*gDeltaTime
    enWater.y+=2*gDeltaTime
    enWater.image_alpha+=0.05*gDeltaTime
  }
  else if teleportTime>50 and teleportTime<=65
    teleView-=1.5*gDeltaTime

  if teleView>0
  {
    draw_set_alpha(0.3)
    draw_set_color(c_red)
    draw_rectangle(enFire.x-teleView,0,enFire.x+teleView,304,0)
    draw_rectangle(enWater.x-teleView,0,enWater.x+teleView,304,0)
  }
}
