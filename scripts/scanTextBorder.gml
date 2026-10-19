/*
This script is called in the enemy scan object and draws the border around the scan text
argument0: value to draw
argument1: x draw value
argument2: y draw value

shading diagram
x 0 x
1 2 3
4 x 5
6 7 8
*/

var tValue,tX,tY;
tValue=argument0
tX=argument1
tY=argument2

draw_set_color(textColor2)
draw_text(statsWindowX+tX,statsWindowY+tY-2,tValue) //0
draw_text(statsWindowX+tX-1,statsWindowY+tY-1,tValue) //1
draw_text(statsWindowX+tX,statsWindowY+tY-1,tValue) //2
draw_text(statsWindowX+tX+1,statsWindowY+tY-1,tValue) //3
draw_text(statsWindowX+tX-1,statsWindowY+tY,tValue) //4
draw_text(statsWindowX+tX+1,statsWindowY+tY,tValue) //5
draw_text(statsWindowX+tX-1,statsWindowY+tY+1,tValue) //6
draw_text(statsWindowX+tX,statsWindowY+tY+1,tValue) //7
draw_text(statsWindowX+tX+1,statsWindowY+tY+1,tValue) //8
draw_set_color(textColor1)
