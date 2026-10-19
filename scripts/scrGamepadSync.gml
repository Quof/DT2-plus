/*
gamepad change (added, from DT1 Plus): called next to every io_clear() (and after the Gamepad list sets a button): what
is held on the pad right now doesn't count as held at all until it's let go (global.gpLock, scrGamepadPoll), as io_clear
makes GM forget held keys. Clearing only the presses wouldn't be enough: the player reads its own presses from held going
on, so a still-held A that closed a message would jump once the player had control again.
*/
var i;
for(i=1;i<=global.gpActions;i+=1)
{
  global.gpLock[i]=(global.gpLock[i] or global.gpHeld[i]) //(one already locked stays locked)
  global.gpHeld[i]=0 //from now on this frame too
  global.gpPrev[i]=0
  global.gpPressed[i]=0
  global.gpReleased[i]=0
}
