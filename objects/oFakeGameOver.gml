#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.gameOver=true
global.gamePaused=true
stopLoopingSounds()
//stopAllMusic()
playSound(global.snd_GameOver,0,1)
effect_clear()
for (i=0;i<7;i+=1)
  background_foreground[i]=false
background_visible[7]=true
background_foreground[7]=true
oPlayer1.xVel=0
oPlayer1.yVel=0
oPlayer1.xAcc=0
oPlayer1.yAcc=0
view_angle[0]=0
backAlpha=0
backColor=c_white
showOptions=0
staticEffect=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if staticEffect>=2 //fade to black
{
  //staticEffect+=1
  staticEffect+=1*gDeltaTime //60fps change: counts 30fps ticks (from 2, so it lands on 3 and 10)
  if staticEffect=3
  {
    background_alpha[7]=0
    backAlpha=1
  }
  else if staticEffect=10
  {
    backColor=make_color_rgb(70,0,110)
    if showOptions=0
      showOptions=1
  }
}
else //static effect
{
  //staticEffect+=0.04
  staticEffect+=0.04*gDeltaTime //60fps change: per 30fps tick
  if staticEffect>=1.4
    staticEffect=2
  background_alpha[7]=staticEffect
}

if showOptions>0
{
  //showOptions+=1
  showOptions+=1*gDeltaTime //60fps change: counts 30fps ticks
  if showOptions>=4
  {
    global.gameOver=false
    writeToPlayerGlobals()
    transition_steps=1
    transition_kind=0
    //room_goto(rFinal_a6_3)
    room_goto_fixed(rFinal_a6_3) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(backAlpha)
draw_set_color(backColor)
draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)
