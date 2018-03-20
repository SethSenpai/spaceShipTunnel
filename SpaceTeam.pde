class SpaceTeam{

  ArrayList<SpaceShip> spaceTeam;
  int spaceTeamID ;
  PVector origin;

  SpaceTeam(int id){
      spaceTeam = new ArrayList<SpaceShip>();
      spaceTeamID = id;
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
  
  void run()
  {    
   for(int i=0 ; i< spaceTeam.size(); i++)
   {
     SpaceShip ship = spaceTeam.get(i);
     ship.runSpaceShip();
   } 
  }
  
  
}