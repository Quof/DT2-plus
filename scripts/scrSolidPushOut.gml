/*
60fps change (added): above 30fps, moves the caller up out of a solid it's inside, as the 30fps code's
"if isCollisionSolid() y-=2" did: at most 2 pixels per 30fps tick (solidPushRoom fills up by 2 over each tick), but in
whole pixels and only while it's still inside. Called at the start of the caller's step, before it checks the floor and
walls (the 30fps code keeps its own line where it was, for gDeltaTime==1).
Moving solids move before the enemies' steps (oGame), and an elevator rising 2 pixels a tick goes up 1 pixel on some
frames: y-=2*gDeltaTime left a goomba on half pixels part-way into 3-3's elevator, and its wall checks saw the elevator
on both sides, so it stood stuck in it.
*/
if !variable_local_exists("solidPushRoom") {solidPushRoom=2}
solidPushRoom=min(2,solidPushRoom+2*gDeltaTime)
while solidPushRoom>=1 and isCollisionSolid()
{
  y-=1
  solidPushRoom-=1
}
