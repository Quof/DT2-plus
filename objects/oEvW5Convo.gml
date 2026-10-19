#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if global.gameProgress<12 and room=rFinal_a2_2 //random dialogue
  {
    if sceneProgress=0
    {
      for (i=0;i<1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.y>=1856
    {
      oIdentifier.emoteType=oIdentifier.EM_IDEA
      msgCreate("Careful, you can't dash through those things.",0,oMessagePerson,global.mainCharacters[1],0,128,128)
      newMessage.fadingTime=135
      charDialogue[0]+=1
    }
  }
  else if global.gameProgress<14 and room=rFinal_a3_1 //random dialogue & Path Opener
  {
    if instance_exists(oEventBarrier)
    {
      if !instance_exists(oPathOpener)
      {
        global.gameProgress=14
        with oEventBarrier
          instance_destroy()
      }
    }
  }
  else if global.gameProgress<17 and room=rFinal_a5_1 //Path Opener
  {
    if instance_exists(oEventBarrier)
    {
      if !instance_exists(oPathOpener)
      {
        global.gameProgress=17
        msgCreate("Good job, only 1 more to unlock.",0,oMessagePerson,global.mainCharacters[1])
        newMessage.fadingTime=120
        with oEventBarrier
          instance_destroy()
      }
    }
  }
  else if global.gameProgress<21 and room=rFinal_a6_1 //Path Opener
  {
    if instance_exists(oEventBarrier)
    {
      if !instance_exists(oPathOpener)
      {
        global.gameProgress=21
        msgCreate("Just get to the end and you will find the one to#unlock the path we need.",0,oMessagePerson,global.mainCharacters[1])
        newMessage.fadingTime=150
        with oEventBarrier
          instance_destroy()
      }
    }
  }
  else if global.gameProgress<25 and room=rFinal_a6_3 //Final Path Opener
  {
    if instance_exists(oEventBarrier)
    {
      if !instance_exists(oPathOpener)
      {
        global.gameProgress=25
        msgCreate("And that's it. Just break through that fleet!",0,oMessagePerson,global.mainCharacters[1])
        newMessage.fadingTime=150
        with oEventBarrier
          instance_destroy()
      }
    }
  }
  else if global.gameProgress<27 and room=rFinal_aFleetA //You can stomp on anything Mario related
  {
    if sceneProgress=0
    {
      for (i=0;i<1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=20
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=1
    {
      msgCreate("You can stomp on anything Mario related now.",0,oMessagePerson,global.mainCharacters[1])
      newMessage.fadingTime=80
      charDialogue[0]+=1
    }
    else if charDialogue[0]=2
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=80
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=3
    {
      msgCreate("That would have been helpful a LONG time ago!",0,oMessagePerson,global.mainCharacters[0])
      newMessage.fadingTime=90
      charDialogue[0]+=1
    }
    else if charDialogue[0]=4
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=90
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=5
    {
      msgCreate(global.mainCharacters[0] +string("? Where are you?"),0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=60
      charDialogue[0]+=1
    }
    else if charDialogue[0]=6
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=60
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=7
    {
      msgCreate("Where " +string(global.mainCharacters[1]) +string(" sent me. I can see the communication channel with you.#I kept mine closed so the banter between me and " +string(global.mainCharacters[1])) +string(" didn't flood your view."),0,oMessagePerson,global.mainCharacters[0])
      newMessage.fadingTime=160
      charDialogue[0]+=1
    }
    else if charDialogue[0]=8
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=160
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=9
    {
      msgCreate("Like what's happening here?",0,oMessagePerson,global.mainCharacters[3])
      newMessage.fadingTime=70
      charDialogue[0]+=1
    }
    else if charDialogue[0]=10
    {
      //convo[0]+=1
      convo[0]+=1*gDeltaTime //60fps change: counts 30fps ticks (the waits match each message's fadingTime, also in ticks)
      if convo[0]>=70
      {
        convo[0]=0
        charDialogue[0]+=1
      }
    }
    else if charDialogue[0]=11
    {
      msgCreate("Yep!",0,oMessagePerson,global.mainCharacters[0])
      newMessage.fadingTime=60
      charDialogue[0]+=1
    }
  }
  else if room=rFinal_aFleetB //Lost dash function
  {
    if sceneProgress=0
    {
      for (i=0;i<1;i+=1)
      {
        charDialogue[i]=0
        convo[i]=0
      }
      sceneProgress+=1
    }
    if charDialogue[0]=0 and oPlayer1.x>=3024
    {
      msgCreate("Dang it. The virus is messing with things.#You've lost your dash function.#I'll try to get it back as fast as possible.",0,oMessagePerson,global.mainCharacters[1],0,1,128)
      newMessage.fadingTime=135
      charDialogue[0]+=1
    }
    else if charDialogue[0]=1
    {
      oPlayer1.dashRecoveryTime=0
      oPlayer1.dashPoints=0
    }
  }
  else if room=rFinal_EscapeA //random dialogue
  {
    if sceneProgress=0 and oPlayer1.x>=512
    {
      msgCreate("It is too late to stop me.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
    else if sceneProgress=1 and oPlayer1.x>=1216
    {
      msgCreate("You are merely slowing your demise.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
    else if sceneProgress=2 and oPlayer1.x>=2944
    {
      msgCreate("You cannot fight me.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
    else if sceneProgress=3 and oPlayer1.x>=3744
    {
      msgCreate("I have spread too far.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
    else if sceneProgress=4 and oPlayer1.x>=4096
    {
      msgCreate("All systems have been corrupt.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
    else if sceneProgress=5 and oPlayer1.x>=4832
    {
      msgCreate("Soon you will see.",0,oMessagePerson,"Virus")
      newMessage.fadingTime=70; sceneProgress+=1
    }
  }
}
