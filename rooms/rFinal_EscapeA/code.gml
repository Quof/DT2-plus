tile_layer_delete(1000001)
instance_create(0,0,oBlackFadeDown)
if global.gameProgress<32
  global.gameProgress=32

if global.gameProgress=33 //Chaser Virus
{
  chaser=instance_create(48,240,oChaserVirus)
  levelEvent2=instance_create(0,0,oEvW5Convo)
}
else if global.gameProgress=34 //Horror Virus
{
  global.currentBoss="Horror"
  instance_create(0,0,oEvTintScreenRed)
  background_blend[0]=make_color_rgb(255,0,0)
  for(i=0;i<7;i+=1)
  {
    for(ii=0;ii<4;ii+=1)
    {
      instance_create(6272+(84*i),72+(78*ii),oBackFaces)
    }
  }
  for(i=0;i<6;i+=1)
  {
    for(ii=0;ii<3;ii+=1)
    {
      instance_create(6319+(84*i),113+(78*ii),oBackFaces)
    }
  }

  viewFix=instance_create(6496,0,oMisc)
  viewFix.sprite_index=sNull; viewFix.type=1
  view_object[0]=viewFix
  barrier=instance_create(6224,32,oBossBarrier); barrier.image_yscale=4.5

  horror=instance_create(6355,180,oHorrorVirus)
  oPlayer1.x=6624; oPlayer1.y=320
}

levelEvent1=instance_create(0,0,oEvEscape)

if global.gameProgress>=33
{
  var tempMplay;
  tempMplay=findMusic()
  playMusic(tempMplay,0)
}
