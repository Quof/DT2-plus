#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
image_speed=0
visible=0
bCanTakeDamage=false

//Enemy base statistics
eName="Sand Plant"
maxLife=35
life=maxLife
pointWorth=200
atkPower=3
atkDefense=0
FIREresist=75
WATERresist=0
WINDresist=0
EARTHresist=75
baseItemChance=40

if global.lvlCurrent="2-2"
  targetDist=112
else
  targetDist=160

jumpProg=0
shotProg=0
ySpd=0
yGround=y

scanText="This odd looking thing hops up out of the sand and spits two gravity based fireballs from its mouth."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive()
  if bActive=true and stunnedTime=0 and dieFade=0
  {
    //y+=ySpd
    if jumpProg!=0 and jumpProg<4 {ySpd=scrGravAcc(ySpd,0.25,-1)} //60fps change (added): gravity spread over the frames; at 30fps this moves and then speeds up, so the original line below stays for 30fps (see scrGravAcc)
    y+=ySpd*gDeltaTime //60fps change: per 30fps tick
    //if jumpProg!=0 and jumpProg<4
    if jumpProg!=0 and jumpProg<4 and gDeltaTime==1 //60fps change: 30fps only (see above)
      ySpd+=0.25

    if jumpProg=0 //detect distance and jump
    {
      if findTargetX<160
      {
        effect=instance_create(x,y,oEffect)
        effect.sprite_index=sDustCloud
        effect.image_yscale=0.9
        effect.image_alpha=0.7
        bCanTakeDamage=true
        visible=1
        ySpd=-7
        jumpProg=1
      }
    }
    else if jumpProg=1 //check jump speed
    {
      if ySpd>-1
        jumpProg=2
    }
    else if jumpProg=2 //animate and shoot
    {
      //shotProg+=1
      shotProg+=1*gDeltaTime //60fps change: counts 30fps ticks
      if shotProg=1
        image_index=1
      else if shotProg=6
      {
        image_index=2
        for(i=0;i<2;i+=1)
        {
          newAttack=instance_create(x,y,oGravityBullet)
          newAttack.sprite_index=sGTrackShot2
          newAttack.image_speed=0.3
          newAttack.image_blend=c_orange
          newAttack.atkPower=atkPower
          if i=0
            newAttack.xVel=2.25
          else
            newAttack.xVel=-2.25
          newAttack.yVel=-5.2
        }
      }
      else if shotProg=15
        image_index=1
      else if shotProg=20
      {
        image_index=0
        jumpProg=3
      }
    }
    else if jumpProg=3 //go back in sand
    {
      if y>=yGround
      {
        effect=instance_create(x,y,oEffect)
        effect.sprite_index=sDustCloud
        effect.image_yscale=0.9
        effect.image_alpha=0.7
        bCanTakeDamage=false
        visible=0
        ySpd=0
        jumpProg=4
      }
    }
    else if jumpProg>=4 //slight delay before jump is allowed again
    {
      //jumpProg+=1
      jumpProg+=1*gDeltaTime //60fps change: counts 30fps ticks (only in the wait after landing, from 4 up, so the state numbers 0-3 above aren't touched)
      if jumpProg>=20
      {
        y=yGround
        jumpProg=0
        shotProg=0
      }
    }
  }

  enemyStepEvent()
}
