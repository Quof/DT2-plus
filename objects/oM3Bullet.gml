#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Bullet Bill"
maxLife=20
life=maxLife
atkPower=4
atkDefense=0
FIREresist=75
WATERresist=0
WINDresist=100
EARTHresist=0
bNoBonus=true
runAcc=7.5
if x>oPlayer1.x
  runAcc*=-1
if runAcc>0
  image_xscale=1
else
  image_xscale=-1
inactiveDist*=2
scanText="You didn't play a lot of Mario games did you " +string(global.mainCharacters[3]) +string("? All these can do is go in the direction they were fired in. Oh yeah! The Bullet Blasters won't shoot if you are close to them!")
if global.lvlCurrent="Final"
  jeremyText="I've got the Mario Stomp enabled. You can stomp on anything Mario could now. Every 3rd stomp combo gives you 1 Life Energy back."
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
    yAdjust=0
    with oPlayer1
    {
      if platformCharacterIs(ON_GROUND)
        other.yAdjust=-4
      if platformCharacterIs(IN_AIR)
        other.yAdjust=8
    }
    veloAssist=0
    if oPlayer1.yVel>0
      veloAssist=round(oPlayer1.yVel)
    if isCollisionCharacterTop(yAdjust+veloAssist) or (isCollisionCharacterRight(1) and bbox_bottom+yAdjust+veloAssist>oPlayer1.bbox_bottom) or (isCollisionCharacterLeft(1) and bbox_bottom+yAdjust+veloAssist>oPlayer1.bbox_bottom)
    {
      if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0
      {
        with oPlayer1
        {
          if platformCharacterIs(ON_GROUND)
            yVel=-2
          if platformCharacterIs(IN_AIR)
          {
            if kJump
              yVel=-12
            else
              yVel=-5
          }
          scrSlowFall(3,0.5)
        }
        playSound(global.snd_MarioStomp,0,0.98,oPlayer1.hopOnCount*1000)
        for(i=0;i<6;i+=1)
        {
          effect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
          effect.direction=i*60
        }
        oPlayer1.canAirDash=1
        oPlayer1.hopOnCount+=1
        global.currentScore+=oPlayer1.hopOnCount
        if global.optShowPointsEarned=true
        {
          newAward=instance_create(x,bbox_bottom-(sprite_height/2),oKillAward)
          newAward.pointValue=oPlayer1.hopOnCount
        }
        if oPlayer1.hopOnCount mod 3=0
        {
          oPlayer1.life+=1
          effect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
          effect.sprite_index=sHeal
          effect.followID=oPlayer1.id
          effect.xFollow=0
          effect.yFollow=-(oPlayer1.sprite_height/2)
        }
        instance_destroy()
      }
    }

    if findTargetX>inactiveDist/2
    {
      if questType>0
        enemyQuest(questType)
      instance_destroy()
    }
    //x+=runAcc
    x+=runAcc*gDeltaTime //60fps change: per 30fps tick
    //y+=oEvW5.yScrollAmt
    y+=oEvW5.yScrollAmt*gDeltaTime //60fps change: follows the scroll's bob per 30fps tick
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-4
    if platformCharacterIs(IN_AIR)
      other.yAdjust=8
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel)
  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    with other
      hitPlayer()
  }
}
