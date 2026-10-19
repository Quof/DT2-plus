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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room=rCutscene_1 //Going to level 1-2
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("Things get a bit harsher in this next bit.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Advancing walls of doom? Timers? Auto scroll with bats?#Genre savvy AI? The key boss?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Bullet Bills.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("That's it?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("Harsher terrain and Bullet Bills.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("I can wall jump, terrain doesn't matter.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("Guess we'll find out.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=10
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=11
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=1
      room_goto(r1_2a1)
    }
  }
}
else if room=rCutscene_2 //Going to level 1-3
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("Did your short-cut include this cave?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Not really. I didn't know this was here.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Should we try a different way?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("No, let's go in, the source of the disturbance is coming from this way.#There's a chance it's coming from inside the cave.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("Guess it can't be helped.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("And be alert. It looks like there are three strong entities inside.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("Are they all bots?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate("At least one of them is. I can't tell if the others are human or not.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=11
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=12
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=2
      room_goto(r1_3a1)
    }
  }
}
else if room=rCutscene_3 //Going to level 2-2
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("How far down does this place go?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Heck if I know. And watch your footing here, it's getting darker.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Is the signal close?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("Very close, though I can't help but feel this place is a trap of sorts.#It has me really uncomfortable.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("I'll be careful.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("You may want to hurry your pace. Something seems to be following you.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("Great...",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=10
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=11
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=3
      room_goto(r2_2a1)
    }
  }
}
else if room=rCutscene_4 //Going to level 3-2
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("What's this?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Go in. There's no safe places from that thing that's following you,#except through here.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Okay, if that's the best way to go...#Hold on, we're heading north now!",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("The signal seems to have moved north,#that's why I'm directing you there.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("So it's always a step ahead of us...",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("Not from what I see, its location jumps around.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("That's uh... special.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate("I feel as if something is just stalling for time.#Like it's trying to keep us busy.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=11 and bWaitForInput=false
    msgCreate("Well we're not going to figure it out if we stay here.#You're right, it would probably be safer to be inside;#Away from that thing.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=12
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=13
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=4
      room_goto(r3_2a1)
    }
  }
}
else if room=rCutscene_5 //Going to level 3-3
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("Further on ahead, there's an elevator. Let's check it out#and see if we can get a better view of the island from up there.#No guarantees on that though.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Better than nothing I guess.#I'm just glad to be away from that Sand Crawler thing.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=5
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=6
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=5
      room_goto(r3_3a1)
    }
  }
}
else if room=rCutscene_6 //Going to level 4-2
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    oPlayer1.sprite_index=sPlayerIdle
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=30
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2
  {
    if fadeAlpha>0
      //fadeAlpha-=0.04
      fadeAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha<=0
      sceneProgress+=1
  }
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("That seemed like something was actually trying to stop us from advancing.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("You feel it too then...#Before it seemed like something was just toying with us.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("Do you think your brother knows about this?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("They're probably going through the same troubles we are.#Whatever it is that's on this island knows we're here.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("Keep going?",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("Yes, we're getting very close and the source seems to have stopped#jumping around. The path ahead is going to be rough though.#These obstacles presented aren't going to be easy.",1,oMessageCutscene,global.mainCharacters[4])
  else if sceneProgress=9
  {
    if fadeAlpha<1
      //fadeAlpha+=0.05
      fadeAlpha+=0.05*gDeltaTime //60fps change: per 30fps tick
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=10
  {
    //sceneDelay+=1
    //if sceneDelay=3
    sceneDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if sceneDelay>=3 //60fps change: >=, so it still goes on if the frame rate changed mid-count (the same at 30fps)
    {
      global.gamePaused=false
      global.storyProgress=6
      room_goto(r4_2a1)
    }
  }
}

keyWaitForInput()

//if keyboard_check_pressed(ord("M")) //cutscene skip
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //cutscene skip //gamepad change: and the gamepad (scrGamepadInit)
{
  if room=rCutscene_1 and sceneProgress<10
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=10
  }
  else if room=rCutscene_2 and sceneProgress<11
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=11
  }
  else if room=rCutscene_3 and sceneProgress<10
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=10
  }
  else if room=rCutscene_4 and sceneProgress<12
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=12
  }
  else if room=rCutscene_5 and sceneProgress<5
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=5
  }
  else if room=rCutscene_6 and sceneProgress<9
  {
    sceneDelay=0
    bWaitForInput=false
    with oMessageCutscene
      instance_destroy()
    fadeAlpha=0
    sceneProgress=9
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
