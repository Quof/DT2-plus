/*
This script is called when playing sound
argument0: which sound to play
argument1: 0=play, 1=loop
argument2: sound volume
argument3: sound frequency
*/
if global.optSound>0
{
  var tempSound,tempLoop,tempVolume,tempFreq,soundAmp;
  tempSound=argument0
  tempLoop=argument1
  tempVolume=argument2
  soundAmp=global.soundAmplify
  if global.gamePaused=true
    soundAmp=1
  tempFreq=((SS_GetSoundBytesPerSecond(tempSound)/2)+argument3)*soundAmp

  tempVolume=tempVolume-(1-(global.optSound/100))

  if argument1=0
    SS_PlaySound(tempSound)
  else if argument1=1
    SS_PlaySound(tempSound) //Should "Loop" but I have not debugged the new sound system completely yet
  SS_SetSoundVol(tempSound,tempVolume*10000)

  SS_SetSoundFreq(tempSound,tempFreq)
}
