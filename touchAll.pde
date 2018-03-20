//class holding and checking all the touchpoints

class touchAll{
   ArrayList<touchPoint> points; 
   ParticleSystem ps;
   
   touchAll(ParticleSystem p){
     points = new ArrayList<touchPoint>();
     ps = p;
   }
   
   void addPoint(int x, int y, int s, int ID, int TYPE) {
    points.add(new touchPoint(x,y,s,ID,TYPE));
   }
   
   void pointTouched(int ID){
     for (int i = points.size()-1; i >= 0; i--) {
      touchPoint p = points.get(i);
      if(p.ID == ID){
         if(p.TYPE == 1){
            //point is a planet interaction point
            //println("planet point touched");
            particlesOnPoint(p.posX,p.posY);
          }
          if(p.TYPE == 2){
            //point is a spawn point
            //println("spawn a spaceship");
            particlesOnPoint(p.posX,p.posY);
          }
      }     
     }
   }
   
   void updateValues(String[] a){
    for(int i = 0; i < 6; i++){
      touchPoint p = points.get(i);
      p.addValue(parseInt(a[i].trim()));
    }
   }

   void run() {
    for (int i = points.size()-1; i >= 0; i--) {
      touchPoint p = points.get(i);
      print(p.value);
      print("\t");
      p.run();
      if(p.STATE == 1){
       //p.size = 10 + (p.value / 10); 
      }
      
      if(p.STATE == 0)
      {
        //p.size = 10;
      }
      
      if(p.STATE == 2){
        if(p.timer < 5){
          //burst particles for 5 frames
          pointTouched(p.ID);
        }
      }
      
      if(p.STATE == 3){
        p.c = color(255,255,0);
      }
      else{
        p.c = color(0,255,255); 
      }
    }
    println(".");
   }
  
   void particlesOnPoint(int x, int y){
    ps.origin = new PVector(x,y);
    for(int i = 0; i < 100; i++){
      ps.addParticle();
    } 
   }
}
