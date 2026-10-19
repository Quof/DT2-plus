#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sCShipCollision
image_speed=0.15

//variables pertaining to the character's status
maxLife=100
life=maxLife
atkPower=100
chargePower=0
jerryEnergyMax=1000
jeremyEnergyMax=1000
jerryEnergy=jerryEnergyMax
jeremyEnergy=jeremyEnergyMax

shotType=0 //0: hold to charge, 1: hold for rapid fire
rapidDelay=0
multipleShot=0

normalSpd=6
focusSpd=2
moveSpd=normalSpd

bCanTakeDamage=true
damageTime=0

propFrame=0
chargeFrame=0
multiple=0
mult[0]=noone

killCombo=0
comboTime=0

identifier=instance_create(mouse_x,mouse_y,oIdentifier) //follow mouse target
identifier.followTarget=oClaireShip
helpTut=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//check max life
if life>maxLife
  life=maxLife

if jerryEnergy>jerryEnergyMax
  jerryEnergy=jerryEnergyMax
else
  //jerryEnergy+=1
  jerryEnergy+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create

if jeremyEnergy>jeremyEnergyMax
  jeremyEnergy=jeremyEnergyMax
else
  //jeremyEnergy+=1
  jeremyEnergy+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create

//death
if life<=0
{
  if !instance_exists(oShipGameOver)
  {
    stopLoopingSounds()
    gameOver=instance_create(0,0,oShipGameOver)
  }
}

effectAmt=irandom_range(3,4)
//for(i=0;i<effectAmt;i+=1)
if gDeltaDoTicks for(i=0;i<effectAmt;i+=1) //60fps change: see the shooter note in oShipEnemyBase's Create (one puff per 30fps tick)
{
  effect=instance_create(x-24+irandom(4),y-5+irandom(10),oEffect)
  effect.sprite_index=sXshotEffect2
  effect.image_alpha=0.3
  effect.image_speed=0.3+random(0.1)
  effect.xSpd=random_range(-5,-1)
}

//animation frames
//if oGame.time mod 2=0
if oGame.time mod (2/gDeltaTime)=0 //60fps change: see the shooter note in oShipEnemyBase's Create
{
  propFrame+=1
  if propFrame=4
    propFrame=0

  chargeFrame+=1
  if chargeFrame=11
    chargeFrame=0
}

