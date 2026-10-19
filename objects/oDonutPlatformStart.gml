#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this object's purpose is to create the oDonutPlatform object if the character is not going to collide with it
setCollisionBounds(0,0,sprite_width,sprite_height)
visible=0

//if this condition isn't here, the game gets an error. Very weird...
if variable_local_exists("oCharacter.collisionBoundsOffsetLeftX")
//if the character is not in the way...
if isCollisionCharacter()=0
{
  instance_create(x,y,oDonutPlatform)
  instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks=0 {exit} //60fps change (added): runs on 30fps ticks (unscaled), as in DT3+: the moving solids only read their speed on 30fps ticks and gameStepEvent spreads each tick's move over the frames, so this changes it on the same ticks as at 30fps
//if the character is not in the way...
if isCollisionCharacter()=0
{
  instance_create(x,y,oDonutPlatform)
  instance_destroy()
}
