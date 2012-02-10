import sms.*;

int frame_size = 800;  //Dimensione della finestra

int gravity = 1 ; // 0 = off

//Posizione iniziale della pallina
int x0 = frame_size/2;
int y0 = frame_size/2;

int diametro = 100;  //Numero pari please
int raggio = int(diametro/2) ;
int speedX = 20 ; // Values 1 to 100
int speedY = 20 ;
int bounceX = 80 ; //Rimbalzo sui bordi
int bounceY = 40 ;

int invSpeedX = int(100/speedX);
int invSpeedY = int(100/speedY);
boolean showFace = false;
int oldx;
int ymov = 0;
int xmov = 0;


PImage bg;
void setup() {
  size(frame_size,frame_size);
  stroke(255); 
  fill(random(255),random(255),random(255));
  bg = loadImage("bg.png");
}

void draw() {
  background(bg);
  oldx =xmov ; 
  
   xmov = Unimotion.getSMSX() ;
   ymov = Unimotion.getSMSY() ;
  
  int zmov = Unimotion.getSMSZ();

 
  //Controlli sull'ordinata
  if (x0 < raggio )  //se va oltre il bordo sinistro
  {
     fill(random(255),0,random(255));
     x0 = raggio + bounceX ; 
  }
  else if ( x0 >  frame_size-raggio) { //se va oltre il bordo destro
     fill(200,random(255),random(255));
     x0 = frame_size-raggio-bounceX;
  }
  else x0+= int(xmov/invSpeedX); //modifica la posizione x della palla
    
   
  //Controlli sull'ascissa  
  if (y0 < raggio ) //se va oltre il bordo superiore
  {
     fill(0,random(255),random(255)); 
     y0 = raggio + bounceY; 
  }
  else if ( y0 >  frame_size-raggio) {//se va oltre il bordo inferiore
     fill(random(255),random(255),random(255));
    y0 = frame_size-raggio-bounceY; 
  }
  else {  //Se sta dentro i bordi
    y0+= int(ymov/invSpeedY);  //modifica la posizione y della palla
    y0+=gravity; 
  }
  
  zmov = int(zmov/10); //Mac in caduta
  if (zmov > -20 && diametro >= 10){
     diametro = diametro - 6; 
     raggio = int(diametro/2 );  
  }
  
  
  //Bottarelle laterali
  int diff = abs(oldx - xmov); 
  if(diff>10)
    showFace = !showFace ;
  
  //Disenga la palla
  ellipse(x0,y0,diametro,diametro);
 
 //Disegna la faccia
 if(showFace) 
 {
    ellipse(x0-10,y0-8,4,7);
    ellipse(x0+10,y0-8,4,7);
    line(x0-10, y0+12, x0+10, y0+12);
 }
 
 //Ripristina valori iniziali
 if(mousePressed) {
    diametro += 5;  //Numero pari please
    raggio = int(diametro/2) ;
    showFace = true; 
 }
}
