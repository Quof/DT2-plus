#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.gamePaused=true
playSound(global.snd_InfoOn,0,1)
oPlayer1.image_speed=0
windowClosed=false
bShowInfo=true

textColor1=make_color_rgb(255,181,57)
textColor2=make_color_rgb(16,0,140)

statsWindowX=view_xview[0]+26
statsWindowY=view_yview[0]+48

circleRad[0]=36
circleRad[1]=24
circleRad[2]=12
for(i=0;i<3;i+=1)
  circleAlpha[i]=0

scanProgress=0
scanStep=0
for(i=0;i<6;i+=1)
  scanData[i]=round(random(899)+100)

sufferString="??????????"
sufferTime=0
bJeremyHelp=0
if global.lvlCurrent="4-B" or global.lvlCurrent="Final"
  bJeremyHelp=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowInfo=true
{
  //if (keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_enter)) and windowClosed=false
  if (keyboard_check_pressed(ord("J")) or keyboard_check_pressed(vk_enter) or scrPadPressed(14)) and windowClosed=false //gamepad change: and the gamepad (scrGamepadInit)
  {
    io_clear()
    scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
    playSound(global.snd_InfoOff,0,1)
    windowClosed=true
    global.gamePaused=false
  }

  if bJeremyHelp=1
  {
    //if keyboard_check_pressed(ord("K")) and windowClosed=false
    if (keyboard_check_pressed(ord("K")) or scrPadPressed(15)) and windowClosed=false //gamepad change: and the gamepad (scrGamepadInit)
    {
      io_clear()
      scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
      playSound(global.snd_InfoOff,0,1)
      scanText=chaoText
    }
    //else if keyboard_check_pressed(ord("L")) and windowClosed=false
    else if (keyboard_check_pressed(ord("L")) or scrPadPressed(16)) and windowClosed=false //gamepad change: and the gamepad (scrGamepadInit) (Y)
    {
      io_clear()
      scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
      playSound(global.snd_InfoOff,0,1)
      scanText=jeremyText
    }
  }
}

if windowClosed=true
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
statsWindowX=view_xview[0]+26
statsWindowY=view_yview[0]+48
//draw back color
var backColor;
backColor=make_color_rgb(232,136,160)
draw_set_color(backColor)
draw_set_alpha(0.4)
draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)

//target effect
for(i=0;i<3;i+=1)
{
  //circleAlpha[i]+=0.04
  circleAlpha[i]+=0.04*gDeltaTime //60fps change: per 30fps tick (Draw runs every frame)
  draw_set_alpha(circleAlpha[i])
  draw_circle(effectX,effectY,circleRad[i],true)
  //circleRad[i]-=1
  circleRad[i]-=1*gDeltaTime //60fps change: per 30fps tick
  if circleRad[i]<=0
  {
    circleRad[i]=36
    circleAlpha[i]=0
  }
}

//statistical data
draw_sprite(sScanMenu,0,statsWindowX,statsWindowY)
if bJeremyHelp=1
{ //input text change (added)
  draw_sprite(sScanExtra,0,statsWindowX+179,statsWindowY+98)
  //input text change (added): while the gamepad is the input being used, the box's K and L (Chao's / Jeremy's info) are
  //covered with its colour and the buttons for them (B / Y, see the Step) drawn there instead, DT3+'s icons at twice
  //their size to go with the box's lettering
  if global.gpLastUsed=1
  {
    var tCol,tAl,tBX,tBY;
    tCol=draw_get_color(); tAl=draw_get_alpha()
    tBX=statsWindowX+179; tBY=statsWindowY+98
    draw_set_alpha(1)
    draw_set_color(make_color_rgb(255,214,255))
    draw_rectangle(tBX+123,tBY+6,tBX+133,tBY+20,false)
    draw_rectangle(tBX+123,tBY+23,tBX+133,tBY+37,false)
    draw_sprite_ext(sKeyPressPad,scrInputPadFrame(15),tBX+126,tBY+14,2,2,0,c_white,1)
    draw_sprite_ext(sKeyPressPad,scrInputPadFrame(16),tBX+126,tBY+30,2,2,0,c_white,1)
    draw_set_color(tCol); draw_set_alpha(tAl)
  }
} //input text change (added)
draw_set_font(fnt_Scan)
draw_set_halign(fa_right)
if scanProgress<6
{
  //if scanStep>=10
  if scanStep>=10+1-gDeltaTime //60fps change: counted in 30fps ticks and checked before it's added to, so each value is revealed every 11 ticks as at 30fps (>=10 at 30fps)
  {
    scanProgress+=1
    scanStep=0
  }
  else
    //scanStep+=1
    scanStep+=1*gDeltaTime //60fps change: counts 30fps ticks

  if gDeltaDoTicks //60fps change (added): the numbers roll once per 30fps tick (every frame they rolled 2x/4x as fast)
  for(i=0;i<6;i+=1)
    scanData[i]=round(random(899)+100)
}

