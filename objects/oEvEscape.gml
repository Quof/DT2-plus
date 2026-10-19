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

if room=rFinal_EscapeA
{
  roomProgress=0
  progTime=0
  musicChk=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rFinal_EscapeA //Final Level intro
{
  if global.gameProgress<=32
  {
    //60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime). One-time things keep their checks (they land on the
    //tick's last frame), except ones that start something done every tick, which happen on the tick's first frame
    //(=N-1+gDeltaTime, e.g. =1*gDeltaTime on the scene's first frame). Something done every tick from tick N on (or in
    //ticks N-M) starts right after tick N-1 (>N-1), so it runs on all of tick N's frames and adds up as at 30fps. Spawns
    //and the sound system's whole-number volume steps happen once per tick (gDeltaDoTicks). All the same as before at 30fps.
    if sceneProgress=0
    {
      //sceneDelay+=1
      //if sceneDelay=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1*gDeltaTime
      {
        global.currentBoss="Chaser"
        global.gamePaused=true
      }
      else if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate("What is this?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate("This path will lead you out of this place.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("What about " +string(global.mainCharacters[0]) +string("?"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Don't worry about him, he'll be fine.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=5
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
      if sceneDelay=10
      {
        var tempMplay;
        tempMplay=findMusic()
        playMusic(tempMplay,0)
        musicChk=1
        chaser=instance_create(48,240,oChaserVirus)
        effect_create_above(ef_ring,chaser.x,chaser.y,1,c_blue)
      }
      else if sceneDelay=15
        oPlayer1.image_xscale=-1
      else if sceneDelay>=40
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("Escape is impossible.",1,oMessageCutscene,"Virus")
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("What is that?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("It's a chaser, don't try to fight it, just keep running.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("He's right, I'll take care of it.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate(global.mainCharacters[0] +string("?"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("Trust me.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("Okay.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=13
    {
      sceneProgress=0
      if musicChk=0
      {
        var tempMplay;
        tempMplay=findMusic()
        playMusic(tempMplay,0)
      }
      if global.gameProgress<=32
        global.gameProgress=33
      global.gamePaused=false
    }
  }
  else if global.gameProgress=33 //Horror Virus grows
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=6560
      {
        viewFix=instance_create(6496,0,oMisc)
        viewFix.sprite_index=sNull; viewFix.type=1
        view_object[0]=viewFix
        barrier=instance_create(6224,32,oBossBarrier); barrier.image_yscale=4.5
        msgCreate("Oh come on! It's a dead end...",0,oMessagePerson,global.mainCharacters[3])
        newMessage.fadingTime=70
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see gameProgress<=32's sceneProgress 0
      if sceneDelay>=120
      {
        oChaserVirus.eventProg=1
        sceneDelay=0
        sceneProgress+=1
      }
    }
  }
  else if global.gameProgress>=34 and global.gameProgress<=35 //Jerry saves Claire
  {
    if sceneProgress=1
    {
      global.gameProgress=35
      oIdentifier.emoteType=oIdentifier.EM_EXCITE
      sceneDelay=0
      sceneProgress+=1
    }
    else if sceneProgress=2
    {
      //sceneDelay+=1
      //if sceneDelay=1 //Spawn Jerry
      //60fps change: see gameProgress<=32's sceneProgress 0 (the flights below are per 30fps tick)
      sceneDelay+=1*gDeltaTime
      if sceneDelay=1*gDeltaTime //Spawn Jerry
      {
        npcJerry=instance_create(view_xview[0]-32,oHorrorVirus.y,oMisc)
        npcJerry.sprite_index=sJerryAirDash
        npcJerry.image_speed=0.5
        npcJerry.type=3
      }
      //else if sceneDelay>=2 and sceneDelay<500 //Jerry flies in and destroys the Core
      else if sceneDelay>1 and sceneDelay<500 //Jerry flies in and destroys the Core
      {
        //npcJerry.x+=16
        npcJerry.x+=16*gDeltaTime
        if npcJerry.x>=oHorrorVirus.x
        {
          var tEffect;
          tEffect=instance_create(oHorrorVirus.x,oHorrorVirus.y,oEffect)
          tEffect.sprite_index=sBomberExplosion
          sceneDelay=1000
        }
      }
      else if sceneDelay>=1000 and sceneDelay<2000 //Jerry lands and poses
      {
        //npcJerry.x+=16
        npcJerry.x+=16*gDeltaTime
        if npcJerry.x>=6480
        {
          npcJerry.sprite_index=sJerryJumpForward
          sceneDelay=2000
        }
      }
      else if sceneDelay>=2000 //Jerry lands and poses
      {
        //npcJerry.y+=8
        npcJerry.y+=8*gDeltaTime
        if npcJerry.y>=320
        {
          npcJerry.y=320
          npcJerry.sprite_index=sJerryKneel
          npcJerry.type=0
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=3
    {
      //sceneDelay+=1
      //if sceneDelay>=30 //Blow up Horror Virus
      sceneDelay+=1*gDeltaTime //60fps change: see gameProgress<=32's sceneProgress 0
      if sceneDelay>29 //Blow up Horror Virus
      {
        var tEffect;
        if gDeltaDoTicks //60fps change: one explosion per 30fps tick
        {
          tEffect=instance_create(oHorrorVirus.x-24+random(48),oHorrorVirus.y-24+random(48),oEffect)
          tEffect.sprite_index=sRobotExplosion
        }

        //if sceneDelay>=90
        if sceneDelay>89 //60fps change: see above
        {
          if fadeAlpha<1
            //fadeAlpha+=0.05
            fadeAlpha+=0.05*gDeltaTime
          else if fadeAlpha>=1
          {
            global.gamePaused=true
            stopPlayer()
            xVel=0; yVel=0
            oPlayer1.life=oPlayer1.maxLife
            oPlayer1.image_alpha=1
            oPlayer1.sprite_index=sPlayerIdle
            oPlayer1.image_xscale=-1
            oPlayer1.x=6544
            oPlayer1.y=320

            with oVH_BackExtend {instance_destroy()}
            with oEProjectileBase {instance_destroy()}
            with oEnemyBase {instance_destroy()}
            tile_layer_hide(9)

            sceneDelay=0
            sceneProgress+=1
          }
        }
      }
    }
    else if sceneProgress=4
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see gameProgress<=32's sceneProgress 0
      if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=5
    {
      if fadeAlpha>0
        //fadeAlpha-=0.05
        fadeAlpha-=0.05*gDeltaTime //60fps change: per 30fps tick
      else if fadeAlpha<=0
        sceneProgress+=1
    }
    else if sceneProgress=6
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see gameProgress<=32's sceneProgress 0
      if sceneDelay>=25
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("Hell yeah!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=8
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: see gameProgress<=32's sceneProgress 0
      if sceneDelay=10 //Jerry stands
      {
        npcJerry.sprite_index=sJerryIdle
        npcJerry.image_speed=0.1
        npcJerry.image_xscale=1
      }
      else if sceneDelay>=40 //Jerry lands and poses
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=9 //fade music
    {
      //sceneDelay+=1
      //if sceneDelay>=1 and sceneDelay<=50
      //  fadeVolume(global.msc_LurkingEvil,100)
      //else if sceneDelay>=51 and sceneDelay<=76
      //  fadeVolume(global.msc_LurkingEvil,200)
      //60fps change: see gameProgress<=32's sceneProgress 0 (the volume steps once per 30fps tick)
      sceneDelay+=1*gDeltaTime
      if sceneDelay>0 and sceneDelay<=50
        {if gDeltaDoTicks {fadeVolume(global.msc_LurkingEvil,100)}}
      else if sceneDelay>50 and sceneDelay<=76
        {if gDeltaDoTicks {fadeVolume(global.msc_LurkingEvil,200)}}
      else if sceneDelay>=80
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("Do you always have to pose?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("You know it's hot.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("Right...",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("So " +string(global.mainCharacters[1]) +string(", what's going on?#Did we manage to stop it?"),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("I think so, all virus activity has stopped here.#If that's the case, I should be able to get The Darkness running properly again.#Some things still don't look completely right,#but it takes some time to restore the system to the proper state.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("Awesome, then we saved the day again! And with your help " +string(global.mainCharacters[3]) +string(".#We couldn't have done it without you."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate("Yay! It was getting scary for a moment.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("I hate to admit it, but we make a good team...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate("You know " +string(global.mainCharacters[3]) +string("...#I've been meaning to ask you something..."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate("Wait, something is not right.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate("Well I know being asked out inside a computer simulation is probably#not what you had in mind but I...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("No... look over there.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=22
    {
      //sceneDelay+=1
      //if sceneDelay=5
      //60fps change: see gameProgress<=32's sceneProgress 0 (Claire starts running on tick 5's first frame, so she's
      //walking before she moves)
      sceneDelay+=1*gDeltaTime
      if sceneDelay=4+gDeltaTime
      {
        msgCreate("What?",0,oMessagePerson,global.mainCharacters[0])
        newMessage.fadingTime=50
        oPlayer1.image_xscale=1
        oPlayer1.sprite_index=sPlayerWalk
        oPlayer1.image_speed=0.5
        fadeColor=c_black
      }
      //if sceneDelay>=5 and sceneDelay<1000 //Claire runs off screen
      if sceneDelay>4 and sceneDelay<1000 //Claire runs off screen
      {
        //oPlayer1.x+=7.5
        oPlayer1.x+=7.5*gDeltaTime //60fps change: per 30fps tick
        if oPlayer1.x>npcJerry.x
        {
          npcJerry.image_xscale=1
          //fadeAlpha+=0.02
          fadeAlpha+=0.02*gDeltaTime
          if oPlayer1.x>room_width
          {
            if npcJerry.sprite_index=sJerryIdle
            {
              npcJerry.sprite_index=sJerryWalk
              npcJerry.image_speed=0.5
            }
            //npcJerry.x+=7
            npcJerry.x+=7*gDeltaTime
            if fadeAlpha>=1
              sceneDelay=1000
          }
        }
      }
      else if sceneDelay>=1030
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=23
    {
      stopAllMusic()
      global.gamePaused=true
      global.currentBoss=""
      room_goto(rEndA)
    }
  }
}
keyWaitForInput()

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if room=rFinal_EscapeA
  {
    if global.gameProgress<=32
    {
      fadeAlpha=0
      sceneDelay=0
      bWaitForInput=false
      if !instance_exists(oChaserVirus)
        chaser=instance_create(48,240,oChaserVirus)
      with oMessageCutscene
        instance_destroy()
      sceneProgress=13
    }
    else if global.gameProgress=35
    {
      fadeAlpha=1
      sceneDelay=0
      bWaitForInput=false
      with oChaserVirus
        instance_destroy()
      with oMessageCutscene
        instance_destroy()
      sceneProgress=23
    }
  }
}

//---------- LEVEL EVENTS ----------
if global.gamePaused=false
{
  if room=rFinal_EscapeA
  {
    //-------------------- Meteors falling --------------------
    if roomProgress=0 and oPlayer1.x>=496
    {
      var tMeteorX; tMeteorX=560
      for(i=0;i<3;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=250+(i*20)
        newMeteor.newSpd=5
        tMeteorX+=64
      }
      roomProgress+=1
    }
    else if roomProgress=1 and oPlayer1.x>=768
    {
      var tMeteorX; tMeteorX=784
      for(i=0;i<5;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=250+(i*10)
        newMeteor.newSpd=3
        tMeteorX+=64
      }
      roomProgress+=1
    }
    else if roomProgress=2 and oPlayer1.x>=1536
    {
      var tMeteorX; tMeteorX=1600
      for(i=0;i<5;i+=1)
      {
        newMeteor=instance_create(tMeteorX,-32,oS6Meteor)
        newMeteor.direction=270+(i*10)
        newMeteor.newSpd=3
        tMeteorX+=48
      }
      roomProgress+=1
    }
    else if roomProgress=3 and oPlayer1.x>=3344
    {
      newMeteor=instance_create(3440,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=4
      newMeteor=instance_create(3536,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=3.5
      newMeteor=instance_create(3632,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=3
      newMeteor=instance_create(3728,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=2.5
      roomProgress+=1
    }
    else if roomProgress=4 and oPlayer1.x>=4000
    {
      newMeteor=instance_create(4064,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=4
      roomProgress+=1
    }
    else if roomProgress=5
    {
      //progTime+=1
      progTime+=1*gDeltaTime //60fps change: counts 30fps ticks (lands on each multiple of 15)
      if progTime=15
      {
        newMeteor=instance_create(4160,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=30
      {
        newMeteor=instance_create(4256,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=45
      {
        newMeteor=instance_create(4352,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=60
      {
        newMeteor=instance_create(4448,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=75
      {
        newMeteor=instance_create(4544,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=90
      {
        newMeteor=instance_create(4640,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=105
      {
        newMeteor=instance_create(4736,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=120
      {
        newMeteor=instance_create(4832,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=135
      {
        newMeteor=instance_create(4928,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=150
      {
        newMeteor=instance_create(5024,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
      }
      else if progTime=165
      {
        newMeteor=instance_create(5120,-32,oS6Meteor)
        newMeteor.direction=270
        newMeteor.newSpd=0
        roomProgress+=1
      }
    }
    else if roomProgress=6 and oPlayer1.x>=5312
    {
      newMeteor=instance_create(5472,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=3
      newMeteor=instance_create(5632,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=2.5
      newMeteor=instance_create(5808,-32,oS6Meteor)
      newMeteor.direction=275
      newMeteor.newSpd=2
      roomProgress+=1
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
