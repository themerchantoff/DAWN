class obstaculos
{
  float ox, oy;
  int sizex,sizey;
  
  obstaculos(int tamx,int tamy)
  {
    sizex=tamx;
    sizey=tamy;
    randy();
  }
  
  void randy()
  {
    oy=random(0,600);
  }
  
  void printObs()
  {
    strokeWeight(4);
    stroke(0,255,0);
    fill(0,150,100);
    rect(ox, oy, sizex, sizey);
    strokeWeight(20);
    stroke(222,76,138); 
  }
  
}