/*
This script returns the map index.
*/
var mInd;

if global.lvlCurrent="1-1"
  mInd=0
else if global.lvlCurrent="1-2"
  mInd=1
else if global.lvlCurrent="1-3"
  mInd=2
else if global.lvlCurrent="1-B"
  mInd=3
else if global.lvlCurrent="2-1"
  mInd=4
else if global.lvlCurrent="2-2"
  mInd=5
else if global.lvlCurrent="2-B"
  mInd=6
else if global.lvlCurrent="3-1"
  mInd=7
else if global.lvlCurrent="3-2"
  mInd=8
else if global.lvlCurrent="3-3"
  mInd=9
else if global.lvlCurrent="3-B"
  mInd=10
else if global.lvlCurrent="4-1"
  mInd=11
else if global.lvlCurrent="4-2"
  mInd=12
else if global.lvlCurrent="4-B"
  mInd=13
else if global.lvlCurrent="5-1"
  mInd=14
else if global.lvlCurrent="Final"
  mInd=15
else if global.lvlCurrent="0-1" or global.lvlCurrent="Bonus"
  mInd=16

return mInd;
