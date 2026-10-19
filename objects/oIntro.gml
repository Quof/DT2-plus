#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//main characters
global.mainCharacters[0]="Jerry"           //The original protagonist
global.mainCharacters[1]="Jeremy"          //Jerry's best friend
global.mainCharacters[2]="The Darkness"    //The Dark Entity
global.mainCharacters[3]="Claire"          //Protagonist
global.mainCharacters[4]="Chao"            //Protagonist's Sidekick

screenAlpha=1
screenColor=c_black

textAlpha=0
xText=0
yText=0
textToDraw=""

charJerry=instance_create(288,288,oMisc)
charJerry.sprite_index=sJerryIdle
charJerry.image_xscale=-1
charJerry.image_speed=0.1
charJerry.type=1

charJeremy=instance_create(176,288,oMisc)
charJeremy.sprite_index=sJeremyIdle
charJeremy.image_xscale=2
charJeremy.image_yscale=2
charJeremy.image_speed=0
charJeremy.type=1

charClaire=instance_create(784,288,oMisc)
charClaire.sprite_index=sPlayerIdle
charClaire.image_xscale=1
charClaire.image_speed=0.1
charClaire.type=1

charChao=instance_create(1040,224,oMisc)
charChao.sprite_index=sFairy
charChao.image_speed=0.4
charChao.type=1
charChao.flySpeed=6

