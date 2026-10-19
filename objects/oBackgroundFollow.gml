#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xx=0
yy=0
xScrollSpeed=0
yScrollSpeed=0
xMoveScale=1
yMoveScale=1
bgAlpha=1
scrollReset=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //stationary background
  draw_background_stretched(backSet,view_xview[0]+x,view_yview[0]+y,wSize,hSize)
else if type=1 //tiled background, stationary/move
  draw_background_tiled_ext(backSet,x+xx,y+yy,image_xscale,image_yscale,c_white,bgAlpha)
else if type=2 //tiled background, move scaled with screen
  draw_background_tiled_ext(backSet,view_xview[0]*xMoveScale,view_yview[0]*yMoveScale,image_xscale,image_yscale,c_white,bgAlpha)
else if type=3 //tiled background, move scaled with screen, x/y adjust
  draw_background_tiled_ext(backSet,(view_xview[0]+xAdjust)*xMoveScale,(view_yview[0]+yAdjust)*yMoveScale,image_xscale,image_yscale,c_white,bgAlpha)

//xx+=xScrollSpeed
//yy+=yScrollSpeed
xx+=xScrollSpeed*gDeltaTime //60fps change: scrolls per 30fps tick (Draw runs every frame)
yy+=yScrollSpeed*gDeltaTime //60fps change: see above
