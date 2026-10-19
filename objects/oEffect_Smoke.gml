#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.25+random(0.1)
alphaChange=random_range(0.05,0.1)
xVel=random_range(-0.5,0.5)
yVel=random_range(-3,-1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_index>1.65
  image_index=0

//x+=xVel
//y+=yVel
//image_alpha-=alphaChange
x+=xVel*gDeltaTime //60fps change: per 30fps tick
y+=yVel*gDeltaTime //60fps change: per 30fps tick
image_alpha-=alphaChange*gDeltaTime //60fps change: per 30fps tick
if image_alpha<=0
  instance_destroy()
