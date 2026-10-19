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

if global.lvlCurrent="4-1"
{
  bgEffectTime=0
  if room=r4_1a1
  {
    tetPieceDelay=72
    tetPieceSpd=1
  }
  else if room=r4_1a2
  {
    tetPieceDelay=60
    tetPieceSpd=2
  }
  tetPieceTime=tetPieceDelay
  tetPieceProg=0
}
else if global.lvlCurrent="4-B"
{
  if global.bossTrack=0
  {
    npcHarpuia=instance_create(336,337,oMisc)
    npcHarpuia.sprite_index=sHarpuiaStandIdle
    npcHarpuia.image_xscale=-1
    npcHarpuia.type=1
    virusDir=0
    virusDist=96
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime). One-time things keep their checks (they land on the
//tick's last frame), except a scene's start (=1*gDeltaTime, its first frame); counts that end a scene use >= (or <= for
//virusDist, the same as = at 30fps), so they still end if the frame rate changed mid-count. Something done every tick
//from tick N on (or in ticks N-M) starts right after tick N-1 (>N-1), so it runs on all of tick N's frames and adds up
//as at 30fps. Fades, growths, spins and cutscene moves are per 30fps tick.
if global.lvlCurrent="4-1" //Harpuia first appearance
{
  if global.gameProgress<=3
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
      msgCreate("What is going on here?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("This area has been changed by something.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=4 //Harpuia appears
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=5
      {
        npcHarpuia=instance_create(480,3792,oMisc)
        npcHarpuia.sprite_index=sHarpuiaStandIdle
        npcHarpuia.image_xscale=-1
        npcHarpuia.image_alpha=0
        npcHarpuia.image_speed=0
        npcHarpuia.type=1
        effectTornado=instance_create(480,3792,oEffect)
        effectTornado.sprite_index=sHarpuiaTornado
        effectTornado.image_speed=0.4
        effectTornado.image_xscale=0.5
        effectTornado.image_yscale=0.5
        effectTornado.decay=100000
        effectTornado.newBlend=1
      }
      //else if sceneDelay>=6
      else if sceneDelay>5
      {
        if effectTornado.image_yscale<1
          //effectTornado.image_yscale+=0.02
          effectTornado.image_yscale+=0.02*gDeltaTime

        if effectTornado.image_xscale<1
          //effectTornado.image_xscale+=0.04
          effectTornado.image_xscale+=0.04*gDeltaTime
        else if effectTornado.image_xscale>=1
        {
          //effectTornado.image_xscale+=0.35
          effectTornado.image_xscale+=0.35*gDeltaTime

          //npcHarpuia.image_alpha+=0.05
          npcHarpuia.image_alpha+=0.05*gDeltaTime
          if npcHarpuia.image_alpha>=0.75
          {
            //effectTornado.image_alpha-=0.1
            effectTornado.image_alpha-=0.1*gDeltaTime
            if effectTornado.image_alpha<=0
            {
              sceneDelay=0
              sceneProgress+=1
            }
          }
        }
      }
    }
    else if sceneProgress=5 //Harpuia intro animation
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=10
      {
        npcHarpuia.sprite_index=sHarpuiaIntro
        npcHarpuia.image_speed=0.2
      }
      //else if sceneDelay>=11 and sceneDelay<900
      else if sceneDelay>10 and sceneDelay<900
      {
        if npcHarpuia.image_index>=5.6
        {
          npcHarpuia.sprite_index=sHarpuiaStandReady
          npcHarpuia.image_speed=0
          sceneDelay=1000
        }
      }
      else if sceneDelay=1005
        npcHarpuia.sprite_index=sHarpuiaFly
      else if sceneDelay>=1020
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("Turn back!",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("Ugh, why do guys always do this to me?!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate("Turn back now and you can still be quarantined.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("Huh? Do you have any idea what he's talking about?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("No.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("If you do not wish to be deleted, you will turn away.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=12
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      //if sceneDelay>=10
      if sceneDelay>9
      {
        //npcHarpuia.image_alpha-=0.05
        npcHarpuia.image_alpha-=0.05*gDeltaTime
        if npcHarpuia.image_alpha<=0
        {
          with oMisc
            instance_destroy()
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("What was that about?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("Just a warning.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("Ignore it, we're moving on.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=16
    {
      sceneProgress=0
      if global.gameProgress<4
        global.gameProgress=4
      global.gamePaused=false
    }
  }
}
else if global.lvlCurrent="4-2" //Explanation on color wheels
{
  if global.gameProgress<=4
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
      msgCreate("Hold on, I need to tell you about that spinning thingy.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("What is it?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("You need to watch it carefully. When it starts to spin quickly and give off#a color, you need to be within a field matching that color.#It gives 3 warnings before it sends out an undodgable shockwave.",1,oMessageCutscene,global.mainCharacters[4])
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate("Stay within matching colors, gotcha. Shouldn't be too hard.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6
    {
      sceneProgress=0
      if global.gameProgress<5
        global.gameProgress=5
      global.gamePaused=false
    }
  }
}
if global.lvlCurrent="4-B"
{
  if global.bossTrack=0 //Boss Fight (Harpuia)
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
      msgCreate("I warned you once already.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate("We're not stopping.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate("Then I will purge you here.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=5 //Harpuia intro animation
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=10
      {
        npcHarpuia.sprite_index=sHarpuiaIntro
        npcHarpuia.image_speed=0.2
        npcHarpuia.image_index=0
      }
      //else if sceneDelay>=11 and sceneDelay<900
      else if sceneDelay>10 and sceneDelay<900
      {
        if npcHarpuia.image_index>=5.6
        {
          npcHarpuia.sprite_index=sHarpuiaStandReady
          sceneDelay=1000
        }
      }
      else if sceneDelay>=1020
      {
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("Proceeding any further is prohibited!",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=7
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=10
      {
        oIdentifier.emoteType=oIdentifier.EM_EXCITE
        effect=instance_create(224,313,oEffect)
        effect.sprite_index=sBomberExplosion
        effect.image_xscale=2
        effect.image_yscale=2
        effect.image_alpha=0.8
        charJerry=instance_create(224,337,oMisc)
        charJerry.type=1
        charJerry.sprite_index=sJerryKneel
        charJerry.image_speed=0.1
        charJerry.depth=35
      }
      else if sceneDelay>=30
      {
        charJerry.sprite_index=sJerryIdle
        sceneDelay=0
        sceneProgress+=1
      }
    }
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(global.mainCharacters[0] +string("?"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("Don't fight him.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("Huh?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("This is for your own protection. I'll handle this!#And please don't argue with me on this one.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("What's going on?",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate(global.mainCharacters[1] +string(" analyzed him. Most of his, or rather 'its', parameter IDs are hidden.#I'd rather you let me handle this."),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("Execute simple quarantine procedure.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=15
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=10 //create virus face image
      {
        imageVirus[0]=instance_create(room_width/2,room_height/2,oMisc)
        imageVirus[0].type=1
        imageVirus[0].sprite_index=sVirusFaceImage
        imageVirus[0].image_alpha=0
        imageVirus[0].image_xscale=3
        imageVirus[0].image_yscale=3
        imageVirus[1]=instance_create(room_width/2,room_height/2,oMisc)
        imageVirus[1].type=1
        imageVirus[1].sprite_index=sVirusFaceImage
        imageVirus[1].image_alpha=0
        imageVirus[1].image_xscale=5
        imageVirus[1].image_yscale=5
      }
      //else if sceneDelay>=11 and sceneDelay<600 //rotate virus face image
      else if sceneDelay>10 and sceneDelay<600 //rotate virus face image
      {
        if imageVirus[0].image_alpha<0.5
          //imageVirus[0].image_alpha+=0.01
          imageVirus[0].image_alpha+=0.01*gDeltaTime
        //imageVirus[0].image_angle+=1
        imageVirus[0].image_angle+=1*gDeltaTime
        if imageVirus[1].image_alpha<0.3
          //imageVirus[1].image_alpha+=0.005
          imageVirus[1].image_alpha+=0.005*gDeltaTime
        //imageVirus[1].image_angle-=0.5
        imageVirus[1].image_angle-=0.5*gDeltaTime
      }

      if sceneDelay=60 //create virus spikes
      {
        var virusTempDir;
        virusTempDir=0
        for(i=0;i<6;i+=1)
        {
          spikeVirus[i]=instance_create(room_width/2,room_height/2,oMisc)
          spikeVirus[i].type=1
          spikeVirus[i].sprite_index=sVirusSpikeIdle
          spikeVirus[i].x=charJerry.x+lengthdir_x(virusDist,virusDir+virusTempDir)
          spikeVirus[i].y=charJerry.y-22+lengthdir_y(virusDist,virusDir+virusTempDir)
          spikeVirus[i].image_speed=0.33
          virusTempDir+=360/6
        }
      }
      //else if sceneDelay>=61 and sceneDelay<600 //rotate virus spikes
      else if sceneDelay>60 and sceneDelay<600 //rotate virus spikes
      {
        //virusDir-=8
        virusDir-=8*gDeltaTime
        var virusTempDir;
        virusTempDir=0
        for(i=0;i<6;i+=1)
        {
          spikeVirus[i].x=charJerry.x+lengthdir_x(virusDist,virusDir+virusTempDir)
          spikeVirus[i].y=charJerry.y-22+lengthdir_y(virusDist,virusDir+virusTempDir)
          virusTempDir+=360/6
        }
        //if sceneDelay>=81 and sceneDelay<500 //move virus spikes inward
        if sceneDelay>80 and sceneDelay<500 //move virus spikes inward
        {
          //virusDist-=1
          //if virusDist=24
          virusDist-=1*gDeltaTime
          if virusDist<=24
          {
            charJerry.sprite_index=sJerryDamaged
            sceneDelay=500
          }
        }
      }

      //if sceneDelay>=501 and sceneDelay<=520 //move Jerry up
      //  charJerry.y-=2
      //else if sceneDelay>=530 and sceneDelay<600 //remove Jerry
      if sceneDelay>500 and sceneDelay<=520 //move Jerry up
        charJerry.y-=2*gDeltaTime
      else if sceneDelay>529 and sceneDelay<600 //remove Jerry
      {
        //virusDist-=1
        //if virusDist=0
        virusDist-=1*gDeltaTime
        if virusDist<=0
        {
          for(i=0;i<6;i+=1)
          {
            with spikeVirus[i]
              instance_destroy()
          }
          for(i=0;i<2;i+=1)
          {
            with imageVirus[i]
              instance_destroy()
          }
          with charJerry
            instance_destroy()
          fadeAlpha=1
          sceneDelay=800
        }
      }
      //else if sceneDelay>=820 //end
      else if sceneDelay>819 //end
      {
        if fadeAlpha>0
          //fadeAlpha-=0.05
          fadeAlpha-=0.05*gDeltaTime
        else if fadeAlpha<=0
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate("What did you do with " +string(global.mainCharacters[0]) +string("?!"),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("He's been quarantined, it did it quick and dirty,#so I can break him out pretty easy.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate("Plenty of time to purge the weaker one.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate("HEY!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate("I can offer you scan data if needed.#I've set up my info to link with " +string(global.mainCharacters[4]) +string("'s procedure."),1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("Enough of this chatter.#You won't free the other by the time I'm done with this one.",1,oMessageCutscene,"Harpuia")
    else if sceneProgress=22
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      //if sceneDelay=3
      if sceneDelay>=3
      {
        with oMisc
          instance_destroy()
        global.bossTrack=1
        boss=instance_create(336,337,oHarpuia)
        boss.activateBoss=1
        sceneDelay=0
        sceneProgress=0
        global.currentBoss="Harpuia"
        var tempMplay;
        tempMplay=findMusic()
        playMusic(tempMplay,0)
        global.gamePaused=false
      }
    }
  }
  else if global.bossTrack=1 //boss fight ends (Harpuia)
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
        with oEnemyAfterImage {instance_destroy()}
        oPlayer1.x=160
        oPlayer1.y=337
        oPlayer1.image_xscale=1
      }
      if sceneDelay>=60
      {
        oPlayer1.life=oPlayer1.maxLife
        charJerry=instance_create(240,337,oMisc)
        charJerry.type=1
        charJerry.sprite_index=sJerryIdle
        charJerry.image_xscale=-1
        charJerry.image_speed=0.1
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
      msgCreate("I see what you meant. I almost didn't make it.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate("You did great though.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate("... Thanks.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=8 and bWaitForInput=false
      msgCreate(global.mainCharacters[1] +string(", how are things looking from your end?"),1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=9 and bWaitForInput=false
      msgCreate("The place is blocked off from the ground.#There is no way we're getting through it.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=10 and bWaitForInput=false
      msgCreate("Does this mean... we have to use the skies?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=11 and bWaitForInput=false
      msgCreate("It certainly does.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=12 and bWaitForInput=false
      msgCreate("Damn it. I hate shooters!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=13 and bWaitForInput=false
      msgCreate("I know, but we have no choice.#Whatever this is, it knows we're coming now and is#trying to stop us.",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=14 and bWaitForInput=false
      msgCreate("... I could do it.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=15 and bWaitForInput=false
      msgCreate("You?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=16 and bWaitForInput=false
      msgCreate("I played shooters all the time in school.#I even held most of the high scores on leaderboards and in the arcades.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=17 and bWaitForInput=false
      msgCreate("Really?",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=18 and bWaitForInput=false
      msgCreate("Yes, I'm serious. Let me handle this, I can do it!",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=19 and bWaitForInput=false
      msgCreate("I never knew you were this much of a nerd before all this!#I mean I knew you played games, but still!",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=20 and bWaitForInput=false
      msgCreate("... Sigh.",1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=21 and bWaitForInput=false
      msgCreate("I know what you want to say... I was...",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=22 and bWaitForInput=false
      msgCreate("Stop " +string(global.mainCharacters[0]) +string(", we have more important things to do than for you to try and win#me back. Besides, it's good enough for me that you were actually about to#acknowleged that you were probably the worst boyfriend in the#history of boyfriends."),1,oMessageCutscene,global.mainCharacters[3])
    else if sceneProgress=23 and bWaitForInput=false
      msgCreate("Ouch, that wasn't quite what I was going to say.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=24 and bWaitForInput=false
      msgCreate("Boring! It's time to blow stuff up and kick some ass!",1,oMessageCutscene,global.mainCharacters[1])
    else if sceneProgress=25 and bWaitForInput=false
      msgCreate("Yeah, I really don't want to continue this conversation.",1,oMessageCutscene,global.mainCharacters[0])
    else if sceneProgress=26
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=20
      {
        oPlayer1.sprite_index=sPlayerDiscombobulate
        oPlayer1.image_index=1
        oPlayer1.image_speed=0
        charJerry.sprite_index=sPlayerDiscombobulate
        charJerry.image_index=1
        charJerry.image_speed=0
      }
      else if sceneDelay=21
      {
        oPlayer1.image_index=0
        charJerry.image_index=0
      }
      //else if sceneDelay>=22
      else if sceneDelay>21
      {
        if sceneDelay=32
          oIdentifier.emoteType=oIdentifier.EM_EXCITE
        //oPlayer1.y-=8
        //charJerry.y-=8
        oPlayer1.y-=8*gDeltaTime
        charJerry.y-=8*gDeltaTime
        if oPlayer1.y<=-8
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=27
    {
      fadeColor=c_black
      if fadeAlpha<1
        //fadeAlpha+=0.02
        fadeAlpha+=0.02*gDeltaTime
      else if fadeAlpha>=1
      {
        if global.lvlComplete[13]=0 {sceneProgress+=1}
        else {sceneProgress=29}
      }
    }
    else if sceneProgress=28 and bWaitForInput=false
    msgCreate("BONUS CHALLENGE UNLOCKED!!",1,oMessageCutscene,"")
    else if sceneProgress=29
    {
      global.saveOnAuto=1
      if global.gameProgress<6
        global.gameProgress=6
      global.lvlComplete[13]=1
      if global.levelTimeFrameCount<global.lvlTime[13]
        global.lvlTime[13]=global.levelTimeFrameCount
      else if global.lvlTime[13]=0
        global.lvlTime[13]=global.levelTimeFrameCount
      transition_steps=30
      transition_kind=20
      //room_goto(rWorldMap)
      room_goto_fixed(rWorldMap) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
    }
  }
}

keyWaitForInput()

//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if global.lvlCurrent="4-1"
  {
    if global.gameProgress<=3
    {
      sceneDelay=0
      bWaitForInput=false
      with oEffect
        instance_destroy()
      with oMisc
        instance_destroy()
      with oMessageCutscene
        instance_destroy()
      sceneProgress=16
    }
  }
  else if global.lvlCurrent="4-2"
  {
    if global.gameProgress<=4
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=6
    }
  }
  else if global.lvlCurrent="4-B"
  {
    if global.bossTrack=0
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      fadeAlpha=0
      sceneProgress=22
    }
    else if global.bossTrack=2 and sceneProgress<27
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=27
    }
  }
}

//---------- LEVEL EVENTS ----------
if global.gamePaused=false
{
  if global.lvlCurrent="4-1"
  {
    if room=r4_1a1
    {
      //bg effect
      //bgEffectTime+=1
      bgEffectTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      if bgEffectTime>=45
      {
        instance_create(irandom_range(96,room_width-96),-64,oBgEff_Tetris)
        bgEffectTime=irandom(4)
      }
      //tetris pieces
      /*tetPieceTime+=1
      if tetPieceTime>=tetPieceDelay
      {
        tetPieceProg+=1
        if tetPieceProg=4
          tetPieceProg=1

        if tetPieceProg=1
          xSpawn=irandom_range(96,288)
        else if tetPieceProg=2
          xSpawn=irandom_range(480,608)
        else if tetPieceProg=3
          xSpawn=irandom_range(288,480)

        tetrisBlock=instance_create(xSpawn,-64,oTetrisBlock)
        with tetrisBlock
        {
          ySpd=other.tetPieceSpd
          makeRandom=1
          move_snap(32,2)
        }
        tetPieceTime=0
      }*/
      //Diamond & Barrier
      //if instance_exists(344224)
      //{
      //  if !instance_exists((343087))
      //  {
      //    with (344224)
      //      instance_destroy()
      //  }
      //}
      //instance id fix: the barrier and the diamond by their ids in the original game (GID)
      if instance_exists(GID(344224))
      {
        if !instance_exists((GID(343087)))
        {
          with (GID(344224))
            instance_destroy()
        }
      }
    }
    else if room=r4_1a2
    {
      //bg effect
      //bgEffectTime+=1
      bgEffectTime+=1*gDeltaTime //60fps change: counts 30fps ticks
      if bgEffectTime>=50
      {
        for(i=0;i<12;i+=1)
        {
          instance_create(irandom_range(96,room_width-96),irandom_range(-128,-64),oBgEff_Tetris)
        }
        bgEffectTime=irandom(4)
      }
      //tetris pieces
      /*tetPieceTime+=1
      if tetPieceTime>=tetPieceDelay
      {
        tetPieceProg+=1
        if tetPieceProg=3
          tetPieceProg=1

        var xSpawn;
        if tetPieceProg=1
        {
          xSpawn=256
          for(i=0;i<10;i+=1)
          {
            tetrisBlock=instance_create(xSpawn,irandom_range(-128,-64),oTetrisBlock)
            with tetrisBlock
            {
              ySpd=other.tetPieceSpd
              makeRandom=1
              move_snap(32,2)
            }
            xSpawn+=384
          }
        }
        else if tetPieceProg=2
        {
          xSpawn=448
          for(i=0;i<9;i+=1)
          {
            tetrisBlock=instance_create(xSpawn,irandom_range(-128,-64),oTetrisBlock)
            with tetrisBlock
            {
              ySpd=other.tetPieceSpd
              makeRandom=1
              move_snap(32,2)
            }
            xSpawn+=384
          }
        }
        tetPieceTime=irandom(4)
      }*/
      //Diamond & Barrier
      //if instance_exists(343711)
      //{
      //  if !instance_exists((343710))
      //  {
      //    with (343711)
      //      instance_destroy()
      //  }
      //}
      //instance id fix: the barrier and the diamond by their ids in the original game (GID)
      if instance_exists(GID(343711))
      {
        if !instance_exists((GID(343710)))
        {
          with (GID(343711))
            instance_destroy()
        }
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
