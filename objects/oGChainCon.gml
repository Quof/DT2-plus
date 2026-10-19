#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxChain=7
for(i=0;i<=maxChain;i+=1)
{
  chain[i]=instance_create(x,y+4+i*8,oGChainPiece)
}
ball=instance_create(x,y+4+i*8,oTWSG)
ball.activateBoss=1

dir=0
e=90
g=0

swingSpeed=0
maxSwing=0

hitEff=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //60fps change: the swing grows, dies down and moves per 30fps tick (the "maxSwing=0" check rarely lands, as at 30fps)
  if hitEff>=1
  {
    //hitEff+=1
    hitEff+=1*gDeltaTime
    if hitEff>=20 {hitEff=0}
    //maxSwing+=2
    maxSwing+=2*gDeltaTime
    if maxSwing>=40 {hitEff=0}
  }
  else
  {
    if maxSwing>0
    {
      //maxSwing-=0.2
      maxSwing-=0.2*gDeltaTime
      if maxSwing=0 {swingSpeed=0}
    }
  }

  //----- Swing chain -----
  for(i=0;i<=maxChain;i+=1)
  {
    chain[i].x=x+lengthdir_x(4+i*8,-90+dir+i*g)
    chain[i].y=y+lengthdir_y(4+i*8,-90+dir+i*g)
    chain[i].image_angle=dir*1.5
  }
  ball.x=x+lengthdir_x(4+i*8,-90+dir+i*g)
  ball.y=y+lengthdir_y(4+i*8,-90+dir+i*g)
  //ball.image_angle=dir*1.5

  //e+=swingSpeed
  e+=swingSpeed*gDeltaTime
  dir=lengthdir_x(maxSwing,e)
  g=lengthdir_x(1,e)
}
