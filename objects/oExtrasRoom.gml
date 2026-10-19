#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
infoRead=0
enemyCount=0
enemySpawn=0

global.hasWindBoots=1 //Can jump
global.hasAwesomeShoes=1 //Can dash
global.hasSuaveToken=1 //Can air dash
global.hasWallGrinder=1 //Can wall jump
global.canUseFire=1
global.canUseWater=1
global.canUseWind=1
global.canUseEarth=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oPlayer1.life=oPlayer1.maxLife
oPlayer1.fireEnergy=oPlayer1.maxFireEnergy
oPlayer1.waterEnergy=oPlayer1.maxWaterEnergy
oPlayer1.windEnergy=oPlayer1.maxWindEnergy
oPlayer1.earthEnergy=oPlayer1.maxEarthEnergy

if infoRead=9 //exit appears
{
  newReadMe=instance_create(512,416,oExtraInfo)
  newReadMe.headerText="The End"
  newReadMe.stringToShow="I know it's not much, but I hope you enjoyed these little snippets about DT3.#Tell me what you think about the short adventure here and if you want,#what would you like to see in DT3?#For some more fun, endless amounts of random enemies will be spawning in this#room in just a moment."
  infoRead+=1
}
else if infoRead=11 //enemy spawning
{
  //enemySpawn+=1
  enemySpawn+=1*gDeltaTime //60fps change: counts 30fps ticks (lands on 1, and on the whole-number spawn times)
  if enemySpawn=1
  {
    with oExtraInfo {instance_destroy()}
  }

  spawnRate=instance_number(oEnemyBase)*3
  if spawnRate<40 {spawnRate=40}
  if enemySpawn>=spawnRate and instance_number(oEnemyBase)<50
  {
    var ranShape,enemyToSpawn;
    ranShape=irandom(6)
    switch ranShape
    {
      case 0: enemyToSpawn=oGoomba; break;
      case 1: enemyToSpawn=oGreenParatroopa; break;
      case 2: enemyToSpawn=oRedParatroopa; break;
      case 3: enemyToSpawn=oFang; break;
      case 4: enemyToSpawn=oDesertSquid; break;
      case 5: enemyToSpawn=oFreakyFlier; break;
      case 6: enemyToSpawn=oFireEye; break;
    }
    newEnemy=instance_create(random(room_width),random(room_height),enemyToSpawn)
    newEnemy.bActive=true
    newEnemy.questType=2
    enemySpawn=irandom(80)+2
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if infoRead=11
{
  draw_set_alpha(1)
  draw_set_color(c_black)
  draw_set_font(fnt_DamageNotice)
  draw_set_halign(fa_left)
  draw_text(view_xview[0]+4,view_yview[0]+368,"Kills:" +string(enemyCount))
}
