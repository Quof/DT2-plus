#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change (added): runs the frame rate for the whole game (in DT3+ this is in oGame, but here oGame only exists once
//the game is being played, and the intro and title screen need it too). Made by rIntro's creation code, persistent, so
//it's the first instance every event runs for. Begin Step: room_speed and whether this frame is a 30fps tick
//(gDeltaDoTicks); Step: takes back the excess of what GameMaker does by itself every frame (animation, built-in motion,
//background scrolling), which is in 30fps units.
if instance_number(oFrameControl)>1 {instance_destroy(); exit}
global.frameRateNext=0 //a frame rate asked for ([F2] on the title screen), set at the end of the current 30fps tick (Begin Step)
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Begin Step: decide whether this frame is a 30fps tick before any instance's Step event runs.
//A frame rate asked for (global.frameRateNext: [F2] on the title screen, oInitializeGame; kept in DT2Options.dts by
//saveOptions) is set at the end of a 30fps tick (at most 3 frames), when the counters that count 30fps ticks by
//gDeltaTime are on whole numbers, so their "=N" checks still land after it (changing from 120 to 30fps on a count of
//x.25, the count would never be a whole number again)
//if keyboard_check_pressed(vk_f2)
//{
//  if global.frameRateNext==0 {global.frameRateNext=global.gameFrameRate}
//  if global.frameRateNext==30 {global.frameRateNext=60}
//  else if global.frameRateNext==60 {global.frameRateNext=120}
//  else {global.frameRateNext=30}
//}
//frame rate change: [F2] is read by the title screen now (oInitializeGame): the frame rate can only be changed there
if global.frameRateNext!=0 and (gDeltaTime==1.0 or gDeltaTick<0.0001)
{
  if global.frameRateNext!=global.gameFrameRate {scrSetFrameRate(global.frameRateNext); saveOptions()}
  global.frameRateNext=0
}
//GameMaker sets room_speed to the room's own speed (30) whenever the room changes
room_speed=global.gameFrameRate

gDeltaDoTicks = 0
gDeltaTick += gDeltaTime
while (gDeltaTick >= 1.0)
{
  gDeltaDoTicks += 1
  gDeltaTick -= 1.0
}
if gDeltaTime == 1.0 { gDeltaDoTicks = 1; gDeltaTick = 0.999999 }
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaTime != 1.0
{
  // GM adds image_speed and the built-in speed (hspeed/vspeed) in full every frame; take back the excess above 30fps.
  // (One pass over all instances, kept as small as possible.)
  // Friction-having objects are almost all visual effects (oKillEffect, oKillAward, oBonusAward), so their built-in
  // motion is scaled here. Any gameplay-affecting object with built-in speed is converted to _speed/_direction instead.
  var tDtM1;
  tDtM1 = gDeltaTime - 1.0
  with (all)
  {
    image_index += image_speed * tDtM1
    if friction != 0
    {
      x += hspeed * tDtM1
      y += vspeed * tDtM1
      if speed != 0 {speed -= friction * tDtM1} //GM's friction stops at 0, and adding the excess back from there would leave a small speed that never runs out
    }
  }
  // The visual effect objects are also included even without friction: code can spawn them with GM's built-in
  // speed/direction (e.g. tEffect.speed=4), which GM applies in full every frame.
  // (looped per object, so only those instances are visited; friction != 0 was already handled above)
  with (oEffect) if friction == 0 and speed != 0 {x += hspeed * tDtM1; y += vspeed * tDtM1}
  with (oKillEffect) if friction == 0 and speed != 0 {x += hspeed * tDtM1; y += vspeed * tDtM1}
  with (oMisc) if friction == 0 and speed != 0 {x += hspeed * tDtM1; y += vspeed * tDtM1} //cutscene props (and the end credits) moved by built-in speed

  //GM scrolls every background layer by its full background_hspeed/vspeed every frame; take back the excess above 30fps
  //so background speeds set in the room editor or in code (kept in 30fps units) scroll at the 30fps rate
  var bgi;
  for(bgi=0;bgi<8;bgi+=1)
  {
    background_x[bgi] -= background_hspeed[bgi] * (1.0 - gDeltaTime)
    background_y[bgi] -= background_vspeed[bgi] * (1.0 - gDeltaTime)
  }
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Room Start: the 30fps ticks start over with the room, so the counts of everything made with the room (counting 30fps
//ticks by gDeltaTime) are whole numbers on the frames that end a tick, and so are the counts started on those frames.
//A frame-rate change waits for such a frame (Begin Step), so those counts stay whole numbers at the new rate and their
//"=N" checks keep landing. (What the last room had of an unfinished tick is dropped: at most 3 frames.)
gDeltaTick=0.0
