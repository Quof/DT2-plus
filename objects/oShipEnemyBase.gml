#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
parent="Ship"
bCanTakeDamage=1
bHitWithBomb=0
bBoss=false
//60fps change (added): the shooter level's ships and bullets move by _speed/_direction (correctSpeedDirection, in End Step:
//after every Step, where GameMaker moved them by its built-in speed/direction, which it applies in full every frame);
//whatever makes one sets _direction. Their counts count 30fps ticks (+=1*gDeltaTime; "mod N" spawn checks only land on
//whole numbers), moves and turns are per 30fps tick, and oGame.time (frames) checks are "mod (N/gDeltaTime)"
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
  if life<=0 //----- ENEMY DEATH -----
  {
    playSound(global.snd_ShipShot,0,0.7,se_flanger)
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sShipExplosion1
    effect.image_alpha=0.9
    effect.image_speed=0.45+random(0.15)
    if pointWorth>0 //award points
    {
      if bHitWithBomb=1
        pointWorth/=2
      global.currentScore+=round(pointWorth)
      if global.optShowPointsEarned=true
      {
        newAward=instance_create(x,bbox_bottom-(sprite_height/2),oKillAward)
        newAward.pointValue=pointWorth
      }
    }
    oClaireShip.comboTime=0
    oClaireShip.killCombo+=1
    if oClaireShip.killCombo mod 4=0
    {
      bonusCheck=oClaireShip.killCombo*10
      global.currentScore+=bonusCheck
      if global.optShowPointsEarned=true
      {
        newBonusAward=instance_create(0,0,oBonusAward)
        newBonusAward.bonusValue=bonusCheck
        newBonusAward.type=0
      }
    }

    if variable_local_exists("itemDrop")
    {
      //1: power up, 2: shield recover
      itemAward=instance_create(x,y,oShipPowerUp)
      if itemDrop=2
        itemAward.sprite_index=sCShipShieldRecover
      itemAward.type=itemDrop
    }
    if bBoss=true
    {
      with oShipEnemyProjBase
      {
        effect_create_above(ef_ring,x,y,0,c_green)
        instance_destroy()
      }
    }
    instance_destroy()
  }

  //enemy hit flash
  if image_blend=c_red
    image_blend=c_white

  //delete if off screen
  if bDestroyIfOffScreen=1
  {
    if x<-abs(sprite_width)-4 //left
      instance_destroy()
    else if x>room_width+abs(sprite_width)+4 //right
      instance_destroy()
    else if y<-sprite_height-36 //top
      instance_destroy()
    else if y>room_height+sprite_height+4 //bottom
      instance_destroy()
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
correctSpeedDirection(self) //60fps change (added): see Create
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if bBoss=true
{
  lifePerfect=(life/maxLife)*400
  draw_sprite(sEShipBossMeter,0,72,378)
  draw_sprite_ext(sEShipBossTrack,0,72,378,lifePerfect,1,0,c_white,1)
}
