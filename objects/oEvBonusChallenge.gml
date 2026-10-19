#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
challengeProg=0

if room=rBonusC1
{
  chA_enemySpawnSeq=0
  chA_enemySpawnTime=15
  chA_enemySpawnDelay=15
}
else if room=rBonusC2
{
  chA_enemySpawnSeq=0
  chA_enemySpawnTime=0
  chA_enemySpawnDelay=210
}
else if room=rBonusC3
{
  chA_enemySpawnSeq=0
  chA_enemySpawnTime=90
  chA_enemySpawnDelay=90
  chA_blockSpd=2
}
else if room=rBonusC4
{
  chA_enemySpawnSeq=0
  chA_enemySpawnTime=90
  chA_enemySpawnDelay=100
}

chMenuX=256
chMenuY=162
buttonDelay=0
bNewRecord=0

scoreObtained=0

curConfirm=ord("J")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rBonusC1 //---------------------------------------- Air Trial ----------------------------------------
  {
    if challengeProg=0 //Wait for player start
    {
      global.levelTimeSecond=0
      global.levelTimeFrameCount=0
      if oPlayer1.state=oPlayer1.JUMPING
      {
        //with (356639) {instance_destroy()}
        with (GID(356639)) {instance_destroy()} //instance id fix: the starting platform, by its id in the original game (GID)
        tile_layer_hide(1000000)
        challengeProg=1
      }
    }
    else if challengeProg=1 //Trial
    {
      //chA_enemySpawnTime+=1
      chA_enemySpawnTime+=1*gDeltaTime //60fps change: counts 30fps ticks (reset to whole numbers, so it reaches the spawn times on a tick's last frame)
      if chA_enemySpawnTime>=chA_enemySpawnDelay
      {
        var tNewBat;
        if chA_enemySpawnSeq=0 {tNewBat=instance_create(-8,160,oFang); tNewBat.bActive=1}
        else if chA_enemySpawnSeq=1 {tNewBat=instance_create(room_width+8,128,oFang); tNewBat.bActive=1}
        else if chA_enemySpawnSeq=2 {tNewBat=instance_create(-8,224,oFang); tNewBat.bActive=1}
        else if chA_enemySpawnSeq=3 {tNewBat=instance_create(room_width+8,192,oFang); tNewBat.bActive=1}
        else if chA_enemySpawnSeq=4 {tNewBat=instance_create(-8,64,oFang); tNewBat.bActive=1}
        else if chA_enemySpawnSeq=5 {tNewBat=instance_create(room_width+8,272,oFang); tNewBat.bActive=1}

        chA_enemySpawnSeq+=1
        if chA_enemySpawnSeq=6
        {
          if chA_enemySpawnDelay<40 {chA_enemySpawnDelay+=4}
          chA_enemySpawnSeq=0
        }
        chA_enemySpawnTime=0
      }
    }
  }
  else if room=rBonusC2 //---------------------------------------- Chase Trial ----------------------------------------
  {
    if challengeProg=0 //Trial
    {
      //chA_enemySpawnTime+=1
      chA_enemySpawnTime+=1*gDeltaTime //60fps change: counts 30fps ticks (reset to whole numbers, so it reaches the spawn times on a tick's last frame)
      if chA_enemySpawnTime>=chA_enemySpawnDelay
      {
        if chA_enemySpawnSeq<=4
        {
          chA_enemySpawnSeq+=1
          with oChallengeChaser
          {
            var tEffect;
            tEffect=instance_create(x+4,y+4,oEffect)
            tEffect.sprite_index=sWindEffect; tEffect.image_speed=0.5; tEffect.xSpd=2; tEffect.ySpd=2
            tEffect=instance_create(x+4,y-4,oEffect)
            tEffect.sprite_index=sWindEffect; tEffect.image_speed=0.5; tEffect.xSpd=2; tEffect.ySpd=-2
            tEffect=instance_create(x-4,y+4,oEffect)
            tEffect.sprite_index=sWindEffect; tEffect.image_speed=0.5; tEffect.xSpd=-2; tEffect.ySpd=2
            tEffect=instance_create(x-4,y-4,oEffect)
            tEffect.sprite_index=sWindEffect; tEffect.image_speed=0.5; tEffect.xSpd=-2; tEffect.ySpd=-2
            bulletSpeed+=1
            turnSpeed+=1
          }
        }
        chA_enemySpawnTime=0
      }

      if oPlayer1.life<oPlayer1.maxLife
      {
        global.gamePaused=true
        challengeProg=100
      }
    }
  }
  else if room=rBonusC3 //---------------------------------------- Jump Trial ----------------------------------------
  {
    if challengeProg=0 //Wait for player start
    {
      global.levelTimeSecond=0
      global.levelTimeFrameCount=0
      if oPlayer1.sprite_index!=sPlayerIdle
      {
        oTetrisBlock.yVel=2
        challengeProg=1
      }
    }
    else if challengeProg=1 //Trial
    {
      //chA_enemySpawnTime+=1
      chA_enemySpawnTime+=1*gDeltaTime //60fps change: counts 30fps ticks (reset to whole numbers, so it reaches the spawn times on a tick's last frame)
      if chA_enemySpawnTime>=chA_enemySpawnDelay
      {
        var tNewBlock,tNewSpike;
        if chA_enemySpawnSeq=0 //Two Squares
        {
          tNewBlock=instance_create(80,-64,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd
          tNewBlock=instance_create(432,-64,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd
        }
        else if chA_enemySpawnSeq=1 //Four Lines
        {
          tNewBlock=instance_create(0,-64,oTetrisBlock); tNewBlock.sprite_index=sTet_Line_2; tNewBlock.ySpd=chA_blockSpd
          for(i=0;i<8;i+=1)
          {
            tNewSpike=instance_create(x,y,oStaticSpike)
            tNewSpike.bFollow=1; tNewSpike.idFollow=tNewBlock
            tNewSpike.xFollow=-64+(i*16); tNewSpike.yFollow=-16
          }
          tNewBlock=instance_create(128,-64,oTetrisBlock); tNewBlock.sprite_index=sTet_Line_2; tNewBlock.ySpd=chA_blockSpd
          for(i=0;i<8;i+=1)
          {
            tNewSpike=instance_create(x,y,oStaticSpike)
            tNewSpike.bFollow=1; tNewSpike.idFollow=tNewBlock
            tNewSpike.xFollow=-64+(i*16); tNewSpike.yFollow=-16
          }
          tNewBlock=instance_create(384,-64,oTetrisBlock); tNewBlock.sprite_index=sTet_Line_2; tNewBlock.ySpd=chA_blockSpd
          for(i=0;i<8;i+=1)
          {
            tNewSpike=instance_create(x,y,oStaticSpike)
            tNewSpike.bFollow=1; tNewSpike.idFollow=tNewBlock
            tNewSpike.xFollow=-64+(i*16); tNewSpike.yFollow=-16
          }
          tNewBlock=instance_create(512,-64,oTetrisBlock); tNewBlock.sprite_index=sTet_Line_2; tNewBlock.ySpd=chA_blockSpd
          for(i=0;i<8;i+=1)
          {
            tNewSpike=instance_create(x,y,oStaticSpike)
            tNewSpike.bFollow=1; tNewSpike.idFollow=tNewBlock
            tNewSpike.xFollow=-64+(i*16); tNewSpike.yFollow=-16
          }
        }
        else if chA_enemySpawnSeq=2 //Two Ts
        {
          tNewBlock=instance_create(128,-64,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_T_1
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=32; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=48; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-48
          tNewBlock=instance_create(384,-64,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_T_1
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=32; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=48; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-48
        }
        else if chA_enemySpawnSeq=3 //Two Ws
        {
          tNewBlock=instance_create(160,-96,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_W_2
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-16
          tNewBlock=instance_create(352,-64,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_BackW_2
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-48
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-80
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-80
        }
        else if chA_enemySpawnSeq=4 //1 Line
        {
          tNewBlock=instance_create(256,-64,oTetrisBlock); tNewBlock.sprite_index=sTet_Line_2; tNewBlock.ySpd=chA_blockSpd
          for(i=0;i<8;i+=1)
          {
            tNewSpike=instance_create(x,y,oStaticSpike)
            tNewSpike.bFollow=1; tNewSpike.idFollow=tNewBlock
            tNewSpike.xFollow=-64+(i*16); tNewSpike.yFollow=-16
          }
        }
        else if chA_enemySpawnSeq=5 //2 Ls
        {
          tNewBlock=instance_create(112,-96,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_L_1
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-80
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-80
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-16
          tNewBlock=instance_create(400,-96,oTetrisBlock); tNewBlock.ySpd=chA_blockSpd; tNewBlock.sprite_index=sTet_BackL_1
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-32; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=-16; tNewSpike.yFollow=-16
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=0; tNewSpike.yFollow=-80
          tNewSpike=instance_create(x,y,oStaticSpike); tNewSpike.bFollow=1
          tNewSpike.idFollow=tNewBlock; tNewSpike.xFollow=16; tNewSpike.yFollow=-80
        }

        chA_enemySpawnSeq+=1
        if chA_enemySpawnSeq=6
        {
          if chA_enemySpawnDelay>59
          {
            chA_enemySpawnDelay-=15
            chA_blockSpd+=2
            if chA_enemySpawnDelay=75 {chA_enemySpawnTime=-50}
            else if chA_enemySpawnDelay=60 {chA_enemySpawnTime=-28}
            else {chA_enemySpawnTime=0}
          }
          else {chA_enemySpawnTime=0}
          chA_enemySpawnSeq=0
        }
        else {chA_enemySpawnTime=0}
      }
    }
  }
  else if room=rBonusC4 //---------------------------------------- Perfect Trial ----------------------------------------
  {
    if challengeProg=0 //Trial
    {
      //chA_enemySpawnTime+=1
      chA_enemySpawnTime+=1*gDeltaTime //60fps change: counts 30fps ticks (reset to whole numbers, so it reaches the spawn times on a tick's last frame)
      if chA_enemySpawnTime>=chA_enemySpawnDelay
      {
        var tNewEnemy;
        if chA_enemySpawnSeq=0
        {
          tNewEnemy=instance_create(80,64,oCreateEnemy); tNewEnemy.ceObject=oFreakyFlier
          tNewEnemy=instance_create(432,64,oCreateEnemy); tNewEnemy.ceObject=oFreakyFlier
        }
        else if chA_enemySpawnSeq=1
        {
          tNewEnemy=instance_create(64,160,oCreateEnemy); tNewEnemy.ceObject=oRuinMonkey
          tNewEnemy=instance_create(448,160,oCreateEnemy); tNewEnemy.ceObject=oRuinMonkey
        }
        else if chA_enemySpawnSeq=2
        {
          tNewEnemy=instance_create(256,128,oCreateEnemy); tNewEnemy.ceObject=oDesertSquid
        }
        else if chA_enemySpawnSeq=3
        {
          tNewEnemy=instance_create(96,272,oCreateEnemy); tNewEnemy.ceObject=oFireEye
          tNewEnemy=instance_create(416,272,oCreateEnemy); tNewEnemy.ceObject=oFireEye
        }
        else if chA_enemySpawnSeq=4
        {
          tNewEnemy=instance_create(16,64,oCreateEnemy); tNewEnemy.ceObject=oSkellyBat
          tNewEnemy=instance_create(496,64,oCreateEnemy); tNewEnemy.ceObject=oSkellyBat
        }
        else if chA_enemySpawnSeq=5
        {
          tNewEnemy=instance_create(96,320,oCreateEnemy); tNewEnemy.ceObject=oGreenParatroopa
          tNewEnemy=instance_create(416,320,oCreateEnemy); tNewEnemy.ceObject=oGreenParatroopa
          tNewEnemy=instance_create(256,256,oCreateEnemy); tNewEnemy.ceObject=oDesertSquid
        }

        chA_enemySpawnSeq+=1
        if chA_enemySpawnSeq=6
        {
          if chA_enemySpawnDelay>69 {chA_enemySpawnDelay-=7}
          chA_enemySpawnSeq=0
        }
        chA_enemySpawnTime=0
      }

      if oPlayer1.life<oPlayer1.maxLife
      {
        global.gamePaused=true
        challengeProg=100
      }
    }
  }
}

if challengeProg=100 //-------------------- Tally score --------------------
{
  if room=rBonusC1
  {
    if global.levelTimeFrameCount>global.challScore[0]
    {
      bNewRecord=1
      global.challScore[0]=global.levelTimeFrameCount
    }
  }
  else if room=rBonusC2
  {
    if global.levelTimeFrameCount>global.challScore[1]
    {
      bNewRecord=1
      global.challScore[1]=global.levelTimeFrameCount
    }
  }
  else if room=rBonusC3
  {
    if global.levelTimeFrameCount>global.challScore[2]
    {
      bNewRecord=1
      global.challScore[2]=global.levelTimeFrameCount
    }
  }
  else if room=rBonusC4
  {
    if global.levelTimeFrameCount>global.challScore[3]
    {
      bNewRecord=1
      global.challScore[3]=global.levelTimeFrameCount
    }
  }
  scoreObtained=global.levelTimeFrameCount
  io_clear()
  scrGamepadSync() //gamepad change (added): and the gamepad's held buttons (scrGamepadSync)
  challengeProg=101
}
else if challengeProg=101 //-------------------- Wait for button press --------------------
{
  //buttonDelay+=1
  buttonDelay+=1*gDeltaTime //60fps change: counts 30fps ticks
  if buttonDelay>=7
  {
    //if keyboard_check_pressed(curConfirm)
    if keyboard_check_pressed(curConfirm) or scrPadPressed(14) //gamepad change: and the gamepad (scrGamepadInit)
    {
      global.gamePaused=false
      io_clear() //input sanitize change (added): the press that started this doesn't carry on into the game (held keys / pad buttons count as let go until pressed again: scrGamepadSync)
      scrGamepadSync()
      retryLevel()
      room_restart()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if challengeProg>=100
{
  draw_sprite(sChallengeEndMenu,0,chMenuX,chMenuY)
  draw_set_font(fnt_PauseText)
  draw_set_halign(fa_center)
  draw_set_color(c_white)
  draw_set_alpha(1)
  if room=rBonusC1
  {
    draw_text(chMenuX,chMenuY+15,scoreObtained)
    draw_text(chMenuX,chMenuY+41,global.challScore[0])
  }
  else if room=rBonusC2
  {
    draw_text(chMenuX,chMenuY+15,scoreObtained)
    draw_text(chMenuX,chMenuY+41,global.challScore[1])
  }
  else if room=rBonusC3
  {
    draw_text(chMenuX,chMenuY+15,scoreObtained)
    draw_text(chMenuX,chMenuY+41,global.challScore[2])
  }
  else if room=rBonusC4
  {
    draw_text(chMenuX,chMenuY+15,scoreObtained)
    draw_text(chMenuX,chMenuY+41,global.challScore[3])
  }

  if bNewRecord=1
  {
    draw_sprite(sCNewRecord,0,view_xview[0]+256,view_yview[0]+128)
  }
}
