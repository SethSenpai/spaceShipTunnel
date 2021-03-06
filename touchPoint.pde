//class for the touchpoints themselves

class touchPoint{
  int posX;
  int posY;
  color c;
  int size;
  int ID;
  int TYPE;
  int value;
  int[] avg;
  int trigger;
  int STATE; //0 null, 1 hover, 2 touch, 3 hold
  int timer;
  boolean timerStart;
  Planet plan;
  
  touchPoint(int x, int y, int s, int id, int type, Planet p){
     posX = x;
     posY = y;
     ID = id;
     TYPE = type;
     c = color(0,255,255);
     size = s;
     value = 0;
     avg = new int[4];
     trigger = 300;
     STATE = 0;
     timerStart = false;
     
     plan = p;
     
     if(TYPE == 1){
     c = color(0,255,255);
     println("set blue");
     }
     else
     {
     println("set brown");
     c = color(255,255,0); 
     }
  }
  
  void run(){
     setSizePosition();
     fill(c);
     stroke(c);
     ellipse(posX,posY,size,size);
     setState();
     timer();
  }
  
  void addValue(int a){
    int t = 0;
    int o = 0;
    for(int i =0; i < avg.length; i++){
      if(i == 0){
        t = avg[i];
        avg[i] = a;
      }
      else if(i == avg.length - 1){
        avg[i] = t;
      }
      else{
        o = avg[i];
        avg[i] = t;
        t = o;
      }
    }
    int total = 0;
    for(int k = 0; k < avg.length; k++){
      total = total + avg[k];
    }
    value = total / avg.length;
  }
  
  void setState(){
    
    if(value > 50 && value < trigger){
      STATE = 1;
    }
    if(value > trigger){
      STATE = 2;
      timerStart = true;
    }
    if(value > trigger && STATE == 2 && timer > 80){
      STATE = 3;
    }
        
    if(value < trigger){
      STATE = 1;
      timerStart = false;
      timer = 0;
    }
    if(value < 50){
      STATE = 0;
    }
  }
  
  void timer(){
    if(timerStart == true){
      timer ++;
      if(STATE != 3){
      stroke(255);
      strokeWeight(5);
      noFill();
      ellipse(posX,posY,size+timer-10,size+timer-10);
      strokeWeight(1);
      }
    }
  }
  
  void setSizePosition(){
     posX = (int)plan.planetPosition.x; 
     posY = (int)plan.planetPosition.y;
     size = (int)plan.planetSize - 10;
  }
  
}