SS_Init()
global.msc_TitleMenu=SS_LoadSound(working_directory+"\Music\DT_TitleMenu.ogg",1)
SS_LoopSound(global.msc_TitleMenu)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime), so the equality checks still land on their tick. A frame
//belongs to the tick its count rounds up to, so a range ">=21 and <=40" (ticks 21-40) is ">20 and <=40", and the fades
//in it (per 30fps tick) add up to the same amount as at 30fps (where the new ranges are the same as the old ones)
if sceneProgress=0
{
  //sceneDelay+=1
  sceneDelay+=1*gDeltaTime
  if sceneDelay=20
  {
    global.snd_Chao_Hey1=SS_LoadSound(working_directory+"\Sound\DT_Chao_Hey1.wav",0)
    xText=32
    yText=32
    textToDraw="Not long after Jerry and Jeremy had brought peace among the world within The Darkness, they detected a disturbance."
  }
  //else if sceneDelay>=21 and sceneDelay<=40
  //  textAlpha+=0.05
  //else if sceneDelay>=171 and sceneDelay<=190
  //  textAlpha-=0.05
  //else if sceneDelay>=201 and sceneDelay<=240
  //  screenAlpha-=0.025
  else if sceneDelay>20 and sceneDelay<=40
    textAlpha+=0.05*gDeltaTime
  else if sceneDelay>170 and sceneDelay<=190
    textAlpha-=0.05*gDeltaTime
  else if sceneDelay>200 and sceneDelay<=240
    screenAlpha-=0.025*gDeltaTime
  else if sceneDelay=270
  {
    sceneDelay=0
    sceneProgress+=2
  }
}
else if sceneProgress=2 and bWaitForInput=false
  msgCreate("So this is the area where the disturbance came from?",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=3 and bWaitForInput=false
  msgCreate("Yes, this place has been heavily distorted by something,#but I'm unsure what it is.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=4 and bWaitForInput=false
  msgCreate("Distorted as in?",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=5 and bWaitForInput=false
  msgCreate("A lot of worlds have been thrown together here, think back to Distortion.#I just don't know how distorted it is yet.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=6 and bWaitForInput=false
  msgCreate("Nothing we can't handle, and you never did explain to me why The Darkness#hasn't taken care of this problem.",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=7 and bWaitForInput=false
  msgCreate("It won't respond. It hasn't made a single attempt to,#none that I've detected anyway. It's as if it doesn't exist.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=8 and bWaitForInput=false
  msgCreate("But wouldn't the world become unstable, or worse, end without it?",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=9 and bWaitForInput=false
  msgCreate("The integrity of the world is a seperate function from those#it uses to manipulate it. I'm fairly certain the world data is far#more protected than anything else.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=10 and bWaitForInput=false
  msgCreate("So you think it is not by choice that it has not#responded to you?",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=11 and bWaitForInput=false
  msgCreate("Most definitely. It has no reason to ignore us,#and more importantly, the disturbances here.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=12 and bWaitForInput=false
  msgCreate("Looks like we better start our investigation then.",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=13 and bWaitForInput=false
  msgCreate("Indeed, I'll provide you with backup fire, though I don't#foresee any major problems arising.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=14 and bWaitForInput=false
  msgCreate("I really wish you could've used that sooner.",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=15 and bWaitForInput=false
  msgCreate("You and me both... Oh and one other thing.#I'm detecting two others here.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=16 and bWaitForInput=false
  msgCreate("I would think you'd have a lot more detected than that.",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=17 and bWaitForInput=false
  msgCreate("No no, I mean like us. They are not programs. We should keep#our guards up though, I don't know whether or not they are hostile.#They could even be the reasons behind the disturbances here.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=18 and bWaitForInput=false
  msgCreate("We'll just beat their asses if they try anything.",1,oMessageCutscene,global.mainCharacters[0])
else if sceneProgress=19 and bWaitForInput=false
  msgCreate("Indeed, though one of them feel very familiar to me...#Anyway, let's go.",1,oMessageCutscene,global.mainCharacters[1])
else if sceneProgress=20
{
  //sceneDelay+=1
  sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
  if sceneDelay=20
    textToDraw="Meanwhile, in a not too far away place..."
  //else if sceneDelay>=21 and sceneDelay<=60
  //  screenAlpha+=0.025
  //else if sceneDelay>=81 and sceneDelay<=100
  //  textAlpha+=0.05
  //else if sceneDelay>=201 and sceneDelay<=220
  //  textAlpha-=0.05
  else if sceneDelay>20 and sceneDelay<=60
    screenAlpha+=0.025*gDeltaTime
  else if sceneDelay>80 and sceneDelay<=100
    textAlpha+=0.05*gDeltaTime
  else if sceneDelay>200 and sceneDelay<=220
    textAlpha-=0.05*gDeltaTime
  else if sceneDelay=221
    view_xview[0]=512
  //else if sceneDelay>=241 and sceneDelay<=280
  //  screenAlpha-=0.025
  else if sceneDelay>240 and sceneDelay<=280
    screenAlpha-=0.025*gDeltaTime
  else if sceneDelay=300
  {
    sceneDelay=0
    sceneProgress+=1
  }
}
else if sceneProgress=21 and bWaitForInput=false
  msgCreate("I'm sure this is the place.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=22
{
  //sceneDelay+=1
  sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
  if sceneDelay=20
  {
    sceneDelay=0
    sceneProgress+=1
  }
}
else if sceneProgress=23 and bWaitForInput=false
  msgCreate(global.mainCharacters[4] +string(", where are you?"),1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=24
{
  //sceneDelay+=1
  sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
  //if sceneDelay>=21 and sceneDelay<=60
  if sceneDelay>20 and sceneDelay<=60
  {
    //charChao.x-=charChao.flySpeed
    //charChao.y+=0.5
    //charChao.flySpeed-=0.1
    //60fps change: per 30fps tick. The 30fps code moves and then slows down, so the frames of a tick move at its starting
    //speed minus what the frames before took off; adding 0.05*(1-gDeltaTime) (0 at 30fps) gives each tick the 30fps
    //distance, so Chao stops where it did at 30fps
    charChao.x-=(charChao.flySpeed+0.05*(1-gDeltaTime))*gDeltaTime
    charChao.y+=0.5*gDeltaTime
    charChao.flySpeed-=0.1*gDeltaTime
  }
  else if sceneDelay=61
    SS_PlaySound(global.snd_Chao_Hey1)
  else if sceneDelay=65
  {
    sceneDelay=0
    sceneProgress+=1
  }
}
else if sceneProgress=25 and bWaitForInput=false
  msgCreate("I'm here!",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=26 and bWaitForInput=false
  msgCreate("Oh please don't make that sound anymore.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=27 and bWaitForInput=false
  msgCreate("Sorry, it's a habit I get from my brother.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=28 and bWaitForInput=false
  msgCreate("Annoying people?",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=29 and bWaitForInput=false
  msgCreate("Yes!",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=30 and bWaitForInput=false
  msgCreate("I don't know how you put up with him growing up.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=31 and bWaitForInput=false
  msgCreate("He's not so bad.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=32 and bWaitForInput=false
  msgCreate("You said that about " +string(global.mainCharacters[0]) +string(" too."),1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=33 and bWaitForInput=false
  msgCreate("You're too hard on him.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=34 and bWaitForInput=false
  msgCreate("I AM NOT!!#And I still can't believe he was the one that stabilized the world.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=35 and bWaitForInput=false
  msgCreate("Aww, what makes you say that?",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=36 and bWaitForInput=false
  msgCreate("He doesn't have a single hair of responsibility on him.#I just can't see him doing what needs to be done.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=37 and bWaitForInput=false
  msgCreate("He improved after he was hired at Generico Inc.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=38 and bWaitForInput=false
  msgCreate("Yeah, then he just got boring.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=39 and bWaitForInput=false
  msgCreate("You're still doing it! You're much to hard on him!",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=40 and bWaitForInput=false
  msgCreate("~sigh~ ... Whatever.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=41 and bWaitForInput=false
  msgCreate("He's in the area, you know?",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=42 and bWaitForInput=false
  msgCreate("He's here!? What about " +string(global.mainCharacters[1]) +string("?"),1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=43 and bWaitForInput=false
  msgCreate("Of course, they're probably here for the same reason we are.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=44 and bWaitForInput=false
  msgCreate("I hope we don't run into them.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=45 and bWaitForInput=false
  msgCreate("That's rather selfish of you!",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=46 and bWaitForInput=false
  msgCreate("I'm sorry " +string(global.mainCharacters[4]) +string(", I know you really want to see ") +string(global.mainCharacters[1]) +string("."),1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=47 and bWaitForInput=false
  msgCreate("I just don't get why you're still upset with " +string(global.mainCharacters[0]) +string(".#He's not that bad a guy. You still talk about him."),1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=48 and bWaitForInput=false
  msgCreate("I know I know! Let's just change the subject.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=49 and bWaitForInput=false
  msgCreate("Well I've identified the location of the disturbance.#I found a short-cut that should get us there fast.",1,oMessageCutscene,global.mainCharacters[4])
else if sceneProgress=50 and bWaitForInput=false
  msgCreate("Okay, lead the way.",1,oMessageCutscene,global.mainCharacters[3])
else if sceneProgress=51
{
  //sceneDelay+=1
  //if sceneDelay>=21 and sceneDelay<=60
  //  screenAlpha+=0.025
  sceneDelay+=1*gDeltaTime //60fps change: see sceneProgress 0
  if sceneDelay>20 and sceneDelay<=60
    screenAlpha+=0.025*gDeltaTime
  else if sceneDelay=70
  {
    sceneDelay=0
    sceneProgress+=1
  }
}
else if sceneProgress=52
{
  room_goto(rTitle)
}

keyWaitForInput()

//if keyboard_check_pressed(ord("M"))
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //gamepad change: and the gamepad (scrGamepadInit)
{
  bWaitForInput=true
  with oMessageCutscene
    instance_destroy()
  global.IntroSkipped=1
  screenAlpha=1
  sceneProgress=52
}

//close the game
if !instance_exists(oGame)
{
  if keyboard_check_pressed(vk_escape)
  {
    var closeGame;
    closeGame=show_question("Do you want to quit the game? :(")
    if closeGame=true
      game_end()
  }
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oGame)
  SS_Unload()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(screenAlpha)
draw_set_color(screenColor)
draw_rectangle(0,0,room_width,room_height,0)

draw_set_font(fnt_Continue)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(textAlpha)
draw_text_ext(view_xview[0]+xText,yText,textToDraw,24,468)

draw_set_font(fnt_SubMenu)
draw_set_halign(fa_right)
draw_set_color(c_white)
draw_set_alpha(1)
//draw_text(view_xview[0]+508,369,"Press [M] to skip intro sequence. (As well as any cutscene.)")
//input text change: [M], or BACK's icon while the gamepad is in use (scrDrawInput; right-aligned, as before)
global.inputAlign=fa_right
scrDrawInput(view_xview[0]+508,369,"Press [Skip] to skip intro sequence. (As well as any cutscene.)",-1,-1,1)
global.inputAlign=fa_left
