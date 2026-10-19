if instance_number(oGame)>1
  instance_destroy()
moveableSolidGrav=1   //how fast moveable solids should accelerate downwards
time=1
time30=1 //60fps change (added): counts 30fps ticks (oGame.time counts frames); see gameStepEvent
