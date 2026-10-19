#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  //image_angle=direction
  image_angle=_direction //60fps change: see the shooter note in oShipEnemyBase's Create
  if point_distance(x,0,oClaireShip.x,0)<10
  {
    effect=instance_create(x,y,oEffect)
    effect.sprite_index=sRobotExplosion
    effect.image_alpha=0.8
    effect.image_speed=0.55+random(0.1)
    bulDir=90
    for(i=0;i<2;i+=1)
    {
      newBullet=instance_create(x,y,oEnemyShipBulletNormal)
      newBullet.bDestroyIfOffScreen=true
      newBullet.bulletSpeed=5
      //newBullet.direction=bulDir
      newBullet._direction=bulDir //60fps change: see the shooter note in oShipEnemyBase's Create
      bulDir+=180
    }
    instance_destroy()
  }
}
