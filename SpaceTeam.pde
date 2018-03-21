class SpaceTeam{

  ArrayList<SpaceShip> spaceTeam;
  int spaceTeamID ;
  PVector origin;
  boolean spawned;
  int counter;
  Planet astroid;

  SpaceTeam(int id, Planet a){
      spaceTeam = new ArrayList<SpaceShip>();
      spaceTeamID = id;
      spawned = false;
      counter = 0;
      astroid = a;
  }

  SpaceTeam(PVector position) {
    origin = position.copy();
    spaceTeam = new ArrayList<SpaceShip>();
  }

  //void addParticle() {
  //  //spaceTeam.add(new sap(origin));
  //}
  
  void addSpaceShip(SpaceShip spaceShip){
    spaceTeam.add(spaceShip);  
  }
  
  //void run() {
  //  for (int i = particles.size()-1; i >= 0; i--) {
  //    Particle p = particles.get(i);
  //    p.run();
  //    if (p.isDead()) {
  //      particles.remove(i);
  //    }
  //  }
  //}
  
  void trickleSpaceShip(SpaceShip spaceShip){
    if(frameCount % 40 == 1){
     if(counter < 10 && spawned == false){
      counter ++; 
      spaceTeam.add(spaceShip); 
     }
     else{
      spawned = true; 
      counter = 0;
     }
    }
  }
  
  void orbitAstroid(){
    for(int i=0 ; i< spaceTeam.size(); i++)
   {
     SpaceShip ship = spaceTeam.get(i);
     //ship.goToAstroid = true;
     ship.goAstroid(astroid);
   } 
  }
  
  void run()
  {    
   for(int i=0 ; i< spaceTeam.size(); i++)
   {
     SpaceShip ship = spaceTeam.get(i);
     ship.runSpaceShip();
     if (ship.isDead()) {
        spaceTeam.remove(i);
        astroid.planetSize ++ ;
      }
   } 
  }
  
  
}
