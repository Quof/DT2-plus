#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
//60fps change (added): moves by _speed/_direction (correctSpeedDirection) instead of GameMaker's built-in speed/direction,
//which GameMaker applies in full every frame; whatever fires it sets _direction
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
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

  //speed=bulletSpeed
  //y+=oEvW5.yScrollAmt
  _speed=bulletSpeed //60fps change: see Create
  y+=oEvW5.yScrollAmt*gDeltaTime //60fps change: follows the scroll's bob per 30fps tick
}
else
  //speed=0
  _speed=0
correctSpeedDirection(self) //60fps change (added): see Create
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
      other.yAdjust=0
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
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
