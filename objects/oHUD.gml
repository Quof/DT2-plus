#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Integrated Visualization System (IVS)
menuOpen=false

hitComboAlpha=0 //combo counter alpha
hitComboFadeTime=0 //combo fade/reset time
killChainAlpha=0 //kill chain alpha
killChainFadeTime=0 //kill chain fade/reset time
killChainText=0

background_index[7]=backStatic
background_alpha[7]=0.07
background_foreground[7]=true
background_hspeed[7]=31
background_vspeed[7]=21
//input commands==========
curPause=ord("P")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //if keyboard_check_pressed(curPause) and global.gameOver=false
  if (keyboard_check_pressed(curPause) or scrPadPressed(12)) and global.gameOver=false //gamepad change: and the gamepad (scrGamepadInit) (START)
  {
    io_clear()
    scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
    playSound(global.snd_MenuOpen,0,1)
    global.gamePaused=true
    menuOpen=true
    oPlayer1.image_speed=0
    instance_create(0,0,oPauseMenu)
  }

  if oPlayer1.hitCombo>0 //hit combo fade
  {
    //hitComboFadeTime-=1
    hitComboFadeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    if hitComboFadeTime<=25
      //hitComboAlpha-=0.04
      hitComboAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    if hitComboFadeTime<=0
    {
      oPlayer1.hitCombo=0
    }
  }
  if oPlayer1.killChain>0 //kill chain fade
  {
    //killChainFadeTime-=1
    killChainFadeTime-=1*gDeltaTime //60fps change: counts 30fps ticks
    if killChainFadeTime<=25
      //killChainAlpha-=0.04
      killChainAlpha-=0.04*gDeltaTime //60fps change: per 30fps tick
    if killChainFadeTime<=0
      oPlayer1.killChain=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=true and menuOpen=true
{
  var backColor;
  backColor=make_color_rgb(232,136,160)
  draw_set_color(backColor)
  draw_set_alpha(0.4)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)
}

//low health warn --------------------------------------------------
if oPlayer1.life<=oPlayer1.lowHealthThreshold and global.optLowHealthWarn=true and global.gamePaused=false
{
  global.soundAmplify=0.8
  background_visible[7]=true
}
else
{
  global.soundAmplify=1
  if !instance_exists(oFakeGameOver)
  {
    if !instance_exists(oGameOver)
      background_visible[7]=false
  }
}
//Sound frequency change
var tempFplay;
tempFplay=findMusic(1)
SS_SetSoundFreq(tempFplay,findFreq()*global.soundAmplify)

if global.optShowHUD=1
{
  //health track --------------------------------------------------
  healthDisplayX=view_xview[0]+4
  healthDisplayY=view_yview[0]+4
  draw_sprite(sHealthBar,0,healthDisplayX,healthDisplayY)

  if oPlayer1.life>0
    draw_sprite_general(sPlayerHealthTrack,0,0,0,6,oPlayer1.life*2-1,healthDisplayX+9,healthDisplayY+50,1,1,180,c_white,c_white,c_white,c_white,1)

  //dash icon
  if oPlayer1.canAirDash=1
    draw_sprite(sDashIcon,0,healthDisplayX+80,healthDisplayY+18)

  //status effects --------------------------------------------------
  draw_set_color(c_black)
  draw_set_font(fnt_PauseText)
  draw_set_halign(fa_right)
  draw_set_alpha(1)
  //if oPlayer1.blastOffRecoveryTime>0 //Blast Off
  //60fps change: the recovery time counts 30fps ticks in fractions above 30fps; shown as whole ticks, the same numbers as
  //at 30fps (39 down to 1: floor of the count, which is hidden during the last tick, as at 30fps where it's then 0)
  if oPlayer1.blastOffRecoveryTime>=1 //Blast Off
  {
    draw_sprite(sStatusEffect,0,healthDisplayX+148,healthDisplayY+13)
    //draw_text(healthDisplayX+155,healthDisplayY+8,oPlayer1.blastOffRecoveryTime)
    draw_text(healthDisplayX+155,healthDisplayY+8,floor(oPlayer1.blastOffRecoveryTime))
  }
  /*
  if oPlayer1.statusPoison>0 //Poison
  {
    draw_sprite(sStatusEffect,1,healthDisplayX+158,healthDisplayY+5)
    draw_text(healthDisplayX+166,healthDisplayY+5,round(oPlayer1.statusPoison/30))
  }
  if oPlayer1.statusSpiritDrain>0 //Spirit Drain
  {
    draw_sprite(sStatusEffect,2,healthDisplayX+176,healthDisplayY+5)
    draw_text(healthDisplayX+184,healthDisplayY+5,round(oPlayer1.statusSpiritDrain/30))
  }
  if oPlayer1.statusSkillLock>0 //Skill Lock
  {
    draw_sprite(sStatusEffect,3,healthDisplayX+194,healthDisplayY+5)
    draw_text(healthDisplayX+202,healthDisplayY+5,round(oPlayer1.statusSkillLock/30))
  }*/

  //element meter --------------------------------------------------
  elementDisplayX=view_xview[0]+29
  elementDisplayY=view_yview[0]+54
  if oPlayer1.fireEnergy>0
    draw_sprite_general(sElementTrack,0,0,0,6,oPlayer1.fireEnergy*2-1,elementDisplayX,elementDisplayY,1,1,180,c_white,c_white,c_white,c_white,1)
  if oPlayer1.waterEnergy>0
    draw_sprite_general(sElementTrack,1,0,0,6,oPlayer1.waterEnergy*2-1,elementDisplayX+16,elementDisplayY,1,1,180,c_white,c_white,c_white,c_white,1)
  if oPlayer1.windEnergy>0
    draw_sprite_general(sElementTrack,2,0,0,6,oPlayer1.windEnergy*2-1,elementDisplayX+32,elementDisplayY,1,1,180,c_white,c_white,c_white,c_white,1)
  if oPlayer1.earthEnergy>0
    draw_sprite_general(sElementTrack,3,0,0,6,oPlayer1.earthEnergy*2-1,elementDisplayX+48,elementDisplayY,1,1,180,c_white,c_white,c_white,c_white,1)

  //dash point display --------------------------------------------------
  if oPlayer1.dashPoints>0
  {
    dashPointDisplayX=view_xview[0]+93
    dashPointDisplayY=view_yview[0]+54
    draw_sprite_general(sDashTrack,0,0,0,6,oPlayer1.dashPoints*2-1,dashPointDisplayX,dashPointDisplayY,1,1,180,c_white,c_white,c_white,c_white,1)
  }
}

