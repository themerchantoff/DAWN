import com.leapmotion.leap.processing.*;
import com.leapmotion.leap.*;
import com.leapmotion.leap.processing.LeapMotion;

LeapMotion leapMotion;
int num_pantalla, cont = 0;
jugador p1;
obstaculos ob1;
obstaculos ob2;
float x_s,y_s;
int tam=300;
float aumenta=0;
void setup()
{
  size(800, 600);
  num_pantalla = 1;
  strokeWeight(20); //Para poner el punto muy grande.
  stroke(222,76,138);  //Color del punto.
  leapMotion = new LeapMotion(this);
  ob1=new obstaculos(tam,tam);
  ob2=new obstaculos(tam,tam);
  textSize(50);
}

void draw()
{
  background(0,0,255);
  switch(num_pantalla)
    {
      case 1:
              pantalla_uno();
              break;
      case 2:
              pantalla_dos();
              break;
      case 3:
              pantalla_tres();
              break;        
    }
    
  Controller controller = leapMotion.controller();
  controller.enableGesture(Gesture.Type.TYPE_SCREEN_TAP);
  
  if (controller.isConnected())
  {
    Frame frame = controller.frame();
      Hand mano = frame.hands().get(0);
      
      if(mano.isRight())
      {
        
        //Para traerse solo el dedo índice de esta mano:
        Finger indice = mano.fingers().fingerType(Finger.Type.TYPE_INDEX).get(0);
        Vector pos = indice.tipPosition();
           
           float x=pos.getX();
           float y=pos.getY();
           x_s = leapMotion.leapToSketchX(x);
           y_s = leapMotion.leapToSketchY(y);
           point(x_s,y_s); 
           
            for(Gesture gesture: frame.gestures())
            {
               switch(gesture.type())
               {
                 case TYPE_SCREEN_TAP:
                   if(x_s>260 && x_s<560 && y_s>100 && y_s<200)
                   {
                     num_pantalla = 2;
                   }
                   break;
               }
            }  
      }
  }
 
}

void pantalla_uno()
{
  background(195,240,190);
  fill(0);
  strokeWeight(1);
  rect(260,100,300,100);
  noFill();
  
  fill(255);
  rect(260,250,300,100);
  noFill();
  
  strokeWeight(20);
   
}

void pantalla_dos()
{
  clear();
  
  background(227,191,239);
  text(cont,600,50);
  //p1.printJug();
  if(cont == 0){
    ob1.randy();
    ob2.randy();
  }
  ob1.printObs();
  ob1.ox -= (5+aumenta);
  
  cont++;
  if(ob1.ox<=0)
  {
    ob1.ox=800;
    ob1.randy();
    overlap();
    aumenta += .5;
  }
  
  ob2.printObs();
  ob2.ox-=(5+aumenta);
  if(ob2.ox<=0)
  {
    ob2.ox=800;
    ob2.randy();
    overlap();
  }
  
  compara();
}

void pantalla_tres()
{
  background(239,194,194);
  
  textSize(100);
  text(cont,400,300);
  if(x_s<=0){
    num_pantalla=1;
    reset();
  }
}

void compara(){
  if(abs(ob1.ox-x_s)<tam){
    if(abs(x_s-(ob1.ox+ob1.sizex))<tam){
      if(abs(ob1.oy-y_s)<tam){
        if(abs(y_s-(ob1.oy+ob1.sizey))<tam){
          num_pantalla=3;
        }
      }
    }
  }
  if(abs(ob2.ox-x_s)<tam){
   if(abs(x_s-(ob2.ox+ob2.sizex))<tam){
     if(abs(ob2.oy-y_s)<tam){
       if(abs(y_s-(ob2.oy+ob2.sizey))<tam){
        num_pantalla=3;
       }
     }
    }
  }
}
//reinicia el juego después de hacer colisión
void reset(){
  ob2.ox = ob1.ox = 800;
  cont=0;
  aumenta=0;
  textSize(50);
}
void overlap(){
  while((ob2.oy>=ob1.oy && (ob1.oy+ ob1.sizey) >= ob2.oy)||(ob1.oy >= ob2.oy && (ob2.oy + ob2.sizey) >= ob1.oy)){
    if(ob2.oy>=ob1.oy && (ob1.oy+ ob1.sizey) >= ob2.oy){
      ob2.randy();
    }
    if(ob1.oy >= ob2.oy && (ob2.oy + ob2.sizey) >= ob1.oy){
      ob1.randy(); 
    }
  }
}