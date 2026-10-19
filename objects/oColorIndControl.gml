#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="none"
damageType="PHYSICAL"
elementType=0
bCauseKnockback=true

rotateAmt=-1
elementToShow=1
bWillDamagePlayer=0 //on 0, it WILL damage the player
atkPower=5

damageDelay=30
warnAmt=3
warnCycle=0
warnTime=0
damageTime=0
bWarnStart=0

visualWarnSize=1
visualWarnAlpha=0.75
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //60fps change: the counts below count 30fps ticks. The warning runs every tick from tick warnDelay on, so it starts
  //right after tick warnDelay-1 (>warnDelay-1), with its one-time start on that tick's first frame; damageTime (from 0)
  //then reaches damageDelay on the same tick as at 30fps (all the same checks as before at 30fps)
  if bWillDamagePlayer>0
    //bWillDamagePlayer-=1
    bWillDamagePlayer=max(0,bWillDamagePlayer-1*gDeltaTime) //(oColorZone sets it to 1+gDeltaTime)
  //warnTime+=1
  //if warnTime>=warnDelay
  warnTime+=1*gDeltaTime
  if warnTime>warnDelay-1
  {
    //if warnTime=warnDelay
    if warnTime=warnDelay-1+gDeltaTime
    {
      rotateAmt=-5
      if elementToShow=1
        oColorIndicator.image_blend=c_red
      else if elementToShow=2
        oColorIndicator.image_blend=c_blue
      else if elementToShow=3
        oColorIndicator.image_blend=c_green
      else if elementToShow=4
        oColorIndicator.image_blend=make_color_rgb(120,60,0)
      //elementType=elementToShow
    }

    //if bWarnStart=0 and warnTime>=warnDelay
    if bWarnStart=0 and warnTime>warnDelay-1 //60fps change: see above
    {
      playSound(global.snd_ColorPulseA,0,0.96,1)
      bWarnStart=1
    }
    else if bWarnStart=1 and warnTime>=warnDelay+30
    {
      playSound(global.snd_ColorPulseA,0,0.97,22050)
      bWarnStart=2
    }
    else if bWarnStart=2 and warnTime>=warnDelay+60
    {
      playSound(global.snd_ColorPulseA,0,0.98,33075)
      bWarnStart=3
    }

    //damageTime+=1
    damageTime+=1*gDeltaTime
    if damageTime>=damageDelay
    {
      warnCycle+=1
      if warnCycle=warnAmt
      {
        //deal damage to player if not inside the appropriate zone
        if bWillDamagePlayer=0
        {
          with oPlayer1
          {
            invertScreen=instance_create(0,0,oScreenInvert)
            invertScreen.invertTime=3
            takeDamage()
          }
        }
        //return to normal state
        playSound(global.snd_ColorPulseB,0,0.99,1)
        oColorIndicator.image_blend=c_white
        elementToShow+=1
        if elementToShow=5
          elementToShow=1
        rotateAmt=-1
        visualWarnSize=1
        visualWarnAlpha=0.75
        warnCycle=0
        warnTime=0
        bWarnStart=0
        damageTime=0
      }
      else
      {
        visualWarnSize=1
        visualWarnAlpha=0.75
        damageTime=0
      }
    }
    //visualWarnSize+=0.05
    //visualWarnAlpha-=0.0125
    visualWarnSize+=0.05*gDeltaTime
    visualWarnAlpha-=0.0125*gDeltaTime
  }
}