if global.lvlCurrent!="Final"
{
  //score/time display --------------------------------------------------
  //60fps change: the level time (shown here, and kept as the level's record time and the challenges' scores) counts
  //30fps ticks, as whole numbers: one per 30fps tick (gDeltaDoTicks), so it's the same at every frame rate (counting every
  //frame it ran 2x/4x as fast at 60/120fps)
  if global.gamePaused=false and gDeltaDoTicks //level play time
  {
    global.levelTimeFrameCount+=1
    if global.levelTimeFrameCount mod 30=0
    {
      global.levelTimeSecond+=1
      global.sessionPlayTime+=1
    }
  }

  if global.optShowHUD=1
  {
    scoreDisplayX=view_xview[0]+424
    scoreDisplayY=view_yview[0]+4
    draw_sprite(sScoreDisplay,-1,scoreDisplayX,scoreDisplayY)
    draw_set_font(fnt_SubMenu)
    draw_set_alpha(1)
    draw_set_halign(fa_right)
    draw_set_color(c_white)
    draw_text(scoreDisplayX+79,scoreDisplayY+1,global.currentScore)
    draw_text(scoreDisplayX+79,scoreDisplayY+11,global.levelTimeFrameCount)
  }

  if oPlayer1.killChain>=2 and global.optKillChainScreen=true //kill chain counter -----------------------------------
  {
    killChainIndX=view_xview[0]+256
    killChainIndY=view_yview[0]+48
    comboCl=make_color_rgb(168,64,80)
    draw_set_color(comboCl)
    draw_set_halign(fa_center)
    draw_set_font(fnt_KillChain)
    draw_set_alpha(killChainAlpha)
    if oPlayer1.killChain=2
      killChainText="DOUBLE KILL!!"
    else if oPlayer1.killChain=3
      killChainText="MULTI KILL!!"
    else if oPlayer1.killChain=4
      killChainText="MEGA KILL!!"
    else if oPlayer1.killChain=5
      killChainText="ULTRA KILL!!"
    else if oPlayer1.killChain=6
      killChainText="MONSTER KILL!!"
    else if oPlayer1.killChain=7
      killChainText="LUDICROUS KILL!!"
    else if oPlayer1.killChain=8
      killChainText="WRECKER!!"
    else if oPlayer1.killChain=9
      killChainText="SILENCER!!"
    else if oPlayer1.killChain=10
      killChainText="HEADHUNTER!!"
    //text shadow - downright
    draw_text(killChainIndX+29,killChainIndY+1,killChainText)
    //text highlight - upleft
    comboCl=make_color_rgb(250,219,154)
    draw_set_color(comboCl)
    draw_text(killChainIndX+27,killChainIndY-1,killChainText)
    //text
    comboCl=make_color_rgb(248,192,72)
    draw_set_color(comboCl)
    draw_text(killChainIndX+28,killChainIndY,killChainText)
  }
  if global.lvlCurrent!="1-B" and global.lvlCurrent!="2-B" and global.lvlCurrent!="3-B"
  {
    if killChainFadeTime>0 and global.optShowHUD=1 //kill chain meter
    {
      kcMeterX=view_xview[0]+6
      kcMeterY=view_yview[0]+88
      draw_set_alpha(1)
      draw_set_color(c_ltgray)
      draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+oPlayer1.chainingTime+2,0)
      draw_set_color(c_black)
      draw_rectangle(kcMeterX,kcMeterY,kcMeterX+5,kcMeterY+oPlayer1.chainingTime+2,1)
      draw_set_color(c_fuchsia)
      draw_rectangle(kcMeterX+1,kcMeterY+1,kcMeterX+4,kcMeterY+killChainFadeTime+1,0)
    }
  }
}
else
{
  if room=rFinal_aFleetA or room=rFinal_aFleetB or room=rFinal_aFleetC
  {
    //jump score display --------------------------------------------------
    if global.optShowHUD=1
    {
      scoreDisplayX=view_xview[0]+424
      scoreDisplayY=view_yview[0]+4
      draw_sprite(sMarioScore,-1,scoreDisplayX,scoreDisplayY)
      draw_set_font(fnt_SubMenu)
      draw_set_alpha(1)
      draw_set_halign(fa_right)
      draw_set_color(c_white)
      draw_text(scoreDisplayX+79,scoreDisplayY+1,global.currentScore)
    }
  }
}
