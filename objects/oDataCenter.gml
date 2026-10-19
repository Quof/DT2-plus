#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
loadingIncTime=0
greenColor=255
colorChange=0
locDataX=256
locDataY=64
loadingDataX=80
loadingDataYY=96
setPos=loadingDataYY+16
init=0

locationData=global.location
startData=">> INCOMING DATA TRANSMISSION <<"
for(i=0;i<16;i+=1)
{
  loadingData[i]=round(random(899999999999)+100000000000)
  loadingDataY[i]=setPos
  setPos+=11
}
loadingData[2]="ERROR 404"
loadingData[4]="DATA SAVED SUCCESSFULLY"
loadingData[7]="INTERSECTING DATA STRUCTURES FOUND"
loadingData[9]="CAB FILE COULD NOT BE FOUND"
loadingData[10]="WRITING TO DATA FILE"
loadingData[13]="SYSTEM32.CED"
loadingData[14]="IS MISSING"

objective_Full="Current Mission Objective:#"
objective_New=""
objective_Pos=0
if global.gameProgress>=-10 and global.gameProgress<=13
  objective_Full+=string("Find the owner of the IEF#and kick his ass!")
else if global.gameProgress>=14 and global.gameProgress<=16
  objective_Full+=string("Investigate the new world.")
if global.gameProgress>=17 and global.gameProgress<=19
  objective_Full+=string("Find the mayor of Town Toad#and ask him about the area.")
else if global.gameProgress>=20 and global.gameProgress<=22
  objective_Full+=string("Get through the Rumpy Mountains#to the Old Castle in the east.")
else if global.gameProgress>=23 and global.gameProgress<=32
  objective_Full+=string("Investigate the Old Castle and#find out any info for the Toad Town#mayor that you can.")
else if global.gameProgress>=33 and global.gameProgress<=34
  objective_Full+=string("Report back to the Town Town mayor.")
else if global.gameProgress>=35 and global.gameProgress<=37
  objective_Full+=string("Get through the Dark Depths.")
else if global.gameProgress>=38 and global.gameProgress<=41
  objective_Full+=string("Find a key to the door at the#entrance of the Dark Depths.")
else if global.gameProgress=42
  objective_Full+=string("Use the key you found to investigate#what's behind the locked door at#the entrance of the Dark Depths.")
else if global.gameProgress>=43 and global.gameProgress<=45
  objective_Full+=string("Investigate the Diluted Mansion#located within the Dark Depths.")
else if global.gameProgress>=46 and global.gameProgress<=47
  objective_Full+=string("Use the new abilities to get#to the upper floor of the Diluted Mansion.")
else if global.gameProgress>=48 and global.gameProgress<=49
  objective_Full+=string("Run through the rest of the#Diluted Mansion.")
else if global.gameProgress>=50 and global.gameProgress<=58
  objective_Full+=string("Get through Vegetable Garden#while killing as many cute creatures#as possible.")
else if global.gameProgress>=59 and global.gameProgress<=69
  objective_Full+=string("Find a way out of Distortion.")
else if global.gameProgress>=70 and global.gameProgress<=80
  objective_Full+=string("Get through the trap infested#Dusty Ruins, so you can continue south.")
else if global.gameProgress>=81 and global.gameProgress<=85
  objective_Full+=string("Talk to Syrus in Abstracity#and ask if he knows how#to stop the Quick Time Events.")
else if global.gameProgress>=86 and global.gameProgress<=98
  objective_Full+=string("Board the Fright Train to#locate and destroy the device#controlling the Quick Time Events,#thus saving the world from the#horrors of these horrid game inventions.")
else if global.gameProgress>=99 and global.gameProgress<=107
  objective_Full+=string("Find your way through the#West Side Jungle to continue#into The Hideout.")
else if global.gameProgress>=108 and global.gameProgress<=118
  objective_Full+=string("Locate the one who can#break the barrier on the#Black Rock Fortress.#Watch out for mines!")
