#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeAlpha=0
fadeColor=c_white

ySpacing=43
xSpawn=room_width+32

ySpawn[0]=83
ySpawn[1]=126
ySpawn[2]=169
ySpawn[3]=212
ySpawn[4]=255
ySpawn[5]=298
ySpawn[6]=341
topSpawnY=8
bottomSpawnY=room_height+32

bgColor=255

/*
global.gameProgress=7
sceneProgress=4
sceneDelay=1640
sceneDelay=1740
for(i=0;i<3;i+=1)
{
  background_blend[i]=make_color_rgb(255,95,95)
}*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//60fps change: sceneDelay counts 30fps ticks (+=1*gDeltaTime), so the "=N" spawn times land on their ticks (on the
//tick's last frame). The waits for a boss (or ship) to be gone check a range instead of one value (>=N, or N up to where
//they send the count; the same as =N at 30fps), so the level still goes on if the frame rate changed mid-count (they set
//the count back to a whole number). Something done every tick in ticks N-M runs from right after tick N-1 (>N-1).
if global.gameProgress<=6 //Introduce shooter mechanics
{
  if sceneProgress=0
  {
    global.gamePaused=true
    stopPlayer()
    sceneProgress+=1
  }
  else if sceneProgress=1
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=2 and bWaitForInput=false
    msgCreate("You sure you got this?",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=3 and bWaitForInput=false
    msgCreate("Definitely.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=4 and bWaitForInput=false
    msgCreate("Well if you want any help, just call on me.#I'm sure I can work some magic in some way.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=5 and bWaitForInput=false
    msgCreate("I can do the same.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("Thanks you guys.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("Now go hit'em hard!",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=8
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    //if sceneDelay=1
    if sceneDelay=1*gDeltaTime
    {
      tutPan=instance_create(room_width/2,70,oTutorialPanel)
      tutPan.sprite_index=sTutShooter
    }
    //else if sceneDelay>=2 and sceneDelay<=10
    //  tutPan.image_alpha+=0.1
    //else if sceneDelay=11
    else if sceneDelay>1 and sceneDelay<=10
      tutPan.image_alpha+=0.1*gDeltaTime
    else if sceneDelay>=11
      bWaitForInput=true
  }
  else if sceneProgress=9
  {
    //tutPan.image_alpha-=0.1
    tutPan.image_alpha-=0.1*gDeltaTime
    if tutPan.image_alpha<=0
    {
      with oTutorialPanel
        instance_destroy()
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=10
  {
    sceneProgress=0
    if global.gameProgress<7
      global.gameProgress=7
    global.gamePaused=false
  }
}
else if global.gameProgress>=7 //------------------------------ shooter level ------------------------------
{
  if global.gamePaused=false
  {
    if sceneProgress=0
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=15 //---------- line formation ----------
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
      else if sceneDelay=25
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
      else if sceneDelay=35
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
      else if sceneDelay=45
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
      else if sceneDelay=75 //---------- line formation ----------
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
      else if sceneDelay=85
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
      else if sceneDelay=95
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
      else if sceneDelay=105
      {
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
        newShip.itemDrop=1
      }
      else if sceneDelay=145
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=170
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=280 //---------- V formation ----------
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
      else if sceneDelay=295
      {
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=310
      {
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip.itemDrop=1
      }
      else if sceneDelay=325
      {
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=340
      {
        newShip=instance_create(xSpawn,ySpawn[0],oEyeShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[6],oEyeShip)
        //newShip.direction=180; newShip.itemDrop=1
        newShip._direction=180; newShip.itemDrop=1 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=560 //---------- Boss: Fish ----------
      {
        newShip=instance_create(xSpawn-10,ySpawn[3],oBossFish)
        newShip.itemDrop=1
      }
      //else if sceneDelay=570
      else if sceneDelay>=570
      {
        if instance_exists(oBossFish)
          sceneDelay=565
        else
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=40 //---------- single enemy approach ----------
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=2
      }
      //else if sceneDelay=50
      else if sceneDelay>=50 and sceneDelay<55
      {
        if instance_exists(oBioShip)
          sceneDelay=45
        else
          sceneDelay=55
      }
      else if sceneDelay=75
      {
        newShip=instance_create(xSpawn,ySpawn[2],oBioShip)
        newShip=instance_create(xSpawn,ySpawn[4],oBioShip)
      }
      //else if sceneDelay=85
      else if sceneDelay>=85 and sceneDelay<90
      {
        if instance_exists(oBioShip)
          sceneDelay=80
        else
          sceneDelay=90
      }
      else if sceneDelay=100 //---------- line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBioShip)
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      }
      else if sceneDelay=110
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      else if sceneDelay=120
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      else if sceneDelay=130
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      else if sceneDelay=250 //---------- line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBioShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
      }
      else if sceneDelay=260
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
      else if sceneDelay=270
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
      else if sceneDelay=280
      {
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
        newShip.itemDrop=1
      }
      else if sceneDelay=400 //---------- double formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=410
      {
        newShip=instance_create(xSpawn,ySpawn[6],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=420
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
      else if sceneDelay=430
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
      else if sceneDelay=470 //---------- cross formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
      }
      else if sceneDelay=500
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=530
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
      }
      else if sceneDelay=550
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=680 //---------- V formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[2]-ySpacing/2,oBioShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[4]+ySpacing/2,oBioShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=730
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=900 //---------- Boss: Tata ----------
      {
        newShip=instance_create(xSpawn-10,ySpawn[3],oBossTata)
        newShip.itemDrop=2
      }
      //else if sceneDelay=910
      else if sceneDelay>=910
      {
        if instance_exists(oBossTata)
          sceneDelay=905
        else
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=50 //---------- line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=65
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=80
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip.itemDrop=1
      }
      else if sceneDelay=140 //---------- double break line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=160
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=180
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=200
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=220
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=240
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=260
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=280
      {
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip.itemDrop=1
      }
      else if sceneDelay=370 //---------- arc line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0],oBlueShip)
        //newShip.direction=225
        newShip._direction=225 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[6],oBlueShip)
        //newShip.direction=135
        newShip._direction=135 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=450
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=190
        newShip._direction=190 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=170
        newShip._direction=170 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip.itemDrop=2
      }
      else if sceneDelay=560 //---------- cluster formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[3],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=590
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=620
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=760 //---------- vertical line formation ----------
      {
        for(i=0;i<6;i+=1)
        {
          newShip=instance_create(xSpawn,ySpawn[i],oEyeShip)
          if i=3
            newShip.itemDrop=2
          newShip=instance_create(xSpawn,ySpawn[i]+ySpacing/2,oEyeShip)
        }
        newShip=instance_create(xSpawn,ySpawn[6],oEyeShip)
      }
      else if sceneDelay=930 //---------- Boss: Shaker ----------
      {
        newShip=instance_create(xSpawn-10,ySpawn[3],oBossShaker)
        newShip.itemDrop=1
      }
      //else if sceneDelay=940
      else if sceneDelay>=940
      {
        if instance_exists(oBossShaker)
          sceneDelay=935
        else
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=3
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=50 //---------- V formation ----------
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
      else if sceneDelay=100
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBioShip)
        newShip=instance_create(xSpawn,ySpawn[5],oBioShip)
      }
      else if sceneDelay=190 //---------- line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[2],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[4],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=220
      {
        newShip=instance_create(xSpawn,ySpawn[2],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[4],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=250
      {
        newShip=instance_create(xSpawn,ySpawn[2],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[4],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=290 //---------- V formation ----------
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
      else if sceneDelay=360
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
        newShip.itemDrop=1
      }
      else if sceneDelay=450 //---------- split formation ----------
      {
        newShip=instance_create(420,topSpawnY,oBlueShip)
        //newShip.direction=270
        newShip._direction=270 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(420,bottomSpawnY,oBlueShip)
        //newShip.direction=90
        newShip._direction=90 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=540
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
      }
      else if sceneDelay=670 //---------- V line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0],oBioShip)
        newShip=instance_create(xSpawn,ySpawn[1]+ySpacing/2,oBioShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[4]+ySpacing/2,oBioShip)
        newShip=instance_create(xSpawn,ySpawn[6],oBioShip)
      }
      else if sceneDelay=820 //---------- line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0]+ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[6]-ySpacing/2,oEyeShip)
      }
      else if sceneDelay=840
      {
        newShip=instance_create(xSpawn,ySpawn[0]+ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[6]-ySpacing/2,oEyeShip)
      }
      else if sceneDelay=860
      {
        newShip=instance_create(xSpawn,ySpawn[0]+ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[6]-ySpacing/2,oEyeShip)
      }
      else if sceneDelay=880
      {
        newShip=instance_create(xSpawn,ySpawn[0]+ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[6]-ySpacing/2,oEyeShip)
      }
      else if sceneDelay=980 //---------- V line formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
      }
      else if sceneDelay=1080
      {
        newShip=instance_create(xSpawn,ySpawn[2],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[4],oBirdShip)
      }
      else if sceneDelay=1250 //---------- Boss: Mk II ----------
      {
        newShip=instance_create(xSpawn-10,ySpawn[3],oBossMkII)
        newShip.itemDrop=2
      }
      //else if sceneDelay=1260
      else if sceneDelay>=1260
      {
        if instance_exists(oBossMkII)
          sceneDelay=1255
        else
        {
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
    else if sceneProgress=4
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime
      if sceneDelay=50 //---------- continual formation ----------
        newShip=instance_create(xSpawn,ySpawn[0],oBirdShip)
      else if sceneDelay=70
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
      else if sceneDelay=90
        newShip=instance_create(xSpawn,ySpawn[2],oBirdShip)
      else if sceneDelay=110
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
      else if sceneDelay=130
        newShip=instance_create(xSpawn,ySpawn[4],oBirdShip)
      else if sceneDelay=150
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
      else if sceneDelay=170
        newShip=instance_create(xSpawn,ySpawn[6],oBirdShip)
      else if sceneDelay=270
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=190
        newShip._direction=190 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip.itemDrop=2
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=170
        newShip._direction=170 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=300
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=190
        newShip._direction=190 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=170
        newShip._direction=170 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=400
        newShip=instance_create(xSpawn,ySpawn[6],oBirdShip)
      else if sceneDelay=420
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
      else if sceneDelay=440
        newShip=instance_create(xSpawn,ySpawn[4],oBirdShip)
      else if sceneDelay=460
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
        newShip.itemDrop=1
      }
      else if sceneDelay=480
        newShip=instance_create(xSpawn,ySpawn[2],oBirdShip)
      else if sceneDelay=500
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
      else if sceneDelay=520
        newShip=instance_create(xSpawn,ySpawn[0],oBirdShip)
      else if sceneDelay=640 //---------- cluster formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0],oBeetleShip)
        //newShip.direction=190
        newShip._direction=190 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[6],oBeetleShip)
        //newShip.direction=170
        newShip._direction=170 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip=instance_create(xSpawn,ySpawn[3]-ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[3]+ySpacing/2,oEyeShip)
      }
      else if sceneDelay=680
      {
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
      }
      else if sceneDelay=720
      {
        newShip=instance_create(xSpawn,ySpawn[2]-ySpacing/2,oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[4]+ySpacing/2,oEyeShip)
      }
      else if sceneDelay=760
      {
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      }
      else if sceneDelay=840 //---------- tri formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[0],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
        newShip.itemDrop=1
        newShip=instance_create(xSpawn,ySpawn[6],oBirdShip)
      }
      else if sceneDelay=890
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=960
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=1010
      {
        newShip=instance_create(xSpawn,ySpawn[1],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
      }
      else if sceneDelay=1070
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=2
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
      }
      else if sceneDelay=1150
      {
        newShip=instance_create(xSpawn,ySpawn[3],oBirdShip)
        newShip=instance_create(xSpawn,ySpawn[1],oBioShip)
        newShip.itemDrop=2
        newShip=instance_create(xSpawn,ySpawn[5],oBioShip)
        newShip.itemDrop=2
      }
      else if sceneDelay=1290 //---------- all ship formation ----------
      {
        newShip=instance_create(xSpawn,ySpawn[1],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[2],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=2
        newShip=instance_create(xSpawn,ySpawn[4],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[5],oBirdShip)
      }
      else if sceneDelay=1410
      {
        newShip=instance_create(xSpawn,ySpawn[5],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[4],oBlueShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[3],oBioShip)
        newShip.itemDrop=2
        newShip=instance_create(xSpawn,ySpawn[2],oBeetleShip)
        //newShip.direction=180
        newShip._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
        newShip=instance_create(xSpawn,ySpawn[1],oBirdShip)
      }
      else if sceneDelay=1480
      {
        newShip=instance_create(xSpawn,ySpawn[2],oEyeShip)
        newShip=instance_create(xSpawn,ySpawn[4],oEyeShip)
      }
      //else if sceneDelay>=1700 and sceneDelay<=1780 //---------- darken sky with red ----------
      else if sceneDelay>1699 and sceneDelay<=1780 //---------- darken sky with red ----------
      {
        //bgColor-=2
        bgColor-=2*gDeltaTime
        for(i=0;i<3;i+=1)
        {
          background_blend[i]=make_color_rgb(255,bgColor,bgColor)
        }
      }
      else if sceneDelay=1810 //---------- Boss: Big Core ----------
        newShip=instance_create(xSpawn-10,ySpawn[3],oBossBigCore)
      //else if sceneDelay=1820
      else if sceneDelay>=1820
      {
        if instance_exists(oBossBigCore)
          sceneDelay=1815
        else
        {
          global.gamePaused=true
          sceneDelay=0
          sceneProgress+=1
        }
      }
    }
  }
  if sceneProgress=5 //-------------------- level end start --------------------
  {
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=20
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
  else if sceneProgress=6 and bWaitForInput=false
    msgCreate("Good job Claire!",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=7 and bWaitForInput=false
    msgCreate("Thanks.",1,oMessageCutscene,global.mainCharacters[3])
  else if sceneProgress=8 and bWaitForInput=false
    msgCreate("We've closed in on the source of the disturbance.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=9 and bWaitForInput=false
    msgCreate("We're all ready.",1,oMessageCutscene,global.mainCharacters[0])
  else if sceneProgress=10 and bWaitForInput=false
    msgCreate("Okay, I'll beam you all down to the place.#I think it's best if I stay here with my laptop and#provide intel for you.",1,oMessageCutscene,global.mainCharacters[1])
  else if sceneProgress=11
  {
    fadeColor=c_black
    if fadeAlpha<1
      //fadeAlpha+=0.02
      fadeAlpha+=0.02*gDeltaTime
    else if fadeAlpha>=1
      sceneProgress+=1
  }
  else if sceneProgress=12
  {
    global.saveOnAuto=1
    if global.gameProgress<8
      global.gameProgress=8
    global.lvlComplete[14]=1
    if global.currentScore>global.lvlScore[14]
      global.lvlScore[14]=global.currentScore
    transition_steps=30
    transition_kind=20
    //room_goto(rWorldMap)
    room_goto_fixed(rWorldMap) //60fps change: the transition lasts as long as at 30fps (room_goto_fixed)
  }
}

keyWaitForInput()

//if keyboard_check_pressed(ord("M")) //------------------------------ cutscene skip ------------------------------
if keyboard_check_pressed(ord("M")) or scrPadPressed(13) //------------------------------ cutscene skip ------------------------------ //gamepad change: and the gamepad (scrGamepadInit)
{
  if global.gameProgress<=6
  {
    sceneDelay=0
    bWaitForInput=false
    with oTutorialPanel
      instance_destroy()
    with oMessageCutscene
      instance_destroy()
    sceneProgress=10
  }
  else if global.gameProgress>=7
  {
    if sceneProgress>=6
    {
      sceneDelay=0
      bWaitForInput=false
      with oMessageCutscene
        instance_destroy()
      sceneProgress=11
    }
  }
}
//loop sun
if background_x[1]<-160
  background_x[1]=room_width+1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)
}
