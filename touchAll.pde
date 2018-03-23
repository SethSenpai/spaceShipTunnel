//class holding and checking all the touchpoints

class touchAll{
   ArrayList<touchPoint> points; 
   ParticleSystem ps;
   SpaceTeam sp1;
   SpaceTeam sp2;
   SpaceTeam sp3;
   int State3Counter;
   cosmicEventHandler cph;
   
   touchAll(ParticleSystem p, SpaceTeam s, SpaceTeam c, SpaceTeam a ,  cosmicEventHandler cp){
     points = new ArrayList<touchPoint>();
     ps = p;
     sp1 = s;
     sp2 = c;
     sp3 = a;
     State3Counter = 0;
     cph = cp;
   }
   
   void addPoint(int x, int y, int s, int ID, int TYPE, Planet p) {
    points.add(new touchPoint(x,y,s,ID,TYPE,p));
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
       
       if(p.TYPE == 1){
         p.c = color(p.value * 2 , 255 - p.value / 2 , 255);
         }
         else
         {
         p.c = color(255, 255 - p.value / 2 , p.value * 2 );
         }
      }
      else
      {
        if(p.TYPE == 1){
         p.c = color(0,255,255);
         }
         else
         {
         p.c = color(255,255,0); 
         }
      }
      
      if(p.STATE == 0)
      {
        switch(p.ID){
          case 1:
            sp1.spawned = false;
          break;
          case 2:
            
          break;
          case 3:
            sp2.spawned = false;
          break;
          case 4:
            
          break;
          case 5: 
            sp3.spawned = false;
          break;
          case 6:
            
          break;   
        }
      }
      
      if(p.STATE == 2){
        if(p.timer < 5){
          //burst particles for 5 frames
          pointTouched(p.ID);
        }
      }
      
      if(p.STATE == 3){
        if(State3Counter < 6){
        State3Counter  ++;
        }
        //p.c = color(255,255,0);
        //println(p.timer);
        switch(p.ID){
          case 1:
          if(p.timer < 90){
            for(int j=0; j<5 ; j++){
                
              int t = (int)random(1,4);
              switch(t)
              {
               case 1:
                 sp1.trickleSpaceShip(new SpaceShip((int)sp1.plan.planetPosition.x,(int)sp1.plan.planetPosition.y,t));
               break;
               
               case 2:
                 sp2.trickleSpaceShip(new SpaceShip((int)sp1.plan.planetPosition.x,(int)sp1.plan.planetPosition.y,t));
               break;
               
               case 3:
                 sp3.trickleSpaceShip(new SpaceShip((int)sp1.plan.planetPosition.x,(int)sp1.plan.planetPosition.y,t));
               break;
              }              
             }
          }
          break;
          case 2:
             sp1.orbitAstroid();
          break;
          case 3:
          if(p.timer < 90){
            for(int j=0; j<5 ; j++){
              int t = (int)random(1,4);
              switch(t)
              {
               case 1:
                 sp1.trickleSpaceShip(new SpaceShip((int)sp2.plan.planetPosition.x,(int)sp2.plan.planetPosition.y,t));
               break;
               
               case 2:
                 sp2.trickleSpaceShip(new SpaceShip((int)sp2.plan.planetPosition.x,(int)sp2.plan.planetPosition.y,t));
               break;
               
               case 3:
                 sp3.trickleSpaceShip(new SpaceShip((int)sp2.plan.planetPosition.x,(int)sp2.plan.planetPosition.y,t));
               break;
              }
             }
          }
          break;
          case 4:
             sp2.orbitAstroid();
          break;
          case 5:
          if(p.timer < 90){
            for(int j=0; j<5 ; j++){
             int t = (int)random(1,4);
              switch(t)
              {
               case 1:
                 sp1.trickleSpaceShip(new SpaceShip((int)sp3.plan.planetPosition.x,(int)sp3.plan.planetPosition.y,t));
               break;
               
               case 2:
                 sp2.trickleSpaceShip(new SpaceShip((int)sp3.plan.planetPosition.x,(int)sp3.plan.planetPosition.y,t));
               break;
               
               case 3:
                 sp3.trickleSpaceShip(new SpaceShip((int)sp3.plan.planetPosition.x,(int)sp3.plan.planetPosition.y,t));
               break;
              }
             }
          }
          break;
          case 6:
               sp3.orbitAstroid();
          break;          
        }
      }
      else{
        //p.c = color(0,255,255); 
        if(State3Counter > 0){
        State3Counter --;
        }
      }
    }
    println(".");
    
   if(State3Counter > 5 && State3Counter < 9){
     //print(State3Counter);
     State3Counter = 10;
     println("trigger cosmic event!"); 
     cph.startRun();
    }
    else{
     //println(State3Counter); 
    }
   }
   
   void particlesOnPoint(int x, int y){
    ps.origin = new PVector(x,y);
    for(int i = 0; i < 100; i++){
      ps.addParticle();
    } 
   }
}
