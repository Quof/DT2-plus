#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if type=3 //Jerry after image
if type=3 and gDeltaDoTicks //Jerry after image //60fps change: one after image per 30fps tick (every frame made 2x/4x as many)
{
  afterImage=instance_create(x,y,oSceneAfterImage)
  afterImage.sprite_index=sprite_index
  afterImage.image_xscale=image_xscale
  afterImage.imageFade=0.1
  afterImage.xScalingSet=0
  afterImage.yScalingSet=0
}
