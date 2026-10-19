/*
This script is called in the enemy create event.
It is used to alter enemies on the different difficulty settings.
argument0: difficulty setting
*/
var adjustCurve,tempAdjust;
if argument0=1 //Beginner
{
  if variable_local_exists("maxLife")
  {
    adjustCurve=0.15
    tempAdjust=maxLife*adjustCurve
    maxLife-=round(tempAdjust)
    life=maxLife

    adjustCurve=0.25
    tempAdjust=physicalDefense*adjustCurve
    physicalDefense-=round(tempAdjust)
    tempAdjust=spiritDefense*adjustCurve
    spiritDefense-=round(tempAdjust)

    adjustCurve=0.1
    tempAdjust=expWorth*adjustCurve
    expWorth-=round(tempAdjust)
  }

  adjustCurve=0.25
  tempAdjust=physicalPower*adjustCurve
  physicalPower-=round(tempAdjust)
  tempAdjust=spiritPower*adjustCurve
  spiritPower-=round(tempAdjust)
}
else if argument0=3 //Hardcore
{
  if variable_local_exists("maxLife")
  {
    adjustCurve=0.15
    tempAdjust=maxLife*adjustCurve
    maxLife+=round(tempAdjust)
    life=maxLife

    adjustCurve=0.25
    tempAdjust=physicalDefense*adjustCurve
    physicalDefense+=round(tempAdjust)
    tempAdjust=spiritDefense*adjustCurve
    spiritDefense+=round(tempAdjust)

    adjustCurve=0.1
    tempAdjust=expWorth*adjustCurve
    expWorth+=round(tempAdjust)
  }

  adjustCurve=0.3
  tempAdjust=physicalPower*adjustCurve
  physicalPower+=round(tempAdjust)
  tempAdjust=spiritPower*adjustCurve
  spiritPower+=round(tempAdjust)
}
else if argument0=4 //Distorted
{
  if variable_local_exists("maxLife")
  {
    if bIsBoss=true
      adjustCurve=0.2
    else
      adjustCurve=0.16
    tempAdjust=maxLife*adjustCurve
    maxLife+=round(tempAdjust)
    life=maxLife

    adjustCurve=0.26
    tempAdjust=physicalDefense*adjustCurve
    physicalDefense+=round(tempAdjust)
    tempAdjust=spiritDefense*adjustCurve
    spiritDefense+=round(tempAdjust)

    adjustCurve=0.11
    tempAdjust=expWorth*adjustCurve
    expWorth+=round(tempAdjust)
  }

  adjustCurve=0.425
  tempAdjust=physicalPower*adjustCurve
  physicalPower+=round(tempAdjust)
  tempAdjust=spiritPower*adjustCurve
  spiritPower+=round(tempAdjust)
}
