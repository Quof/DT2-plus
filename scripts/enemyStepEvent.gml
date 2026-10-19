/*
This script is called in the enemy step event.
*/
lifePercent=life/maxLife
//stun time
if stunnedTime>0
{
  //stunnedTime-=1
  stunnedTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if stunnedTime<0 {stunnedTime=0} //60fps change (added): enemies wait for exactly 0; a count left on a fraction by an F2 frame rate change would never get there (it always lands on 0 otherwise)
  //if stunnedTime=0
  //  image_blend=baseColor
}

//damage time
if bTakingDamage=true and dieFade=0
{
  //damageTime-=1
  damageTime-=1*gDeltaTime //60fps change: counts 30fps ticks
  if damageTime<=0
  {
    image_blend=baseColor
    bTakingDamage=false
  }
}
if dieFade>0
{
  if bIsBoss=false
  {
    if dieEffect=0
    {
      //image_alpha-=0.05
      //dieFade+=1
      image_alpha-=0.05*gDeltaTime //60fps change: per 30fps tick
      dieFade+=1*gDeltaTime //60fps change: counts 30fps ticks
      if dieFade>=20
        instance_destroy()
    }
    else
      instance_destroy()
  }
}
