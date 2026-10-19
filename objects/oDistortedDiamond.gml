#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.15
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.crystalNum[cNum]=1
  instance_destroy()
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//4500 points total per level from Diamonds
//chain time
if oHUD.killChainFadeTime>0
{
  oHUD.killChainFadeTime=oPlayer1.chainingTime
  oHUD.killChainAlpha=1
}
playSound(global.snd_SkillCapsule,0,0.78)
effect_create_above(ef_firework,x,y,0,make_color_rgb(random(255),random(255),random(255)))
global.currentCrystals+=1
global.consecCry+=1
pointWorth=300*global.consecCry
global.currentScore+=pointWorth
if global.optShowPointsEarned=true
{
  newAward=instance_create(x,bbox_bottom-(sprite_height/2),oKillAward)
  newAward.pointValue=pointWorth
}
global.crystalNum[cNum]=1
instance_destroy()
