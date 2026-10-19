#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.recPeopleTalkedTo+=1
bFading=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFading=false
{
  findTargetX=point_distance(oPlayer1.x,0,xPos,0)
  findTargetY=point_distance(0,oPlayer1.y,0,yPos)
  if findTargetX>=96 or findTargetY>=96
    bFading=true
}
else
{
  image_alpha-=0.05
  if image_alpha<=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(view_xview[0]+x,view_yview[0]+y,message,talker,0,image_alpha)
