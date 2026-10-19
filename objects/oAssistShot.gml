#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
assistTime=0
assistProg=0

//Jerry
image_speed=0.6
zeroFrame=0
MMX_X=x-24
MMX_Y=y-64
zero_X=x-24
zero_Y=y+64
arcShot=25
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//animation frames
//if oGame.time mod 2=0
if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
{
  zeroFrame+=1
  if zeroFrame=4
    zeroFrame=0
}
if type=0 //------------------------------ Jerry ------------------------------
{
  MMX_X=x-24
  MMX_Y=y-64
  zero_X=x-24
  zero_Y=y+64
  if assistProg=0
  {
    if x<96
      //x+=16
      x+=16*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    else
      assistProg+=1
  }
  else if assistProg>=1 and assistProg<=9
  {
    //assistTime+=1
    assistTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if assistTime mod 4=0 //Jerry Shot
    {
      tempDir=arcShot-12
      for(i=0;i<3;i+=1)
      {
        newBullet=instance_create(x+20,y,oClaireShot)
        newBullet.parent="Assist"
        newBullet.bulletSpeed=13
        newBullet.atkPower=atkPower-10
        newBullet.sprite_index=sMario3Fire
        newBullet.image_speed=0.4
        //newBullet.direction=tempDir
        newBullet._direction=tempDir //60fps change: see the shooter note in oShipEnemyBase's Create
        tempDir+=12
      }
    }
    if assistTime mod 3=0 //X Shot & Zero Shot
    {
      newBullet=instance_create(MMX_X+20,MMX_Y,oClaireShot)
      newBullet.parent="Assist"
      newBullet.bulletSpeed=14
      newBullet.atkPower=atkPower
      newBullet.sprite_index=sXSpeedBurner
      //newBullet.direction=arcShot
      newBullet._direction=arcShot //60fps change: see the shooter note in oShipEnemyBase's Create
      newBullet.image_angle=arcShot

      newBullet=instance_create(zero_X+34,zero_Y+4,oClaireShot)
      newBullet.parent="Assist"
      newBullet.bulletSpeed=15
      newBullet.atkPower=atkPower
      newBullet.sprite_index=sZeroChargeShot
      //newBullet.direction=arcShot
      newBullet._direction=arcShot //60fps change: see the shooter note in oShipEnemyBase's Create
      newBullet.image_angle=arcShot

      if assistProg=1
      {
        arcShot-=5
        if arcShot<=-25
          assistProg=2
      }
      else if assistProg=2
      {
        arcShot+=5
        if arcShot>=25
          assistProg=1
      }
    }
    if assistTime>=80 //end
    {
      assistTime=0
      assistProg=10
    }
  }
  else if assistProg>=10
  {
    //assistTime+=1
    assistTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if assistTime=5 //effect
    {
      effect=instance_create(x,y,oEffect)
      effect.sprite_index=sHeal
      effect.image_xscale=4
      effect.image_yscale=4
      effect.image_speed=0.25
      effect=instance_create(MMX_X,MMX_Y,oEffect)
      effect.sprite_index=sHeal
      effect.image_xscale=4
      effect.image_yscale=4
      effect.image_speed=0.25
      effect=instance_create(zero_X,zero_Y,oEffect)
      effect.sprite_index=sHeal
      effect.image_xscale=4
      effect.image_yscale=4
      effect.image_speed=0.25
    }
    //else if assistTime=35 //attack
    else if assistTime>=35 //attack //60fps change: see the shooter note in oShipEnemyBase's Create (>=: the same at 30fps)
    {
      newBullet=instance_create(x+20,y,oClaireShot)
      newBullet.parent="Assist"
      newBullet.bulletSpeed=12
      newBullet.atkPower=atkPower-10
      newBullet.sprite_index=sJerryTrioAttack
      newBullet.image_speed=0.4
      newBullet.image_xscale=6
      newBullet.image_yscale=6

      effect=instance_create(x,y,oEffect)
      effect.sprite_index=sBomberExplosion
      effect.image_xscale=2
      effect.image_yscale=2
      effect=instance_create(MMX_X,MMX_Y,oEffect)
      effect.sprite_index=sBomberExplosion
      effect.image_xscale=2
      effect.image_yscale=2
      effect=instance_create(zero_X,zero_Y,oEffect)
      effect.sprite_index=sBomberExplosion
      effect.image_xscale=2
      effect.image_yscale=2
      instance_destroy()
    }
  }
}
if type=1 //------------------------------ Jeremy ------------------------------
{
  if assistProg=0 //quickly fly in
  {
    if x<-192
      //x+=16
      x+=16*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    else
      assistProg+=1
  }
  else if assistProg=1
  {
    //assistTime+=1
    assistTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    //x+=4
    x+=4*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if assistTime mod 5=0 //missile drop
    {
      for(i=0;i<10;i+=1)
      {
        if i=0
          newBullet=instance_create(x+160,y+46,oClaireShot)
        else if i=1
          newBullet=instance_create(x+176,y+46,oClaireShot)
        else if i=2
          newBullet=instance_create(x+208,y+46,oClaireShot)
        else if i=3
          newBullet=instance_create(x+320,y+46,oClaireShot)
        else if i=4
          newBullet=instance_create(x+336,y+46,oClaireShot)
        else if i=5
          newBullet=instance_create(x+160,y+75,oClaireShot)
        else if i=6
          newBullet=instance_create(x+176,y+75,oClaireShot)
        else if i=7
          newBullet=instance_create(x+208,y+75,oClaireShot)
        else if i=8
          newBullet=instance_create(x+320,y+75,oClaireShot)
        else if i=9
          newBullet=instance_create(x+336,y+75,oClaireShot)
        newBullet.parent="Assist"
        newBullet.bulletSpeed=10
        newBullet.atkPower=atkPower
        newBullet.sprite_index=sJeremyMissile
        if i>=0 and i<=4
        {
          //newBullet.direction=270
          newBullet._direction=270 //60fps change: see the shooter note in oShipEnemyBase's Create
          newBullet.image_angle=270
        }
        else if i>=5 and i<=9
        {
          //newBullet.direction=305
          newBullet._direction=305 //60fps change: see the shooter note in oShipEnemyBase's Create
          newBullet.image_angle=305
        }
      }
    }
    if x>room_width+2
      instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if type=0 //Jerry
{
  draw_sprite(sMegamanXDashAim,0,MMX_X,MMX_Y)
  draw_sprite(sZeroDash,zeroFrame,zero_X,zero_Y)
}
else if type=1 //Jeremy
{

}
