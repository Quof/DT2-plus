#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.75
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if image_alpha=0.75
//  image_alpha=0.25
//else
//  image_alpha=0.75
if gDeltaDoTicks {if image_alpha=0.75 {image_alpha=0.25} else {image_alpha=0.75}} //60fps change: flickers once per 30fps tick (every frame was 2x/4x as fast)
