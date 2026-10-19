/*
Draws moving platforms - overrides default sprite
*/
// ***** BLACK ROCK FORTRESS *****
if argument0=0
{
  draw_background_part(tileBRFort1,0,160,32,16,x,y)
  draw_background_part(tileBRFort1,96,160,32,16,x+32,y)
}
else if argument0=1
{
  draw_background_part(tileBRFort1,32,176,64,48,x,y)
  yTileSet=48
  for(i=0;i<image_yscale-3;i+=2)
  {
    draw_background_part(tileBRFort1,32,192,64,32,x,y+yTileSet)
    yTileSet+=32
  }
}
else if argument0=2
{
  yTileSet=0
  for(iS=0;iS<image_yscale;iS+=1)
  {
    draw_background_part(tileBRFort1,0,160,32,16,x,y+yTileSet)
    yTileSet+=16
  }
  xSpace=0
  tileChoose=0
  if variable_local_exists("xSize")
  {
    for(i=0;i<xSize;i+=1)
    {
      xSpace+=32
      yTileSet=0
      for(iS=0;iS<image_yscale;iS+=1)
      {
        draw_background_part(tileBRFort1,32+tileChoose,160,32,16,x+xSpace,y+yTileSet)
        yTileSet+=16
      }
      if tileChoose=0
        tileChoose=32
      else
        tileChoose=0
    }
  }
  yTileSet=0
  for(iS=0;iS<image_yscale;iS+=1)
  {
    draw_background_part(tileBRFort1,96,160,32,16,x+xSpace+32,y+yTileSet)
    yTileSet+=16
  }
}
else if argument0=3
{
  xTileSet=0
  yTileSet=0
  for(i=0;i<image_xscale*4;i+=4)
  {
    for(ii=0;ii<image_yscale;ii+=8)
    {
      draw_background_part(tileBRFort1,32,16,64,128,x+xTileSet,y+yTileSet)
      yTileSet+=128
    }
    yTileSet=0
    xTileSet+=64
  }
}
