#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
jIntChange=0
window=0
messageColor=c_black
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(view_xview[0]+x,view_yview[0]+y,message,talker,messageColor,1,window)

colJBorder=make_color_rgb(184,104,8)
//jIntChange+=1
jIntChange+=1*gDeltaTime //60fps change: the prompt blinks per 30fps tick (Draw runs every frame)
if jIntChange<=14
  colJInt=make_color_rgb(213,180,112)
else
  colJInt=make_color_rgb(247,190,74)
if jIntChange>=28
  jIntChange=0
draw_set_color(colJInt)
draw_rectangle(xBorder2+messageWidth-10,yBorder2+messageHeight+2,xBorder2+messageWidth,yBorder2+messageHeight+13,false)
draw_set_color(colJBorder)
draw_rectangle(xBorder2+messageWidth-10,yBorder2+messageHeight+2,xBorder2+messageWidth,yBorder2+messageHeight+13,true)
draw_set_color(c_black)
draw_set_font(fnt_PauseText)
draw_text(xBorder2+messageWidth-7,yBorder2+messageHeight+1,"J")
