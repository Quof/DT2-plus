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
spreadTime=30
size=2
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if cSize=0
  size=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  image_angle=direction
  if cSize>0
  {
    spreadTime-=1
    if spreadTime<=0
    {
      cSize-=1
      dir=direction-15
      for(i=0;i<3;i+=1)
      {
        sDiamond=instance_create(x,y,oShroudDiamond)
        sDiamond.damageType="SPIRIT"
        sDiamond.spiritPower=spiritPower
        sDiamond.cSize=cSize
        if cSize=1
        {
          sDiamond.image_xscale=0.66
          sDiamond.image_yscale=0.66
          sDiamond.bulletSpeed=bulletSpeed+1
        }
        else if cSize=0
        {
          sDiamond.image_xscale=0.33
          sDiamond.image_yscale=0.33
          sDiamond.bulletSpeed=bulletSpeed+3
        }
        sDiamond.direction=dir
        dir+=15
        //sDiamond.sAmount=sAmount
      }
      instance_destroy()
    }
  }
}
else
  speed=0
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