else if global.gameProgress>=119 and global.gameProgress<=127
  objective_Full+=string("Get to a hotspot within#Distortion so Jeremy can hack#into The Darkness' database.")
else if global.gameProgress>=128 and global.gameProgress<=132
  objective_Full+=string("Make your way through the#Metropolis to locate where X is#being held.")
else if global.gameProgress=133
  objective_Full+=string("Defeat the 4 Robot Masters#to unlock the way to the place#X is being held.")
else if global.gameProgress>=134 and global.gameProgress<=150
  objective_Full+=string("Get through the Fortress to#save X and leave.")
else if global.gameProgress>=151 and global.gameProgress<=153
  objective_Full+=string("Get into the Black Rock Fortress.")
else if global.gameProgress>=154 and global.gameProgress<=181
  objective_Full+=string("Search the Black Rock Fortress#for your friend.")
else if global.gameProgress=182
  objective_Full+=string("Meet up with X at the#Black Rock Fortress.")
else if global.gameProgress>=183 and global.gameProgress<=187
  objective_Full+=string("Head west to search#for more Muffins.")
else if global.gameProgress>=188 and global.gameProgress<=194
  objective_Full+=string("Go into the Windy Caves#and see if a key#can be found in there.")
else if global.gameProgress=195
  objective_Full+=string("Unlock the door at the#Windy Slopes and continue on")
else if global.gameProgress>=196 and global.gameProgress<=204
  objective_Full+=string("Find a way out of Distortion.")
else if global.gameProgress>=205 and global.gameProgress<=206
  objective_Full+=string("Go up the Castle Spire#to look for data to hack.")
else if global.gameProgress>=207 and global.gameProgress<=214
  objective_Full+=string("Continue on through Distortion#to find a way out.")
else if global.gameProgress>=215 and global.gameProgress<=218
  objective_Full+=string("Locate the Air Base in#the Windy Slopes.")
else if global.gameProgress>=219 and global.gameProgress<=220
  objective_Full+=string("Get in the plane to fly#over the Windy Mountains.")
else if global.gameProgress>=221 and global.gameProgress<=225
  objective_Full+=string("Enter the Veiled Detritus.")
else if global.gameProgress>=226 and global.gameProgress<=231
  objective_Full+=string("Unlock the four barriers#leading to the center of#the Veiled Detritus.")
else if global.gameProgress>=232 and global.gameProgress<=241
  objective_Full+=string("Find out what is hidden#within the core of#the Veiled Detritus.")
else if global.gameProgress>=242 and global.gameProgress<=248
  objective_Full+=string("Head to the area#north-west of the Veiled Detritus.")
else if global.gameProgress=249
  objective_Full+=string("Escape the Shady Woods#and get back to Abstracity.")
else if global.gameProgress>=250 and global.gameProgress<=260
  objective_Full+=string("Find a way to unblock Jeremy.")
else if global.gameProgress>=261 and global.gameProgress<=266
  objective_Full+=string("Escape from Distortion.")
else if global.gameProgress>=267 and global.gameProgress<=270
  objective_Full+=string("Get the Muffin inside#the cave to bring#down Phalanx' barrier.")
else if global.gameProgress>=271 and global.gameProgress<=274
  objective_Full+=string("Defeat Phalanx so you can#escape from the cave.")
else if global.gameProgress=275
  objective_Full+=string("Get to Abstracity and see#what The Darkness has done.")
else if global.gameProgress>=276 and global.gameProgress<=278
  objective_Full+=string("Search Abstracity for clues#on where everyone was taken.")
else if global.gameProgress>=279 and global.gameProgress<=280
  objective_Full+=string("Go to your ship in the#Sky Base to fly to#the Secured Data Segment.")
else if global.gameProgress>=281 and global.gameProgress<=323
  objective_Full+=string("Go to the Secured Data Segment#to negotiate a peaceful#agreement with The Darkness.")
