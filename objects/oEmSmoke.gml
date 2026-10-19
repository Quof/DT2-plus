#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y+=8
smokeTime=irandom_range(3,12)

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  //smokeTime-=1
  smokeTime-=1*gDeltaTime //60fps change: counts 30fps ticks (smoke came 2x/4x as often)
  if smokeTime<=0
  {
    var xDir,yDir;
    xDir=x-4+random(8)
    yDir=y-4+random(8)
    instance_create(xDir,yDir,oEffect_Smoke)
    smokeTime=irandom_range(3,12)
  }
}
