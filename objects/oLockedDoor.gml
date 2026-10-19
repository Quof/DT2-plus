#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Locked Door script.
objectNum relates to which global flag to write to.
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<40 and findTargetY<16 and global.lockedDoors[objectNum]=0
{
  if global.p1Keys>0
  {
    global.p1Keys-=1
    playSound(global.snd_DoorUnlock,0,1)
    global.lockedDoors[objectNum]=1
  }
}
if global.lockedDoors[objectNum]=1
  instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sLockedDoor,-1,x,y)
