#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
//setCollisionBounds(1,0,sprite_width,sprite_height)
xVel=0

findTargetX=0
findTargetY=0
drawRangeX=544
drawRangeY=416
mstLX=x; mstLY=y //60fps change (added): see the Step (gameStepEvent keeps them up to date)

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
yVel=ySpd
if variable_local_exists("makeRandom")
{
  var ranShape;
  ranShape=irandom(18)
  switch ranShape
  {
    case 0: sprite_index=sTet_Square; break;
    case 1: sprite_index=sTet_Line_1; break;
    case 2: sprite_index=sTet_Line_2; break;
    case 3: sprite_index=sTet_L_1; break;
    case 4: sprite_index=sTet_L_2; break;
    case 5: sprite_index=sTet_L_3; break;
    case 6: sprite_index=sTet_L_4; break;
    case 7: sprite_index=sTet_BackL_1; break;
    case 8: sprite_index=sTet_BackL_2; break;
    case 9: sprite_index=sTet_BackL_3; break;
    case 10: sprite_index=sTet_BackL_4; break;
    case 11: sprite_index=sTet_W_1; break;
    case 12: sprite_index=sTet_W_2; break;
    case 13: sprite_index=sTet_BackW_1; break;
    case 14: sprite_index=sTet_BackW_2; break;
    case 15: sprite_index=sTet_T_1; break;
    case 16: sprite_index=sTet_T_2; break;
    case 17: sprite_index=sTet_T_3; break;
    case 18: sprite_index=sTet_T_4; break;
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if global.gamePaused=false
if global.gamePaused=false and gDeltaDoTicks!=0 //60fps change: runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
{
  //if y>room_height+64
  //60fps change: mstLY is where the block will be once this 30fps tick's move has finished (gameStepEvent; the same as y at
  //30fps). Above 30fps a tick's move is spread over its frames, so y could still be short of the line here and the block
  //wrapped a tick late, ending up a tick's fall out of step with the rest of the blocks for good
  if mstLY>room_height+64
  {
    if room=rBonusC3 {instance_destroy()}
    else {y=-128}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