draw_set_alpha(1)
if name="Suffering"
{
  //sufferTime+=1
  sufferTime+=1*gDeltaTime //60fps change: counts 30fps ticks (mod 5 still hits once every 5 ticks)
  if sufferTime mod 5=0
  {
    nextString=irandom_range(1,9)
    if nextString=1 {sufferString="??????????"}
    else if nextString=2 {sufferString="<Unidentified>"}
    else if nextString=3 {sufferString="Suffer"}
    else if nextString=4 {sufferString="Scanning..."}
    else if nextString=5 {sufferString="Target Unfocused"}
    else if nextString=6 {sufferString="Virus Core"}
    else if nextString=7 {sufferString="Corrosion"}
    else if nextString=8 {sufferString="Data Lock"}
    else if nextString=9 {sufferString="Code Name: <Suffering>"}
  }
  scanTextBorder(sufferString,452,6)
  draw_text(statsWindowX+452,statsWindowY+6,sufferString)
}
else
{
  scanTextBorder(name,452,6)
  draw_text(statsWindowX+452,statsWindowY+6,name)
}

if scanProgress>=1
{
  real(life)
  if name="Suffering"
  {
    scanTextBorder("????",452,23)
    draw_text(statsWindowX+452,statsWindowY+23,"????")
  }
  else
  {
    scanTextBorder(life,452,23)
    draw_text(statsWindowX+452,statsWindowY+23,life)
  }
}
else
{
  scanTextBorder(scanData[0],452,23)
  draw_text(statsWindowX+452,statsWindowY+23,scanData[0])
}

if scanProgress>=2
{
  if name="Suffering"
  {
    scanTextBorder("????",452,40)
    draw_text(statsWindowX+452,statsWindowY+40,"????")
  }
  else
  {
    scanTextBorder(pPower,452,40)
    draw_text(statsWindowX+452,statsWindowY+40,pPower)
  }
}
else
{
  scanTextBorder(scanData[1],452,40)
  draw_text(statsWindowX+452,statsWindowY+40,scanData[1])
}

if scanProgress>=3
{
  if name="Suffering"
  {
    scanTextBorder("???",167,70)
    draw_text(statsWindowX+167,statsWindowY+70,"???")
  }
  else
  {
    scanTextBorder(string(fireRes) +string("%"),167,70)
    draw_text(statsWindowX+167,statsWindowY+70,string(fireRes) +string("%"))
  }
}
else
{
  scanTextBorder(scanData[2],167,70)
  draw_text(statsWindowX+167,statsWindowY+70,scanData[2])
}

if scanProgress>=4
{
  if name="Suffering"
  {
    scanTextBorder("???",167,87)
    draw_text(statsWindowX+167,statsWindowY+87,"???")
  }
  else
  {
    scanTextBorder(string(waterRes) +string("%"),167,87)
    draw_text(statsWindowX+167,statsWindowY+87,string(waterRes) +string("%"))
  }
}
else
{
  scanTextBorder(scanData[3],167,87)
  draw_text(statsWindowX+167,statsWindowY+87,scanData[3])
}

if scanProgress>=5
{
  if name="Suffering"
  {
    scanTextBorder("???",167,104)
    draw_text(statsWindowX+167,statsWindowY+104,"???")
  }
  else
  {
    scanTextBorder(string(windRes) +string("%"),167,104)
    draw_text(statsWindowX+167,statsWindowY+104,string(windRes) +string("%"))
  }
}
else
{
  scanTextBorder(scanData[4],167,104)
  draw_text(statsWindowX+167,statsWindowY+104,scanData[4])
}

if scanProgress>=6
{
  if name="Suffering"
  {
    scanTextBorder("???",167,121)
    draw_text(statsWindowX+167,statsWindowY+121,"???")
  }
  else
  {
    scanTextBorder(string(earthRes) +string("%"),167,121)
    draw_text(statsWindowX+167,statsWindowY+121,string(earthRes) +string("%"))
  }
}
else
{
  scanTextBorder(scanData[5],167,121)
  draw_text(statsWindowX+167,statsWindowY+121,scanData[5])
}

//scan text
draw_set_font(fnt_MenuInfo)
draw_set_halign(fa_left)

draw_set_color(textColor1)
draw_text_ext(statsWindowX+8,statsWindowY+151,scanText,12,442)
draw_set_color(textColor2)
draw_text_ext(statsWindowX+8,statsWindowY+150,scanText,12,442)
