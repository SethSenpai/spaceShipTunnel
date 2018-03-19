//class for the touchpoints themselves

class touchPoint{
  int posX;
  int posY;
  color c;
  int size;
  int ID;
  int TYPE;
  
  touchPoint(int x, int y, int id, int type){
     posX = x;
     posY = y;
     ID = id;
     TYPE = type;
     c = color(0,255,255);
     size = 10;
  }
  
  void run(){
     fill(c);
     stroke(c);
     ellipse(posX,posY,size,size);
  }
}
