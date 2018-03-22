class cosmicEventHandler{
  ArrayList<cosmicBit> bits;
  PVector origin;
  PVector target;
  boolean setPositions = false;
  boolean runStarted = false;
  int speed = 5;
  float fx;
  float fy;
  float fp;

  cosmicEventHandler(PVector position) {
    origin = position.copy();
    bits = new ArrayList<cosmicBit>();
  }

  void addParticle() {
    bits.add(new cosmicBit(origin));
  }

  void run() {
    for (int i = bits.size()-1; i >= 0; i--) {
      cosmicBit p = bits.get(i);
      p.run();
      if (p.isDead()) {
        bits.remove(i);
      }
    }
    if(runStarted){
      startRun();
    }
  }
  
  void startRun(){
    if(setPositions == false){
      origin = new PVector(0 , random(0,height));
      println(origin);
      target = new PVector(width, random(0,height));
      println(target);
      setPositions = true;
      runStarted = true;
      fx = target.x - origin.x;
      fy = target.y - origin.y;
      
      fp = sqrt(sq(fx) + sq(fy)) / speed;
      println(fp);
    }

    
    float a = fx / fp;
    println(a);
    float b = fy / fp ;
    
    origin.x = origin.x + a;
    origin.y = origin.y + b;

    println(origin);
    
    for(int i = 0; i < 2; i++){
    addParticle();
    }
    
    fill(190,190,90);
    ellipse(origin.x,origin.y,10,10);
    
    if(origin.x > width){
      setPositions = false;
      runStarted = false;
      origin = new PVector(0,0);
    }
  }
}
