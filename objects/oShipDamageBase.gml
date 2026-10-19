#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
maxLife=100
life=maxLife
pointWorth=0
bDestroyIfOffScreen=0
bCanTakeDamage=0
#define Collision_oClaireShip
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oClaireShip.bCanTakeDamage=true and !instance_exists(oAssistShot)
{
  effect_create_above(ef_ring,oClaireShip.x,oClaireShip.y,2,c_red)
  effect_create_above(ef_ring,oClaireShip.x,oClaireShip.y,1,c_blue)
  oClaireShip.damageTime=45
  oClaireShip.bCanTakeDamage=false
  oClaireShip.life-=10
  oClaireShip.killCombo=0
  if !instance_exists(oBossBigCore)
  {
    with oShipEnemyProjBase
    {
      effect_create_above(ef_ring,x,y,0,c_red)
      instance_destroy()
    }
  }
}
#define Collision_oClaireShipDmgBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=1
{
  if other.parent="Assist"
    bHitWithBomb=1
  image_blend=c_red
  life-=other.atkPower
  oClaireShip.comboTime-=3
  if oClaireShip.comboTime<0
    oClaireShip.comboTime=0
  event_user(0)
}
else
{
  if parent="Ship" or parent="BigLaser"
  {
    event_user(0)
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.sprite_index=sCShot1 //-------------------- Bullet Bill 1 --------------------
{
  with other
  {
    effect=instance_create(x+(sprite_width/2),y,oEffect)
    effect.sprite_index=sRobotExplosion
    effect.image_xscale=0.7
    effect.image_yscale=0.7
    effect.image_speed=0.45+random(0.1)
    instance_destroy()
  }
}
else if other.sprite_index=sCShot2 //-------------------- Bullet Bill 2 --------------------
{
  with other
  {
    effect=instance_create(x+(sprite_width/2),y,oEffect)
    effect.sprite_index=sRobotExplosion
    effect.image_speed=0.55+random(0.15)
    instance_destroy()
  }
}
else if other.sprite_index=sCShot3 //-------------------- Bullet Bill 3 --------------------
{
  if bCanTakeDamage=0 and parent="Ship"
  {
    with other
    {
      effect=instance_create(x+(sprite_width/2),y,oEffect)
      effect.sprite_index=sRobotExplosion
      effect.image_speed=0.55+random(0.15)
      instance_destroy()
    }
  }
}
else if other.sprite_index=sCShot4 //-------------------- Samus Missile 1 --------------------
{
  with other
  {
    effect=instance_create(x+(sprite_width/2),y,oEffect)
    effect.sprite_index=sMetroidMissileExp
    effect.image_speed=0.4+random(0.2)
    instance_destroy()
  }
}
else if other.sprite_index=sCShot5 //-------------------- Samus Missile 2 --------------------
{
  with other
  {
    effect=instance_create(x+(sprite_width/2),y,oEffect)
    effect.sprite_index=sMetroidMissileExp
    effect.image_xscale=1.25
    effect.image_yscale=1.25
    effect.image_speed=0.4+random(0.2)
    instance_destroy()
  }
}
else if other.sprite_index=sCShot6 //-------------------- Samus Missile 3 --------------------
{
  with other
  {
    effect=instance_create(x+(sprite_width/2),y,oEffect)
    effect.sprite_index=sMetroidMissileExp
    effect.image_xscale=1.5
    effect.image_yscale=1.5
    effect.image_speed=0.4+random(0.2)
    instance_destroy()
  }
}
else if other.sprite_index=sMario3Fire //-------------------- Jerry Mario Fire --------------------
{
  effect=instance_create(x,y,oEffect)
  effect.sprite_index=sBomberExplosion
  effect.image_xscale=0.4
  effect.image_yscale=0.4
  effect.image_speed=0.65+random(0.15)
  with other
    instance_destroy()
}
else if other.sprite_index=sXSpeedBurner //-------------------- MMX Speed Burner --------------------
{
  with other
  {
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sBomberExplosion
    effect.image_xscale=0.7
    effect.image_yscale=0.7
    effect.image_speed=0.5+random(0.2)
    instance_destroy()
  }
}
else if other.sprite_index=sZeroChargeShot //-------------------- Zero Charge Shot --------------------
{
  with other
  {
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sMMExplosion
    effect.image_speed=0.4+random(0.2)
    instance_destroy()
  }
}
else if other.sprite_index=sJeremyMissile //-------------------- Jeremy Missile --------------------
{
  with other
  {
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sBomberExplosion
    effect.image_xscale=0.8
    effect.image_yscale=0.8
    effect.image_speed=0.4+random(0.1)
    instance_destroy()
  }
}
