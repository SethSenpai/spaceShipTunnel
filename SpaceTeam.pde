class SpaceTeam{

  ArrayList<SpaceShip> spaceTeam;
  int spaceTeamID ;
  PVector origin;
  boolean spawned;
  int counter;
  Planet astroid;
  Planet plan;

  SpaceTeam(int id, Planet a, Planet b){
      spaceTeam = new ArrayList<SpaceShip>();
      spaceTeamID = id;
      spawned = false;
      counter = 0;
      astroid = a;
      plan = b;
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
    if(frameCount % 5 == 1){
     if(counter < 2 && spawned == false){
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
     ship.goAstroid(astroid.planetPosition);
   } 
  }
  
  void run()
  {    
   for(int i=0 ; i< spaceTeam.size(); i++)
   {
     SpaceShip ship = spaceTeam.get(i);
     ship.runSpaceShip(astroid.planetSize);
     if (ship.isDead()) {
        spaceTeam.remove(i);
        astroid.planetSize = astroid.planetSize + 0.2; ;
      }
   } 
  }
  
  
}
