#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
init=0

vspeed=-4.5
friction=0.15
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if init=0
{
  if type=0
  {
    x=16
    y=160
    if bonusValue=1000
    {
      msgCreate("Got 1000 points in a bonus award.#Now stop doing this.",0,oMessagePerson,"ACHIEVEMENT UNLOCKED")
        newMessage.fadingTime=120
    }
  }
  else if type=1
  {
    x=16
    y=192
  }
  init=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(fnt_Points)
draw_set_halign(fa_left)
draw_text_color(view_xview[0]+x,view_yview[0]+y+1,string("Bonus ") +string(round(bonusValue)),c_black,c_black,c_black,c_black,1)
draw_text_color(view_xview[0]+x,view_yview[0]+y,string("Bonus ") +string(round(bonusValue)),c_white,c_white,c_white,c_white,1)

if vspeed>=0
  instance_destroy()
