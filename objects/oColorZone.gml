#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if zoneElement=1
  image_blend=c_red
else if zoneElement=2
  image_blend=c_blue
else if zoneElement=3
  image_blend=c_green
else if zoneElement=4
  image_blend=make_color_rgb(120,60,0)
//flashTime=0
//60fps change: flashTime counts 30fps ticks and is checked before it's counted down, so the flash toggles at
//<=gDeltaTime-1 and restarts from gDeltaTime-1 (both 0 at 30fps): every 4 ticks, starting on the first frame in the zone,
//as at 30fps. oColorIndControl counts bWillDamagePlayer down 1 per tick after the zones have set it (the zones are placed
//in the room, the control is made by the room's creation code, so it steps after them); setting it to 1+gDeltaTime (2 at
//30fps) makes it run out 1 tick after leaving the zone, as at 30fps
flashTime=gDeltaTime-1
innerAlpha=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if zoneType=0
  {
    if collision_rectangle(x,y,x+zoneWidth,y+zoneHeight,oPlayer1,0,1)
    {
      if zoneElement=oColorIndControl.elementToShow
        //oColorIndControl.bWillDamagePlayer=2
        oColorIndControl.bWillDamagePlayer=1+gDeltaTime //60fps change: see Create
      //if flashTime=0
      if flashTime<=gDeltaTime-1 //60fps change: see Create
      {
        if innerAlpha=0.5
          innerAlpha=0.6
        else
          innerAlpha=0.5
        flashTime=3
      }
      else
        //flashTime-=1
        flashTime-=1*gDeltaTime
    }
    else
    {
      //flashTime=0
      flashTime=gDeltaTime-1 //60fps change: see Create
      innerAlpha=0.5
    }
  }
  else if zoneType=1
  {
    if collision_circle(x,y,zoneRadius,oPlayer1,0,1)
    {
      if zoneElement=oColorIndControl.elementToShow
        //oColorIndControl.bWillDamagePlayer=2
        oColorIndControl.bWillDamagePlayer=1+gDeltaTime //60fps change: see Create
      //if flashTime=0
      if flashTime<=gDeltaTime-1 //60fps change: see Create
      {
        if innerAlpha=0.5
          innerAlpha=0.6
        else
          innerAlpha=0.5
        flashTime=3
      }
      else
        //flashTime-=1
        flashTime-=1*gDeltaTime
    }
    else
    {
      //flashTime=0
      flashTime=gDeltaTime-1 //60fps change: see Create
      innerAlpha=0.5
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if zoneType=0
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_rectangle(x,y,x+zoneWidth-1,y+zoneHeight-1,0)
  draw_set_alpha(0.9)
  draw_rectangle(x,y,x+zoneWidth-1,y+zoneHeight-1,1)
}
else if zoneType=1
{
  draw_set_color(image_blend)
  draw_set_alpha(innerAlpha)
  draw_circle(x,y,zoneRadius,0)
  draw_set_alpha(0.9)
  draw_circle(x,y,zoneRadius,1)
}
