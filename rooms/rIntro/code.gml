//60fps change (added): the frame rate. gDeltaTime is how much of a 30fps tick one frame is (30/fps: 1, 0.5 or 0.25);
//anything the game changes every frame by a 30fps amount is scaled by it. gDeltaDoTicks is 1 on frames that start a new
//30fps tick (oFrameControl works it out every Begin Step) and gDeltaTick is how far into the tick the frame is.
//This is the first room, so this runs before anything else (rIntro is also where the debug keys send the game back to).
globalvar gDeltaTime, gDeltaDoTicks, gDeltaTick;
//gamepad change (added): the gamepad reader (persistent), made before loadOptions, which reads the saved gamepad controls
//over the defaults its scrGamepadInit sets
if !instance_exists(oGamepad) {instance_create(0,0,oGamepad)}
if !variable_global_exists("gameFrameRate")
{
  global.gameFrameRate=120
  gDeltaTime = 30/global.gameFrameRate
  gDeltaDoTicks = 0
  gDeltaTick = 0.0
  loadOptions()
}
if !instance_exists(oFrameControl) {instance_create(0,0,oFrameControl)}
//instance id fix (added): the room instances that code refers to by their ids in the original game (GID / GID_SET)
if !variable_global_exists("objectIDMap") {global.objectIDMap=ds_map_create()}

backFollowFore=instance_create(0,0,oBackgroundFollow)
backFollowFore.type=1
backFollowFore.backSet=backIntermediaryWoods
backFollowFore.xScrollSpeed=-1
backFollowFore.depth=1499999
backFollowFore.image_yscale=2.4

gameIntro=instance_create(0,0,oIntro)