if global.gamePaused=false
{
  //****************************** CONTROLS ******************************
  //key "focus"
  //if (keyboard_check(ord(global.ctrlFire))) or keyboard_check(vk_space)
  if (keyboard_check(ord(global.ctrlFire))) or keyboard_check(vk_space) or scrPadHeld(6) //gamepad change: and the gamepad (scrGamepadInit)
  {
    bFocus=true
    moveSpd=focusSpd
  }
  else
  {
    bFocus=false
    moveSpd=normalSpd
  }
  //key left
  //if (keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left)) and x>20
  if (keyboard_check(ord(global.ctrlLeft)) or keyboard_check(vk_left) or scrPadHeld(1)) and x>20 //gamepad change: and the gamepad (scrGamepadInit)
  {
    //x-=moveSpd
    x-=moveSpd*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  //key right
  //if (keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right)) and x<room_width-20
  if (keyboard_check(ord(global.ctrlRight)) or keyboard_check(vk_right) or scrPadHeld(2)) and x<room_width-20 //gamepad change: and the gamepad (scrGamepadInit)
  {
    //x+=moveSpd
    x+=moveSpd*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  //key up
  //if (keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up)) and y>60
  if (keyboard_check(ord(global.ctrlUp)) or keyboard_check(vk_up) or scrPadHeld(3)) and y>60 //gamepad change: and the gamepad (scrGamepadInit)
  {
    //y-=moveSpd
    y-=moveSpd*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }
  //key down
  //if (keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down)) and y<room_height-20
  if (keyboard_check(ord(global.ctrlDown)) or keyboard_check(vk_down) or scrPadHeld(4)) and y<room_height-20 //gamepad change: and the gamepad (scrGamepadInit)
  {
    //y+=moveSpd
    y+=moveSpd*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
  }

  //move multiples
  if multiple>0
  {
    if multiple<=8
    {
      mDir=0
      for(i=0;i<multiple;i+=1)
      {
        //mult[i].x=x+lengthdir_x(40,mDir-(oGame.time*6))
        mult[i].x=x+lengthdir_x(40,mDir-(oGame.time*gDeltaTime*6))
        //mult[i].y=y+lengthdir_y(40,mDir-(oGame.time*6))
        mult[i].y=y+lengthdir_y(40,mDir-(oGame.time*gDeltaTime*6))
        mDir+=360/multiple
      }
    }
    else
    {
      //First Row
      mDir=0
      for(i=0;i<8;i+=1)
      {
        //mult[i].x=x+lengthdir_x(40,mDir-(oGame.time*6))
        mult[i].x=x+lengthdir_x(40,mDir-(oGame.time*gDeltaTime*6))
        //mult[i].y=y+lengthdir_y(40,mDir-(oGame.time*6))
        mult[i].y=y+lengthdir_y(40,mDir-(oGame.time*gDeltaTime*6))
        mDir+=45
      }
      //Second Row
      mDir=0
      for(i=8;i<multiple;i+=1)
      {
        //mult[i].x=x+lengthdir_x(64,mDir+(oGame.time*6))
        mult[i].x=x+lengthdir_x(64,mDir+(oGame.time*gDeltaTime*6))
        //mult[i].y=y+lengthdir_y(64,mDir+(oGame.time*6))
        mult[i].y=y+lengthdir_y(64,mDir+(oGame.time*gDeltaTime*6))
        mDir+=360/(multiple-8)
      }
    }
  }

  //if (keyboard_check_pressed(ord(global.ctrlDashRight))) //shot type change
  if (keyboard_check_pressed(ord(global.ctrlDashRight)) or scrPadPressed(11)) //shot type change //gamepad change: and the gamepad (scrGamepadInit)
  {
    if shotType=0
      shotType=1
    else
      shotType=0
  }

  //shoot
  //if (keyboard_check(ord(global.ctrlJump))) //charge shot
  if (keyboard_check(ord(global.ctrlJump)) or scrPadHeld(5)) //charge shot //gamepad change: and the gamepad (scrGamepadInit)
  {
    if shotType=0 //charge
    {
      if chargePower<100
        //chargePower+=4
        chargePower+=4*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    }
    else if shotType=1 //rapid
    {
      //rapidDelay-=1
      rapidDelay-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      if rapidDelay<=0
      {
        multipleShot=1
        playSound(global.snd_BulletBillShot,0,0.85)
        newBullet=instance_create(x+6,y-1,oClaireShot)
        newBullet.parent="Normal"
        newBullet.bulletSpeed=13
        newBullet.atkPower=atkPower
        rapidDelay=4
      }
    }
  }

  //if (keyboard_check_released(ord(global.ctrlJump))) and chargePower>0 and shotType=0 //release shot
  if (keyboard_check_released(ord(global.ctrlJump)) or scrPadReleased(5)) and chargePower>0 and shotType=0 //release shot //gamepad change: and the gamepad (scrGamepadInit)
  {
    multipleShot=1
    newBullet=instance_create(x+6,y-1,oClaireShot)
    newBullet.parent="Normal"
    if chargePower<20
    {
      newBullet.bulletSpeed=13
      newBullet.atkPower=round(atkPower+chargePower)
      playSound(global.snd_BulletBillShot,0,0.85)
    }
    else if chargePower>=20 and chargePower<=59
    {

      newBullet.sprite_index=sCShot2
      newBullet.bulletSpeed=16
      newBullet.atkPower=round(atkPower+(chargePower*2))
      playSound(global.snd_BulletBillShot,0,0.9)
    }
    else if chargePower>=60 and chargePower<=99
    {
      newBullet.sprite_index=sCShot2
      newBullet.bulletSpeed=17
      newBullet.atkPower=round(atkPower+(chargePower*4))
      playSound(global.snd_BulletBillShot,0,0.9)
    }
    else if chargePower>=100
    {
      newBullet.sprite_index=sCShot3
      newBullet.bulletSpeed=20
      newBullet.atkPower=round(atkPower*0.75)
      playSound(global.snd_BulletBillShot,0,0.95)
    }
  }

  if multipleShot=1
  {
    //multiple shot
    for(i=0;i<multiple;i+=1)
    {
      newBullet=instance_create(mult[i].x,mult[i].y,oClaireShot)
      newBullet.parent="Missile"
      newBullet.bulletSpeed=15

      if chargePower<20
      {
        newBullet.sprite_index=sCShot4
        newBullet.atkPower=round((atkPower+chargePower)/5)
      }
      else if chargePower>=20 and chargePower<=59
      {
        newBullet.sprite_index=sCShot5
        newBullet.atkPower=round((atkPower+chargePower)/3)
      }
      if chargePower>=60 and chargePower<=99
      {
        newBullet.sprite_index=sCShot5
        newBullet.atkPower=round((atkPower+chargePower)/1.5)
      }
      else if chargePower>=100
      {
        newBullet.sprite_index=sCShot6
        newBullet.atkPower=atkPower+chargePower
      }
    }
    multipleShot=0
    chargePower=0
  }

  //Jerry ----------------------------------------------------------------------
  //if (keyboard_check_pressed(ord(global.ctrlWind))) and jerryEnergy>=jerryEnergyMax
  if (keyboard_check_pressed(ord(global.ctrlWind)) or scrPadPressed(8)) and jerryEnergy>=jerryEnergyMax //gamepad change: and the gamepad (scrGamepadInit)
  {
    assist=instance_create(-28,shooterFieldMidY,oAssistShot)
    assist.type=0; assist.atkPower=atkPower
    jerryEnergy=0
  }
  //Jeremy ----------------------------------------------------------------------
  //if (keyboard_check_pressed(ord(global.ctrlEarth))) and jeremyEnergy>=jeremyEnergyMax
  if (keyboard_check_pressed(ord(global.ctrlEarth)) or scrPadPressed(9)) and jeremyEnergy>=jeremyEnergyMax //gamepad change: and the gamepad (scrGamepadInit)
  {
    assist=instance_create(-410,48,oAssistShot)
    assist.sprite_index=sJeremyShip
    assist.type=1; assist.atkPower=atkPower
    jeremyEnergy=0
  }

  //damage time
  if damageTime>0
  {
    //damageTime-=1
    damageTime-=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    if gDeltaDoTicks //60fps change (added): the flicker toggles once per 30fps tick
    {
    if image_alpha=0.75
      image_alpha=0.25
    else
      image_alpha=0.75
    }
    //if damageTime=0
    if damageTime<=0 //60fps change: the same as =0 at 30fps, and it still ends if the frame rate changed mid-count
    {
      image_alpha=1
      bCanTakeDamage=true
    }
  }

  //combo time
  if killCombo>0
  {
    if instance_exists(oShipEnemyBase)
    {
      if instance_exists(oBossBigCore)
        //comboTime+=0.5
        comboTime+=0.5*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
      else
        //comboTime+=1
        comboTime+=1*gDeltaTime //60fps change: see the shooter note in oShipEnemyBase's Create
    }
    if comboTime=60
    {
      comboTime=0
      killCombo=0
    }
  }

  //pick up items
  if instance_exists(oShipPowerUp)
  {
    if point_distance(x,y,oShipPowerUp.x,oShipPowerUp.y)<24
    {
      findPowerUp=instance_nearest(x,y,oShipPowerUp)

      effect=instance_create(oClaireShip.x,oClaireShip.y,oEffect)
      effect.sprite_index=sHeal; effect.image_xscale=1.2; effect.image_yscale=1.2
      effect.image_speed=0.8;effect.followID=id
      effect.xFollow=0; effect.yFollow=0

      if findPowerUp.type=1
      {
        mult[multiple]=instance_create(-32,-32,oShipMultiple)
        multiple+=1
      }
      else if findPowerUp.type=2
      {
        life+=10
        if life>maxLife
          life=maxLife
      }
      with findPowerUp
        instance_destroy()
    }
  }

  //Bring up help tutorial ----------------------------------------------------------------------
  /*if (keyboard_check_pressed(ord("Q"))) and helpTut=0
  {
    global.gamePaused=true
    helpTut=1
  }*/
}

if global.debugMenu=true //debug commands
{
  if keyboard_check_pressed(ord("I"))
  {
    life=maxLife
    jerryEnergy=jerryEnergyMax
    jeremyEnergy=jeremyEnergyMax
  }
  else if keyboard_check_pressed(ord("O"))
  {
    mult[multiple]=instance_create(-32,-32,oShipMultiple)
    multiple+=1
  }
}
#define Mouse_53
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  newTest=instance_create(mouse_x,mouse_y,oBirdShip)
  //newTest.direction=180
  newTest._direction=180 //60fps change: see the shooter note in oShipEnemyBase's Create
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  debugMenu=show_menu_pos(320,240,"[0] Change Game Progress|[1] Change Life/Spirit...|[2] Change Items...|[3] Change Current Status...|[4] Teleport...|[5] Kill All|[6] Change Spell Level|[7] Set to test values|[8] Go to Test Room|[9] Change Stats|[10] Pause/Unpause|[11] Room Speed|[12]Change Shroud Warn",-1)
  //==================== CHANGE GAME PROGRESS ====================
  if debugMenu=0
    global.gameProgress=get_integer("Change Game Progress",global.gameProgress)
  //==================== CHANGE LIFE/SPIRIT... ====================
  else if debugMenu=1
  {
    status=show_menu_pos(320,240,"[0] Change Max Life|[1] Change Max Elemental Energy",-1)
    if status=0
    {
      valueChange=get_integer("Change Max Life",maxLife)
      maxLife=valueChange
      fullhealth=show_question("Restore Health?")
      if fullhealth=true
        life=maxLife
      if life>maxLife
        life=maxLife
    }
    else if status=1
    {
      valueChange=get_integer("Change Max Spirit",maxFireEnergy)
      maxFireEnergy=valueChange
      maxWaterEnergy=valueChange
      maxWindEnergy=valueChange
      maxEarthEnergy=valueChange
      if fireEnergy>maxFireEnergy
        fireEnergy=maxFireEnergy
      if waterEnergy>maxWaterEnergy
        waterEnergy=maxWaterEnergy
      if windEnergy>maxWindEnergy
        windEnergy=maxWindEnergy
      if earthEnergy>maxEarthEnergy
        earthEnergy=maxEarthEnergy
    }
  }
  //==================== CHANGE ITEMS... ====================
  else if debugMenu=2
  {
    items=show_menu_pos(320,240,"[0] Suave Token",-1)
    if items=0
      global.hasSuaveToken=get_integer("Suave Token#0:Remove, 1:Equip",global.hasSuaveToken)
  }
  //==================== CHANGE CURRENT STATUS... ====================
  else if debugMenu=3
  {
    itemFlags=show_menu_pos(320,240,"[0] Restore Fire|[1] Restore Water|[2] Restore Wind|[3] Restore Earth|[4] Restore All",-1)
    if itemFlags=0
      fireEnergy=maxFireEnergy
    else if itemFlags=1
      waterEnergy=maxWaterEnergy
    else if itemFlags=2
      windEnergy=maxWindEnergy
    else if itemFlags=3
      earthEnergy=maxEarthEnergy
    else if itemFlags=4
    {
      fireEnergy=maxFireEnergy
      waterEnergy=maxWaterEnergy
      windEnergy=maxWindEnergy
      earthEnergy=maxEarthEnergy
    }
  }
  //==================== TELEPORT ====================
  else if debugMenu=4
  {
    teleport=show_menu_pos(320,240,"[0] X/Y Position|[1] Change Rooms",-1)
    if teleport=0
    {
      xCoord=get_integer("Enter target x coordinate.",x)
      yCoord=get_integer("Enter target y coordinate.",y)
      x=xCoord
      y=yCoord
    }
    else if teleport=1
    {
      teleport=get_integer("Teleport - 0 for cancel#Note: Will crash the game if roomID does not exist.",room)
      if teleport!=0
      {
        xCoord=get_integer("Enter target x coordinate.",0)
        yCoord=get_integer("Enter target y coordinate.",0)
        global.newMapX=xCoord
        global.newMapY=yCoord
        writeToPlayerGlobals()
        room_goto(teleport)
      }
    }
  }
  //==================== KILL ALL ====================
  else if debugMenu=5
  {
    destroy=show_question("This will destroy all objects that extend the oEnemyBase object. Kill?")
    if destroy=true
      with oEnemyBase
        instance_destroy()
  }
  //==================== CHANGE SPELL LEVEL ====================
  else if debugMenu=6
  {
    spellLevel=get_integer("Change Spell Level",1)
    global.techLv=spellLevel
    global.fireLv=spellLevel
    global.waterLv=spellLevel
    global.windLv=spellLevel
    global.earthLv=spellLevel
  }
  //==================== TEST VALUES ====================
  else if debugMenu=7
  {
    setValues=show_question("This will set all relevant variables to the current progress of the game. Proceed?")
    if setValues=true
    {

    }
  }
  //==================== GO TO TEST ROOM ====================
  else if debugMenu=8
  {
    setValues=show_question("This will bring you to the testing room. Proceed?")
    if setValues=true
    {
      writeToPlayerGlobals()
      room_goto(rTestRoom)
    }
  }
  //==================== CHANGE STATS ====================
  else if debugMenu=9
  {
    statType=show_menu_pos(320,240,"[0] Atk Power|[1] Atk Defense",-1)
    if statType=0
      atkPower=get_integer("Change Attack Power",atkPower)
    else if statType=1
      atkDefense=get_integer("Change Attack Defense",atkDefense)
  }
  //==================== PAUSE/UNPAUSE ====================
  else if debugMenu=10
  {
    if global.gamePaused=0
      global.gamePaused=1
    else
      global.gamePaused=0
  }
  //==================== ROOM SPEED ====================
  else if debugMenu=11
  {
    room_speed=get_integer("Change Room Speed.",room_speed)
  }
  //==================== CHANGE SHROUD WARN ====================
  else if debugMenu=12
  {
    global.shroudThreat=get_integer("Change Shroud threat level.",global.shroudThreat)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sClaireShip,0,x,y,1,1,0,c_white,image_alpha)
draw_sprite(sCShipCollision,image_index,x,y)
draw_sprite_ext(sCShipPropeller,propFrame,x+16,y-1,1,1,0,c_white,image_alpha)
if instance_exists(oAssistShot)
  draw_sprite_ext(sSpellWaterBarrier,propFrame,x,y,1,1,0,c_white,0.5)
if chargePower>24
{
  draw_sprite_ext(sMMcharging,chargeFrame,x+16,y-1,0.8,0.8,0,c_white,1)
  if chargePower>60
  {
    draw_sprite_ext(sMMcharging,chargeFrame,x+16,y-1,1.4,1.4,120,c_white,0.75)
    if chargePower>=100
    {
      draw_sprite_ext(sMMcharging,chargeFrame,x+16,y-1,2,2,240,c_white,0.5)
    }
  }
}
