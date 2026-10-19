#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if y<oClaireShip.y
  yArc=-1
else
  yArc=1
//60fps change (added): see the shooter note in oShipEnemyBase's Create (this moves at the end of its Step)
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
  //speed=bulletSpeed
  _speed=bulletSpeed //60fps change: see the shooter note in oShipEnemyBase's Create
  //60fps change: the trails are made once per 30fps tick (gDeltaDoTicks)
  if sprite_index=sCShot1 //-------------------- Bullet Bill 1 --------------------
  {
    var tEffect;
    if gDeltaDoTicks
    {
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMSmokeCloud
    tEffect.image_alpha=0.3
    tEffect.image_speed=0.55+random(0.1)
    }
  }
  else if sprite_index=sCShot2 //-------------------- Bullet Bill 2 --------------------
  {
    var tEffect,tEffectAmt;
    tEffectAmt=irandom_range(4,5)
    if gDeltaDoTicks for(i=0;i<tEffectAmt;i+=1)
    {
      tEffect=instance_create(x-4+irandom(8),y-8+irandom(16),oEffect)
      if i>3
        tEffect.sprite_index=sXshotEffect2
      else
        tEffect.sprite_index=sMMSmokeCloud
      tEffect.image_alpha=0.35
      tEffect.image_speed=0.55+random(0.15)
    }
  }
  else if sprite_index=sCShot3 //-------------------- Bullet Bill 3 --------------------
  {
    var tEffect,tEffectAmt;
    tEffectAmt=irandom_range(9,12)
    if gDeltaDoTicks for(i=0;i<tEffectAmt;i+=1)
    {
      tEffect=instance_create(x-8+irandom(16),y-26+irandom(52),oEffect)
      if i>7
        tEffect.sprite_index=sXshotEffect1
      else
        tEffect.sprite_index=sXshotEffect2
      tEffect.image_alpha=0.4
      tEffect.image_speed=0.3+random(0.1)
    }
  }
  else if sprite_index=sCShot4 //-------------------- Samus Missile 1 --------------------
  {
    //if oGame.time mod 2=0
    if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMetroidMissileSmoke
      tEffect.image_alpha=0.35
      tEffect.image_speed=0.4+random(0.2)
    }
    //y+=yArc
    y+=yArc*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  else if sprite_index=sCShot5 //-------------------- Samus Missile 2 --------------------
  {
    //if oGame.time mod 2=0
    if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMetroidMissileSmoke
      tEffect.image_alpha=0.4
      tEffect.image_speed=0.4+random(0.2)
    }
    //y+=yArc
    y+=yArc*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  else if sprite_index=sCShot6 //-------------------- Samus Missile 3 --------------------
  {
    //if oGame.time mod 2=0
    if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMetroidMissileSmoke
      tEffect.image_alpha=0.45
      tEffect.image_speed=0.4+random(0.2)
    }
    //y+=yArc
    y+=yArc*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  else if sprite_index=sXSpeedBurner //-------------------- MMX Speed Burner --------------------
  {
    effectAmt=irandom_range(3,4)
    if gDeltaDoTicks for(i=0;i<effectAmt;i+=1)
    {
      effect=instance_create(x-8+irandom(8),y-10+irandom(20),oEffect)
      if i>2
        effect.sprite_index=sXshotEffect1
      else
        effect.sprite_index=sXshotEffect2
      effect.image_alpha=0.5
      effect.image_speed=0.5+random(0.1)
    }
  }
  else if sprite_index=sZeroChargeShot //-------------------- Zero Charge Shot --------------------
  {
    effectAmt=irandom_range(2,3)
    if gDeltaDoTicks for(i=0;i<effectAmt;i+=1)
    {
      effect=instance_create(x-8+irandom(8),y-7+irandom(14),oEffect)
      effect.sprite_index=sZeroChargeEffect
      effect.image_alpha=0.6
      effect.image_speed=0.5+random(0.1)
    }
  }
  else if sprite_index=sJerryTrioAttack //-------------------- Jerry Trio Attack --------------------
  {
    effectAmt=irandom_range(21,24)
    if gDeltaDoTicks for(i=0;i<effectAmt;i+=1)
    {
      effect=instance_create(x-48+irandom(24),y-64+irandom(128),oEffect)
      if i<=9
        effect.sprite_index=sZeroChargeEffect
      else if i>=10 and i<=19
        effect.sprite_index=sXshotEffect2
      else
        effect.sprite_index=sXshotEffect1
      effect.image_alpha=0.65
      effect.image_speed=0.2+random(0.05)
    }
  }
}
else
  //speed=0
  _speed=0 //60fps change: see the shooter note in oShipEnemyBase's Create
correctSpeedDirection(self) //60fps change (added): see Create
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
