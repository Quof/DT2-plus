/*
This script is called in the enemy step event to check for distance to the player.
When detectDist is less than detectThreshold, the enemy becomes active and will attack the player.
To free up memory, if the enemy is too far, it will become inactive.
Most levels are horizontal, so the y detect is not used for the inactive check.
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if bActive=false
{
  if findTargetX<detectDistX and findTargetY<detectDistY
    bActive=true
}
else
{
  if findTargetX>inactiveDist
    bActive=false
}
