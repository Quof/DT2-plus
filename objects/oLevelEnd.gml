#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
areaComplete=0
progressTime=0

//victory message
vRan=irandom_range(1,2)
if vRan=1
  vMessage="Good job!!"
else if vRan=2
  vMessage="You did great!!"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if areaComplete=1
{
  //if keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space)
  if keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
  if progressTime<90
  {
    progressTime=90
  }
  else
  {
    //Go to world map
    transition_steps=30
    transition_kind=20
    //room_goto(rWorldMap)
    room_goto_fixed(rWorldMap) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//---------- Update scores ----------
if areaComplete=0
{
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  oPlayer1.visible=0
  effect_create_above(ef_firework,oPlayer1.x,oPlayer1.y-24,1,c_yellow)
  global.gamePaused=true
  mapIndex=findMapIndex()
  global.saveOnAuto=1

  //---------- complete flag ----------
  global.lvlComplete[mapIndex]=1
  //---------- crystals ----------
  if global.currentCrystals=5
    global.lvlCrystal[mapIndex]=1
  //---------- time ----------
  if global.levelTimeFrameCount<global.lvlTime[mapIndex]
    global.lvlTime[mapIndex]=global.levelTimeFrameCount
  else if global.lvlTime[mapIndex]=0
    global.lvlTime[mapIndex]=global.levelTimeFrameCount
  //---------- score ----------
  //find score mod by damage taken
  perfectBonus=500
  perfectBonus-=(global.hitsTaken*50)
  if perfectBonus<0
    perfectBonus=0
  //find score mod by time
  findTargetScores()
  timePenalty=0
  if global.levelTimeFrameCount>targetTime[mapIndex]
  {
    var tFindTimePenalty,tFindTargetTime;
    tFindTimePenalty=floor(global.levelTimeFrameCount/30)
    tFindTargetTime=floor(targetTime[mapIndex]/30)
    timePenalty=(tFindTimePenalty-tFindTargetTime)*10
  }
  if timePenalty>1000
    timePenalty=1000

  adjustedScore=global.currentScore
  adjustedScore+=perfectBonus-timePenalty //adjust score
  if adjustedScore<0
    adjustedScore=0
  if adjustedScore>global.lvlScore[mapIndex]
    global.lvlScore[mapIndex]=adjustedScore

  areaComplete=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sprite_index,image_index,x,y)

if areaComplete=1 //show level results
{
  completeX=view_xview[0]+256
  completeY=view_yview[0]+68
  draw_set_alpha(0.4)
  draw_set_color(make_color_rgb(192,0,192))
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],0)
  draw_sprite(sAreaCompleteMenu,0,completeX,completeY)
  draw_set_font(fnt_Continue)
  draw_set_halign(fa_right)
  draw_set_alpha(1)
  //progressTime+=1
  progressTime+=1*gDeltaTime //60fps change: counts 30fps ticks (Draw runs every frame)
  if progressTime>=15
  {
    draw_set_color(c_black)
    draw_text(completeX+58,completeY+29,global.currentScore)
    draw_text(completeX+58,completeY+28,global.currentScore)
    draw_set_color(c_white)
    draw_text(completeX+58,completeY+27,global.currentScore)
  }
  if progressTime>=30
  {
    draw_set_color(c_black)
    draw_text(completeX+58,completeY+51,global.levelTimeFrameCount)
    draw_text(completeX+58,completeY+50,global.levelTimeFrameCount)
    draw_set_color(c_white)
    draw_text(completeX+58,completeY+49,global.levelTimeFrameCount)
  }
  if progressTime>=45
  {
    var crX;
    crX=0
    for(i=0;i<global.currentCrystals;i+=1)
    {
      draw_sprite(sLevelCrystal,-1,completeX-49+crX,completeY+104)
      crX+=24
    }
  }
  if progressTime>=60
  {
    draw_set_color(c_black)
    draw_text(completeX+58,completeY+136,perfectBonus)
    draw_text(completeX+58,completeY+135,perfectBonus)
    draw_set_color(c_white)
    draw_text(completeX+58,completeY+134,perfectBonus)
  }
  if progressTime>=75
  {
    draw_set_color(c_black)
    draw_text(completeX+58,completeY+180,timePenalty)
    draw_text(completeX+58,completeY+179,timePenalty)
    draw_set_color(c_white)
    draw_text(completeX+58,completeY+178,timePenalty)
  }
  if progressTime>=90
  {
    draw_set_halign(fa_middle)
    draw_set_color(c_black)
    draw_text(completeX,completeY+221,adjustedScore)
    draw_text(completeX,completeY+220,adjustedScore)
    draw_set_color(c_white)
    draw_text(completeX,completeY+219,adjustedScore)

    draw_set_halign(fa_right)
    draw_sprite(sGameOverGirl,0,view_xview[0]+451,view_yview[0]+384)
    draw_set_color(make_color_rgb(100,0,50))
    draw_text(view_xview[0]+405,view_yview[0]+336,vMessage)
  }
}