else if global.gameProgress>=324 and global.gameProgress<=400
  objective_Full+=string("Get to the center of the#Primary Memory to stop#The Artist from shutting#down The Darkness.")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //60fps change: the refills are per 30fps tick (they were 2x/4x as fast at 60/120fps)
  if oPlayer1.spiritEnergy<oPlayer1.maxSpiritEnergy
    //oPlayer1.spiritEnergy+=1.4
    oPlayer1.spiritEnergy+=1.4*gDeltaTime
  if oPlayer1.fireEnergy<oPlayer1.maxFireEnergy
    //oPlayer1.fireEnergy+=1.2
    oPlayer1.fireEnergy+=1.2*gDeltaTime
  if oPlayer1.waterEnergy<oPlayer1.maxWaterEnergy
    //oPlayer1.waterEnergy+=1.2
    oPlayer1.waterEnergy+=1.2*gDeltaTime
  if oPlayer1.windEnergy<oPlayer1.maxWindEnergy
    //oPlayer1.windEnergy+=1.2
    oPlayer1.windEnergy+=1.2*gDeltaTime
  if oPlayer1.earthEnergy<oPlayer1.maxEarthEnergy
    //oPlayer1.earthEnergy+=1.2
    oPlayer1.earthEnergy+=1.2*gDeltaTime
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if init=1
{
  loadingData[4]="DATA LOADED SUCCESSFULLY"
  init=2
}
//colorChange+=1
//if colorChange>=1 and colorChange<=80
//  greenColor-=0.5
//else if colorChange>=81 and colorChange<=160
//  greenColor+=0.5
//else if colorChange>=161
//  colorChange=0
//60fps change: counts 30fps ticks (Draw runs every frame). A frame belongs to the tick its count rounds up to, so the
//ranges start right after the tick before them (>0, >80) and the reset still waits for the end of tick 161: the same
//161-tick pulse as at 30fps (where this is the same as above)
colorChange+=1*gDeltaTime
if colorChange>0 and colorChange<=80
  greenColor-=0.5*gDeltaTime
else if colorChange>80 and colorChange<=160
  greenColor+=0.5*gDeltaTime
else if colorChange>=161
  colorChange=0
//loading data
draw_set_color(make_color_rgb(0,greenColor,0))
draw_set_font(fnt_EnemyScan)
draw_set_alpha(0.75)
draw_set_halign(fa_center)
draw_text(locDataX,locDataY-16,"<CURRENT LOCATION>")
draw_text(locDataX,locDataY,locationData)
draw_set_color(make_color_rgb(0,255,0))
draw_set_halign(fa_left)
draw_text(loadingDataX,loadingDataYY,startData)

//loadingIncTime+=1
loadingIncTime+=1*gDeltaTime //60fps change: counts 30fps ticks (Draw runs every frame), so the lines scroll every 6 ticks
for(i=0;i<16;i+=1)
{
  draw_text(loadingDataX,loadingDataY[i],">")
  draw_text(loadingDataX+6,loadingDataY[i],loadingData[i])
  if loadingIncTime>=6
  {
    loadingDataY[i]-=11
    if loadingDataY[i]<=109
      loadingDataY[i]=109+(11*16)
  }
}
if loadingIncTime>=6
  loadingIncTime=0

//objective data
draw_set_font(fnt_ScanData)
draw_set_halign(fa_right)
if objective_Pos>=0
{
  if objective_Pos<string_length(objective_Full)
  {
    draw_text(496,80,objective_New)
    //objective_Pos+=1
    //objective_New+=string_char_at(objective_Full,objective_Pos)
    if gDeltaDoTicks //60fps change: one letter per 30fps tick (Draw runs every frame)
    {
      objective_Pos+=1
      objective_New+=string_char_at(objective_Full,objective_Pos)
    }
  }
  else
    draw_text(496,80,objective_Full)
}
#define KeyPress_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cheatMenu=get_string("Input cheat code.","If only you knew")
if cheatMenu="cheesecake"
{
  global.debugMenu=true
  show_message("Debug Menu Activated!")
}
