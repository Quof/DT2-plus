#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.4
effectDelay=4
effectTime=0
sparkleColor=c_aqua

fairyAutoRoam=false //whether the fairy is on automove
autoMoveDelay=0 //how long the mouse can't be moved till the fairy goes into automove
mouseWindowX1=display_mouse_get_x()
mouseWindowY1=display_mouse_get_y()
mouseWindowX1=display_mouse_get_x()
mouseWindowY1=display_mouse_get_y()
maxSpeed=0 //max flight speed for fairy in automove
followTarget=oPlayer1

emoteType=0
emoteTime=0
emoteFrame=0
emoteScale=0.1
emoteAlpha=1

//emote types
EM_EXCITE=1
EM_IDEA=2
EM_MAD=3
EM_LOVE=4
EM_EMBARRASS=5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false
{
  //-------------------- movement --------------------
  if fairyAutoRoam=false //fairy tracks mouse
  {
    x=mouse_x
    y=mouse_y
  }
  else if fairyAutoRoam=true //fairy on automove
  {
    if followTarget!=oPlayer1
    {
      if !instance_exists(followTarget)
        followTarget=oPlayer1
    }

    myDist=point_distance(x,y,followTarget.x,followTarget.y)
    myDist=round(myDist/32)
    if myDist>12
      myDist=12
    else if myDist<2
      myDist=2
    maxSpeed=myDist

    if x>followTarget.x
    {
      if hspeed>-maxSpeed
        //hspeed-=0.1
        hspeed-=0.1*gDeltaTime //60fps change: per 30fps tick
      else
        hspeed=-maxSpeed
    }
    else if x<followTarget.x
    {
      if hspeed<maxSpeed
        //hspeed+=0.1
        hspeed+=0.1*gDeltaTime //60fps change: per 30fps tick
      else
        hspeed=maxSpeed
    }
    if y>followTarget.y-48
    {
      if vspeed>-maxSpeed
        //vspeed-=0.1
        vspeed-=0.1*gDeltaTime //60fps change: per 30fps tick
      else
        vspeed=-maxSpeed
    }
    else if y<followTarget.y-48
    {
      if vspeed<maxSpeed
        //vspeed+=0.1
        vspeed+=0.1*gDeltaTime //60fps change: per 30fps tick
      else
        vspeed=maxSpeed
    }
  }
  else
  {
    hspeed=0
    vspeed=0
  }

  if global.gamePaused=false
  {
    //if effectTime=effectDelay
    if effectTime>=effectDelay+1-gDeltaTime //60fps change: counted in 30fps ticks and checked before it's added to, so a sparkle comes every effectDelay+1 ticks as at 30fps (=effectDelay at 30fps)
    {
      effect_create_above(ef_spark,x,y,0,sparkleColor)
      effectTime=0
    }
    else
      //effectTime+=1
      effectTime+=1*gDeltaTime //60fps change: counts 30fps ticks
  }

  mouseWindowX2=display_mouse_get_x()
  mouseWindowY2=display_mouse_get_y()
  if mouseWindowX1!=mouseWindowX2
  {
    mouseWindowX1=mouseWindowX2
    autoMoveDelay=0
    fairyAutoRoam=false
  }
  if mouseWindowY1!=mouseWindowY2
  {
    mouseWindowY1=mouseWindowY2
    autoMoveDelay=0
    fairyAutoRoam=false
  }
  if autoMoveDelay<60
  {
    hspeed=0
    vspeed=0
    //autoMoveDelay+=1
    autoMoveDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
    if autoMoveDelay=60
      fairyAutoRoam=true
  }
}
//60fps change (added): Chao's automove uses GameMaker's built-in hspeed/vspeed, which GameMaker applies in full every
//frame; take back the excess above 30fps (as DT3+'s oMisc does)
x+=hspeed*(gDeltaTime-1); y+=vspeed*(gDeltaTime-1)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

//-------------------- emotes --------------------
if global.gameOver=false
{
  if emoteType=EM_EXCITE //-------------------- Excited --------------------
  {
    if emoteScale<1
      //emoteScale+=0.1
      emoteScale+=0.1*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    draw_sprite_ext(sCEmExcite,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_IDEA //-------------------- Idea --------------------
  {
    if emoteScale<1
      //emoteScale+=0.1
      emoteScale+=0.1*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    draw_sprite_ext(sCEmIdea,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_MAD //-------------------- Mad --------------------
  {
    if emoteScale<1
      //emoteScale+=0.1
      emoteScale+=0.1*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    if emoteTime mod 4=0
    {
      emoteFrame+=1
      if emoteFrame=3
        emoteFrame=0
    }
    draw_sprite_ext(sCEmMad,emoteFrame,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_LOVE //-------------------- Love --------------------
  {
    if emoteScale<1
      //emoteScale+=0.1
      emoteScale+=0.1*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    draw_sprite_ext(sCEmLove,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_EMBARRASS //-------------------- Embarrass --------------------
  {
    if emoteScale<1
      //emoteScale+=0.1
      emoteScale+=0.1*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
    draw_sprite_ext(sCEmEmbarrass,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }

  if emoteType>0 //fade emotes
  {
    //emoteTime+=1
    emoteTime+=1*gDeltaTime //60fps change: counts 30fps ticks (the mod 4 above still hits once every 4 ticks)
    if emoteTime>=35
    {
      //emoteAlpha-=0.1
      emoteAlpha-=0.1*gDeltaTime //60fps change: per 30fps tick
      if emoteAlpha<=0
      {
        emoteTime=0
        emoteType=0
        emoteFrame=0
        emoteScale=0.1
        emoteAlpha=1
      }
    }
  }
}
