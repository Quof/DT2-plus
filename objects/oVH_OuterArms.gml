#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.05+random(0.05)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Move Up
  {
    //y-=1
    y-=1*gDeltaTime //60fps change: per 30fps tick
    if y<=room_height {type=100}
  }
  else if type=1 //Move Down
  {
    //y+=1
    y+=1*gDeltaTime //60fps change: per 30fps tick
    if y>=0 {type=100}
  }
  else if type=2 //Move Right
  {
    //x+=1
    x+=1*gDeltaTime //60fps change: per 30fps tick
    if x>=6176 {type=100}
  }
  else if type=3 //Move Left
  {
    //x-=1
    x-=1*gDeltaTime //60fps change: per 30fps tick
    if x<=room_width+64 {type=100}
  }
  else if type=4 //Move Up (Not as much)
  {
    //y-=1
    y-=1*gDeltaTime //60fps change: per 30fps tick
    if y<=room_height+64 {type=100}
  }
  else if type=5 //Move Down (Not as much)
  {
    //y+=1
    y+=1*gDeltaTime //60fps change: per 30fps tick
    if y>=-32 {type=100}
  }
  else if type=6 //Move Left (A bit more)
  {
    //x-=1
    x-=1*gDeltaTime //60fps change: per 30fps tick
    if x<=room_width+40 {type=100}
  }
}
