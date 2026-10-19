#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-1,-1,1,1)
//find the correct sprite for effect and collision
currentSpell=oPlayer1.spellCasting
damageType="SPIRIT"
atkPower=oPlayer1.atkPower

if oPlayer1.image_xscale=-1
  image_xscale=-1

if currentSpell="FIREBALL"
{
  sprite_index=sSpellFireball
  setCollisionBounds(-6,-5,6,5)
  y-=24
  if image_xscale=1
  {
    xVel=9
    x+=8
  }
  else
  {
    xVel=-9
    x-=8
  }
  if oPlayer1.yVel>0
  {
    oPlayer1.yVel=0
    oPlayer1.yVelSetExt=1 //60fps change (added): velocity set after the player's move: its next move uses the 30fps formula (see pMoveToWrapNew)
    scrSlowFall(2,0.5)
  }
  elementType=1
  skillPower=10
  image_speed=0.5
  lifeTime=45
}
else if currentSpell="WATER BLAST"
{
  sprite_index=sSpellWaterBlast
  image_xscale=1.65
  image_yscale=1.6
  image_alpha=0.5
  if oPlayer1.yVel>0
  {
    oPlayer1.yVel=0
    oPlayer1.yVelSetExt=1 //60fps change (added): see FIREBALL
    scrSlowFall(4,0.5)
  }
  elementType=2
  skillPower=10
  image_speed=0.2
  lifeTime=15
}
else if currentSpell="FLOOD"
{
  sprite_index=sSpellFloodWave
  image_alpha=0.85
  if image_xscale=1
  {
    xSpd=12.5
    x+=6
  }
  else
  {
    xSpd=-12.5
    x-=6
  }
  if oPlayer1.yVel>0
  {
    oPlayer1.yVel=0
    oPlayer1.yVelSetExt=1 //60fps change (added): see FIREBALL
    scrSlowFall(4,0.5)
  }
  elementType=2
  skillPower=10
  image_speed=0.2
  lifeTime=15
}
else if currentSpell="WIND BURST"
{
  sprite_index=sSpellWindStorm
  y-=2
  image_alpha=0.75
  with oPlayer1
  {
    if platformCharacterIs(IN_AIR)
    {
      if yVel>-3
        {yVel=-3; yVelSetExt=1} //60fps change: velocity set after the player's move: its next move uses the 30fps formula (see pMoveToWrapNew)
      if yVel>0
        yVel=0
    }
  }
  scrSlowFall(11,0.3)
  elementType=3
  skillPower=10
  image_speed=0.5
  lifeTime=14
}
else if currentSpell="ROCK SMASH"
{
  sprite_index=sSpellRockSmash
  setCollisionBounds(-6,-6,6,6)
  y-=72
  if image_xscale=1
    xVel=2
  else
    xVel=-2
  if oPlayer1.yVel>0
  {
    oPlayer1.yVel=1
    oPlayer1.yVelSetExt=1 //60fps change (added): see FIREBALL
  }
  elementType=4
  skillPower=10
  weight=100
  lifeTime=90
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if currentSpell="FIREBALL"
{
  effect=instance_create(x,y,oEffect)
  effect.sprite_index=sRobotExplosion
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if currentSpell="FIREBALL"
  {
    //if oGame.time mod 2=0
    if oGame.time mod (2/gDeltaTime)=0 //60fps change: oGame.time counts frames; this is every other 30fps tick
    {
      var tEffect;
      tEffect=instance_create(x-4+random(8),y-4+random(8),oEffect)
      tEffect.sprite_index=sXshotEffect1; tEffect.image_speed=0.2+random(0.1)
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
      tEffect.image_alpha=0.6
    }

    if isCollisionLeft(1)
      instance_destroy()
    if isCollisionRight(1)
      instance_destroy()
  }
  else if currentSpell="WATER BLAST"
  {
    if gDeltaDoTicks //60fps change (added): effects once per 30fps tick (every frame made 2x/4x as many)
    for(i=0;i<3;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x-24+random(48),y-4-random(52),oEffect)
      tEffect.sprite_index=sWaterEffect; tEffect.image_speed=0.2+random(0.1); tEffect.image_angle=random(360)
      tEffect.image_alpha=0.45; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-2-random(3)
    }
  }
  else if currentSpell="FLOOD"
  {
    if gDeltaDoTicks //60fps change (added): effects once per 30fps tick
    for(i=0;i<4;i+=1)
    {
      var tEffect;
      tEffect=instance_create(x+(random(48)*image_xscale),y-4-random(44),oEffect)
      tEffect.sprite_index=sWaterEffect; tEffect.image_speed=0.2+random(0.1); tEffect.image_angle=random(360)
      tEffect.image_alpha=0.6; tEffect.xSpd=random(2)*image_xscale
    }

    //image_yscale-=0.035
    //x+=xSpd
    image_yscale-=0.035*gDeltaTime //60fps change: per 30fps tick
    x+=xSpd*gDeltaTime //60fps change: per 30fps tick
  }
  else if currentSpell="WIND BURST"
  {
    if gDeltaDoTicks //60fps change (added): effects once per 30fps tick
    {
    var tEffect;
    tEffect=instance_create(x-14+random(28),y-2-random(16),oEffect)
    tEffect.sprite_index=sWindEffect; tEffect.image_speed=0.2+random(0.1)
    tEffect.image_alpha=0.2; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-2-random(3)
    } //60fps change (added)

    //if xSpd>0 and xSpd<8
    //  xSpd+=0.4
    //if xSpd<0 and xSpd>-8
    //  xSpd-=0.4
    //x+=xSpd
    //60fps change: the speed-up is decided once per 30fps tick and lands on the 30fps speeds (scrTickAcc), so the caps
    //stop it at the same speeds; the move is corrected to cover each tick's 30fps distance (scrTickAccB)
    var tWindAcc;
    tWindAcc=0
    if xSpd>0 and xSpd<8
      tWindAcc+=0.4
    if xSpd<0 and xSpd>-8
      tWindAcc-=0.4
    xSpd=scrTickAcc(xSpd,tWindAcc,2) //(slot 2: slots 0/1 are ROCK SMASH's xVel/yVel, corrected in the moveTo below)
    x+=(xSpd+scrTickAccB(2))*gDeltaTime
  }
  else if currentSpell="ROCK SMASH"
  {
    if gDeltaDoTicks //60fps change (added): one trail effect per 30fps tick
    {
    var tEffect,tScale;
    tScale=1+((91-lifeTime)/40)
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sXshotEffect2; tEffect.image_speed=0.2; tEffect.image_alpha=0.35
    tEffect.image_xscale=tScale; tEffect.image_yscale=tScale
    } //60fps change (added)

    if isCollisionBottom(1)
    {
      playSound(global.snd_BoulderHit,0,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBomberExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      instance_destroy()
    }
    if isCollisionLeft(1)
    {
      playSound(global.snd_BoulderHit,0,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBomberExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      instance_destroy()
    }
    if isCollisionRight(1)
    {
      playSound(global.snd_BoulderHit,0,1)
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBomberExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      instance_destroy()
    }
    //if yVel<12
    //  yVel+=0.3
    //if image_xscale=1
    //{
    //  if xVel<16
    //    xVel+=0.5
    //}
    //else
    //{
    //  if xVel>-16
    //    xVel-=0.5
    //}
    //60fps change: the capped speed-ups are decided once per 30fps tick and land on the 30fps speeds (scrTickAcc slots 1
    //and 0); the move below is corrected so each tick covers the 30fps distance (scrTickAccB)
    var tRockAccX,tRockAccY;
    tRockAccX=0; tRockAccY=0
    if yVel<12
      tRockAccY=0.3
    if image_xscale=1
    {
      if xVel<16
        tRockAccX=0.5
    }
    else
    {
      if xVel>-16
        tRockAccX=-0.5
    }
    yVel=scrTickAcc(yVel,tRockAccY,1)
    xVel=scrTickAcc(xVel,tRockAccX,0)
  }

  //if lifeTime<=0
  //  instance_destroy()
  //else
  //  lifeTime-=1
  //60fps change: counts 30fps ticks. It's checked before it's counted down, so at 30fps the spell moves for lifeTime+1
  //ticks; the end is that much lower (0 at 30fps) so it does above 30fps too, instead of ending half/three quarters of a
  //tick early
  if lifeTime<=gDeltaTime-1
    instance_destroy()
  else
    lifeTime-=1*gDeltaTime
  //moveTo(xVel,yVel)
  moveTo((xVel+scrTickAccB(0))*gDeltaTime,(yVel+scrTickAccB(1))*gDeltaTime) //60fps change: moveTo takes this frame's share of the move (scrTickAccB is 0 when no speed-up happened this frame)
}
#define Collision_oEnemyBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.life>0
{
  if currentSpell="FIREBALL"
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if currentSpell="FIREBALL"
{
  draw_sprite_ext(sSpellFireball,-1,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,c_white,0.4)
  draw_sprite_ext(sSpellFireball,-1,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,c_white,0.2)
}
