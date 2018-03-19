//class holding and checking all the touchpoints

class touchAll{
   ArrayList<touchPoint> points; 
   ParticleSystem ps;
   
   touchAll(ParticleSystem p){
     points = new ArrayList<touchPoint>();
     ps = p;
   }
   
   void addPoint(int x, int y, int ID, int TYPE) {
    points.add(new touchPoint(x,y,ID,TYPE));
   }
   
   void pointTouched(int ID){
     for (int i = points.size()-1; i >= 0; i--) {
      touchPoint p = points.get(i);
      if(p.ID == ID){
         if(p.TYPE == 1){
            //point is a planet interaction point
            println("planet point touched");
            particlesOnPoint(p.posX,p.posY);
          }
          if(p.TYPE == 2){
            //point is a spawn point
            println("spawn a spaceship");
            particlesOnPoint(p.posX,p.posY);
          }
      }     
     }
   }

   void run() {
    for (int i = points.size()-1; i >= 0; i--) {
      touchPoint p = points.get(i);
      p.run();
    }
   }
  
   void particlesOnPoint(int x, int y){
    ps.origin = new PVector(x,y);
    for(int i = 0; i < 100; i++){
      ps.addParticle();
    } 
   }
}
