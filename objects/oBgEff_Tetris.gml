#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=0
findTargetY=0
drawRangeX=544
drawRangeY=416

//speed=random_range(4,8)
//direction=270
//60fps change (added): moves by _speed/_direction (correctSpeedDirection, in Step) instead of GameMaker's built-in
//speed/direction, which GameMaker applies in full every frame
_speed=random_range(4,8)
_direction=270
image_alpha=random_range(0.02,0.04)

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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
correctSpeedDirection(self) //60fps change (added): see Create
if y>room_height+128
  instance_destroy()
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
