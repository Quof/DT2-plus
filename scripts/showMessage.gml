/*
This script sets the message box used.
argument0: x position (center)
argument1: y position (center)
argument2: message shown
argument3: character talking (0 for no one)
argument4: text color (0 for black)
argument5: alpha
argument6: window color (0 for default)
*/
//========================================
//========== COLOR SETTINGS ==========
//========================================
if argument6=0 //blue
{
  colorBoxBorderOuter=make_color_rgb(22,59,195)
  colorBoxBorderInner=make_color_rgb(95,92,216)
  colorBoxFill=make_color_rgb(144,156,218)
}
else if argument6=1 //orange
{
  colorBoxBorderOuter=make_color_rgb(184,104,8)
  colorBoxBorderInner=make_color_rgb(247,190,74)
  colorBoxFill=make_color_rgb(213,180,112)
}
else if argument6=2 //green
{
  colorBoxBorderOuter=make_color_rgb(40,97,17)
  colorBoxBorderInner=make_color_rgb(57,137,24)
  colorBoxFill=make_color_rgb(77,188,33)
}
else if argument6=3 //red
{
  colorBoxBorderOuter=make_color_rgb(184,8,8)
  colorBoxBorderInner=make_color_rgb(247,74,74)
  colorBoxFill=make_color_rgb(213,112,112)
}
else if argument6=4 //gray
{
  colorBoxBorderOuter=make_color_rgb(45,45,45)
  colorBoxBorderInner=make_color_rgb(130,130,130)
  colorBoxFill=make_color_rgb(210,210,210)
}
//========================================
//Character window color override
if argument3=global.mainCharacters[0] //Jerry
{
  colorBoxBorderOuter=make_color_rgb(184,104,8)
  colorBoxBorderInner=make_color_rgb(247,190,74)
  colorBoxFill=make_color_rgb(213,180,112)
}
else if argument3=global.mainCharacters[1] //Jeremy
{
  colorBoxBorderOuter=make_color_rgb(40,97,17)
  colorBoxBorderInner=make_color_rgb(57,137,24)
  colorBoxFill=make_color_rgb(77,188,33)
}
else if argument3=global.mainCharacters[2] //The Darkness
{
  colorBoxBorderOuter=make_color_rgb(184,8,8)
  colorBoxBorderInner=make_color_rgb(247,74,74)
  colorBoxFill=make_color_rgb(213,112,112)
}
else if argument3=global.mainCharacters[3] //Claire
{
  colorBoxBorderOuter=make_color_rgb(168,64,80)
  colorBoxBorderInner=make_color_rgb(202,100,125)
  colorBoxFill=make_color_rgb(232,136,160)
}
else if argument3=global.mainCharacters[4] //Chao
{
  colorBoxBorderOuter=make_color_rgb(168,64,167)
  colorBoxBorderInner=make_color_rgb(202,100,201)
  colorBoxFill=make_color_rgb(232,136,231)
}
//========================================
if argument4=0
  textColor=c_black
else
  textColor=argument4
messageAlpha=argument5
//========================================
//========== TEXT SETTINGS ==========
//========================================
draw_set_alpha(messageAlpha)
draw_set_halign(fa_left)
draw_set_font(fnt_MenuInfo)
messageShown=argument2
messageWidth=string_width(messageShown)
messageHeight=string_height(messageShown)
//---------- show message box ----------
xBorder1=argument0
yBorder1=argument1
xBorder2=xBorder1+10
if argument3!=""
  yBorder2=yBorder1+12
else
  yBorder2=yBorder1+3
draw_set_color(colorBoxFill)
draw_rectangle(xBorder1,yBorder1,xBorder2+messageWidth,yBorder2+messageHeight,false)
draw_set_color(colorBoxBorderOuter)
draw_rectangle(xBorder1,yBorder1,xBorder2+messageWidth,yBorder2+messageHeight,true)
draw_rectangle(xBorder1+2,yBorder1+2,xBorder2+messageWidth-2,yBorder2+messageHeight-2,true)
draw_set_color(colorBoxBorderInner)
draw_rectangle(xBorder1+1,yBorder1+1,xBorder2+messageWidth-1,yBorder2+messageHeight-1,true)
//---------- show text message ----------
draw_set_color(textColor)
xText=argument0+5
if argument3!=""
  yText=argument1+10
else
  yText=argument1+1
draw_text(xText,yText,messageShown)
//---------- show character name box ----------
if argument3!=""
{
  characterShown=argument3
  characterWidth=string_width(characterShown)
  characterHeight=string_height(characterShown)
  xNameBorder1=argument0+7
  yNameBorder1=argument1-7
  xNameBorder2=xNameBorder1+10
  yNameBorder2=yNameBorder1+2
  draw_set_color(colorBoxFill)
  draw_rectangle(xNameBorder1,yNameBorder1,xNameBorder2+characterWidth,yNameBorder2+characterHeight,false)
  draw_set_color(colorBoxBorderOuter)
  draw_rectangle(xNameBorder1,yNameBorder1,xNameBorder2+characterWidth,yNameBorder2+characterHeight,true)
  draw_rectangle(xNameBorder1+2,yNameBorder1+2,xNameBorder2+characterWidth-2,yNameBorder2+characterHeight-2,true)
  draw_set_color(colorBoxBorderInner)
  draw_rectangle(xNameBorder1+1,yNameBorder1+1,xNameBorder2+characterWidth-1,yNameBorder2+characterHeight-1,true)
  //---------- show character name ----------
  draw_set_color(c_black)
  xCharacter=argument0+12 //5+7
  yCharacter=argument1-6
  draw_text(xCharacter,yCharacter,characterShown)
}
