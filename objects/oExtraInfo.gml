#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//post message
//if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up) or scrPadPressed(3)) and global.gamePaused=false //gamepad change: and the gamepad (scrGamepadInit)
{
  if image_alpha=1
  {
    image_alpha=0.5
    oExtrasRoom.infoRead+=1
  }
  with oMessageSign
    instance_destroy()
  var messageLength;
  messageLength=string_length(stringToShow)
  newMessage=instance_create(32,48,oMessageSign)
  newMessage.message=stringToShow
  newMessage.fadingTime=round(messageLength*2)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_alpha(1)
draw_set_color(c_black)
draw_set_font(fnt_DamageNotice)
draw_set_halign(fa_center)
draw_text(x+16,y-string_height(headerText),headerText)
