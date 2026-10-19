/*
This script is used when a character takes damage.
bPlayable is used to tell whether the character is your character or an enemy.
*/
if bCanTakeDamage=true
{
  var totalDamage,initialDamage;
  totalDamage=0
  if bPlayable=false
  {
    //show enemy health
    if parent="enemy" and global.optEnemyHP=true and bShowHealthBar=true and bIsBoss=false
    {
      with oEnemyLifeDisplay
        instance_destroy()
      eLifeDisplay=instance_create(0,0,oEnemyLifeDisplay)
      eLifeDisplay.eID=id
    }
    //This is used to find weaknesses and resistances with enemies. ----------
    if other.elementType!=0 //elemental damage
    {
      //global.recSpellsConnected+=1
      var tempSDefense;
      tempSDefense=atkDefense //set base defense
      if statusCripple>0
        tempSDefense=tempSDefense-(round(tempSDefense/2.5)) //set base defense after cripple
      if oPlayer1.bRaveActive=false
        initialDamage=(other.atkPower)+other.skillPower-tempSDefense //find initial damage
      else
        initialDamage=((other.atkPower)*3.5)+other.skillPower-tempSDefense //find initial damage
      totalDamage+=initialDamage

      var elementDamage;
      elementDamage=0
      if other.elementType=1
        elementDamage-=FIREresist
      if other.elementType=2
        elementDamage-=WATERresist
      if other.elementType=3
        elementDamage-=WINDresist
      if other.elementType=4
        elementDamage-=EARTHresist
      totalDamage*=(elementDamage/100)+1
    }
    else //skill damage
    {
      //global.recTechsConnected+=1
      var tempPDefense;
      tempPDefense=atkDefense //set base defense
      if statusCripple>0
        tempPDefense=tempPDefense-(round(tempPDefense/2.5)) //set base defense after cripple
      if oPlayer1.bRaveActive=false
        initialDamage=(other.atkPower)+other.skillPower-tempPDefense //find initial damage
      else
        initialDamage=((other.atkPower)*3.5)+other.skillPower-tempPDefense //find initial damage
      totalDamage=initialDamage
      totalDamage*=(-skillResist/100)+1
    }
  }
  else //---------- player takes damage ----------
  {
    //life bar drop
    global.hitsTaken+=1
    global.killingSpree=0
    global.killSpreeSoundCheck=0

    initialDamage=other.atkPower-atkDefense //find initial damage
    totalDamage+=initialDamage

    if other.elementType!=0 //elemental damage
    {
      var elementDamage;
      elementDamage=0
      if other.elementType=1
      {
        elementDamage-=global.p1FIREresist
          if global.p1CurrentElement=1
            elementDamage-=10
      }
      if other.elementType=2
      {
        elementDamage-=global.p1WATERresist
          if global.p1CurrentElement=2
            elementDamage-=10
      }
      if other.elementType=3
      {
        elementDamage-=global.p1WINDresist
          if global.p1CurrentElement=3
            elementDamage-=10
      }
      if other.elementType=4
      {
        elementDamage-=global.p1EARTHresist
          if global.p1CurrentElement=4
            elementDamage-=10
      }
      totalDamage*=(elementDamage/100)+1
    }
    //set damage state
    bTakingDamage=true
    damageTime=flashTime
    bCanTakeHit=false
    tookHitAmount+=1
    idleTime=0
    attackState=0 //set character's attack state to none
    //setCollisionBounds(-8,-44,8,-1)
    if other.bCauseKnockback=true //knockback
    {
      //stopPlayer()
      oPlayer1.xVel=0
      oPlayer1.yVel=0
      oPlayer1.kLeft=0
      oPlayer1.kRight=0
      oPlayer1.kUp=0
      oPlayer1.kDown=0
      if image_xscale=1
        xVel=-2
      else
        xVel=2
      y-=2
      yVel=-4
      xVelSetExt=1; yVelSetExt=1 //60fps change (added): knockback set after the player's move: its next move uses the 30fps formula (see pMoveToWrapNew), as in DT3+
    }
    //damage sound
    playSound(global.snd_PlayerDamaged[0],0,1)
  }
  
  //set totalDamage to minimum if it goes below it ====================
  if bPlayable=false //damage enemy
  {
    if totalDamage<0 //ensures damage doesn't go below 0
      totalDamage=0
    //stun enemy
    if totalDamage>0
    {
      //chain time
      if oHUD.killChainFadeTime>0
      {
        oHUD.killChainFadeTime+=20
        oHUD.killChainAlpha=1
        if oHUD.killChainFadeTime>oPlayer1.chainingTime
          oHUD.killChainFadeTime=oPlayer1.chainingTime
      }
      //set damage state and stun time
      bTakingDamage=true
      damageTime=flashTime
      image_blend=c_red
      var extraStunTime;
      extraStunTime=totalDamage/maxLife
      if bIsBoss=false
      {
        if extraStunTime>0.8
          stunnedTime=12
        else if extraStunTime>=0.6 and extraStunTime<=0.79
          stunnedTime=11
        else if extraStunTime>=0.4 and extraStunTime<=0.59
          stunnedTime=10
        else if extraStunTime>=0.2 and extraStunTime<=0.39
          stunnedTime=9
        else if extraStunTime>=0.1 and extraStunTime<=0.19
          stunnedTime=8
        else
          stunnedTime=7
      }
      else
      {
        if extraStunTime>0.08
          stunnedTime=11
        else if extraStunTime>=0.06 and extraStunTime<=0.079
          stunnedTime=10
        else if extraStunTime>=0.04 and extraStunTime<=0.059
          stunnedTime=9
        else if extraStunTime>=0.02 and extraStunTime<=0.029
          stunnedTime=8
        else if extraStunTime>=0.01 and extraStunTime<=0.019
          stunnedTime=7
        else
          stunnedTime=6
      }
      if SS_IsHandleValid(hitSound)
        playSound(hitSound,0,1,oPlayer1.hitCombo*2)

      if parent="enemy"
      {
        //reinable air dash
        oPlayer1.canAirDash=1
        if oPlayer1.dashPoints<oPlayer1.maxDashPoints //air dash power
        {
          oPlayer1.dashRecoveryTime+=15
        }
        if oPlayer1.fireEnergy<oPlayer1.maxFireEnergy {oPlayer1.fireRecharge+=7}
        if oPlayer1.waterEnergy<oPlayer1.maxWaterEnergy {oPlayer1.waterRecharge+=7}
        if oPlayer1.windEnergy<oPlayer1.maxWindEnergy {oPlayer1.windRecharge+=7}
        if oPlayer1.earthEnergy<oPlayer1.maxEarthEnergy {oPlayer1.earthRecharge+=7}
      }
    }
    else
    {
      bTakingDamage=true
      damageTime=flashTime
      if SS_IsHandleValid(hitSound)
        playSound(hitSound,0,1,22050)
    }
  }
  else
  {
    if totalDamage<1 //ensures character takes minimum damage
      totalDamage=1
  }
  if global.optShowDamage=true //show damage dealt on screen
  {
    if bShowDamage=true
    {
      newDamage=instance_create(floor(x),floor(bbox_bottom-(sprite_height/2)),oDamageNotice);
      newDamage.damageValue=totalDamage
      if bPlayable=false
        newDamage.damageColor=c_white
      else
        newDamage.damageColor=c_red
    }
  }
  life-=round(totalDamage) //deal damage

  //if the character has 0 health ====================
  if life<=0
  {
    if bPlayable=false
    {
      if oPlayer1.life<oPlayer1.maxLife
      {
        var itemChance,dropInd;
        itemChance=round(random(100)) //find item drop chance
        dropInd=oPlayer1.life-oPlayer1.maxLife
        if itemChance>=(100-baseItemChance+abs(dropInd))
          heartDrop=instance_create(x,bbox_bottom-(sprite_height/2),oHealthPickup)
      }

      if SS_IsHandleValid(dieSound) //enemy death sound
        playSound(dieSound,0,1)

      if dieEffect=0 //enemy death effect
      {
        for(i=0;i<6;i+=1)
        {
          effect=instance_create(x,bbox_bottom-(sprite_height/2),oKillEffect)
          effect.direction=i*60
        }
      }
      else
      {
        if dieEffect=100001
          effect_create_above(ef_firework,x,bbox_bottom-(sprite_height/2),0,make_color_rgb(random(255),random(255),random(255)))
        else
        {
          effect=instance_create(x,bbox_bottom-(sprite_height/2),oEffect)
          effect.sprite_index=dieEffect
          effect.image_speed=effectSpeed
          effect.image_xscale=effectXscale
          effect.image_yscale=effectYscale
        }
      }

      if parent="enemy"
      {
        //increment kill chain
        if bNoBonus=false
        {
          oHUD.killChainAlpha=1
          oHUD.killChainFadeTime=oPlayer1.chainingTime
          oPlayer1.killChain+=1
          if oPlayer1.killChain>=2 and oPlayer1.killChain<=10 and global.optKillChainSound=true
            playSound(global.snd_killChain[oPlayer1.killChain-2],0,1)
          if pointWorth>0 and oPlayer1.killChain>1 //award bonus points
          {
            var bonusAward;
            bonusAward=oPlayer1.killChain*20
            global.currentScore+=bonusAward
            if global.optShowPointsEarned=true
            {
              newBonusAward=instance_create(0,0,oBonusAward)
              newBonusAward.bonusValue=bonusAward
              newBonusAward.type=0
            }
          }
          //check killing spree
          global.killingSpree+=1
          if global.killingSpree>=5 and global.killSpreeSoundCheck=0
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=10 and global.killSpreeSoundCheck=1
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=15 and global.killSpreeSoundCheck=2
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=20 and global.killSpreeSoundCheck=3
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=25 and global.killSpreeSoundCheck=4
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=30 and global.killSpreeSoundCheck=5
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=40 and global.killSpreeSoundCheck=6
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=50 and global.killSpreeSoundCheck=7
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=100 and global.killSpreeSoundCheck=8
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }
          else if global.killingSpree>=150 and global.killSpreeSoundCheck=9
          {
            if pointWorth>0 //award bonus points
            {
              var bonusAward;
              bonusAward=global.killingSpree*20
              global.currentScore+=bonusAward
              if global.optShowPointsEarned=true
              {
                newBonusAward=instance_create(0,0,oBonusAward)
                newBonusAward.bonusValue=bonusAward
                newBonusAward.type=1
              }
            }
            if global.optKillingSpreeSound=true
              playSound(global.snd_killingSpree[global.killSpreeSoundCheck],0,1)
            if global.optKillingSpreeScreen=true
            {
              oKillSpree=instance_create(0,0,oKillingSpreeAlert)
              oKillSpree.alertType=global.killSpreeSoundCheck
            }
            global.killSpreeSoundCheck+=1
          }

          if pointWorth>0 //award points
          {
            global.currentScore+=round(pointWorth)
            if global.optShowPointsEarned=true
            {
              newAward=instance_create(floor(x),floor(bbox_bottom-(sprite_height/2)),oKillAward)
              newAward.pointValue=pointWorth
            }
          }
        }
        else
        {
          if oHUD.killChainFadeTime>0
          {
            oHUD.killChainAlpha=1
            oHUD.killChainFadeTime=120
          }
        }
        global.p1KillCount+=1
      }
      if questType>0
        enemyQuest(questType)
      bCanTakeDamage=false
      bCanDealDamage=false
      dieFade=1
      if parent="breakable"
        instance_destroy()
    }
  }
}
