class SpaceShip{
  
  int teamID ;
  PImage  spaceShipImage;
  PVector position ;
  PVector velocity ;
  PVector acceleration ;
  PVector targetPlanet ;
  
  float maxSpeed ;
  float maxforce ;
  
  boolean isSpaceShipLaunched = false;
  
    float angle;
     
  SpaceShip(int xPos, int yPos, int id_)
  {
    teamID = id_;
    spaceShipImage = getImage(teamID);
    //spaceShipImage.resize(50,35);    
    position = new PVector(xPos,yPos); 

    acceleration = new PVector(0,0);  
    
    //initial velocity ;
    float rot = random(0,360);
    float speed = random(0,3);
    float x = speed * cos(rot);
    float y = speed * sin(rot);
    velocity = new PVector(x,y);
    //velocity = new PVector(0,-2);
    
    maxSpeed = 2; 
    maxforce = 0.1;
 }  

void runSpaceShip(){
   seek(getTargetPlanetPosition(teamID));
   update();
   display(); 
}

void launchSpaceShip(PVector launchPosition){
  isSpaceShipLaunched = true;
  position = launchPosition;
  display();
} 


void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

void seek(PVector target){
   
   PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
   if(desired.mag()< 100)
   {
     revolve(target);
   }
   else {
    // Scale to maximum speed   
    desired.setMag(maxSpeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    
    applyForce(steer);
   }
    
}

void revolve(PVector target){
  
  //find the angle between the points
  //PVector delta = PVector.sub(target,position);
  //angle = atan2(delta.x,delta.y);
 
  println("angle " + cos(angle));
  
  position.x = target.x - cos(angle)*100;
  position.y = target.y - sin(angle)*100;
   
  angle = angle + 0.1; 
  
}

// Method to update position
void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxSpeed);
    position.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

void display(){
   image(spaceShipImage, position.x, position.y);
   //shape(spaceShipImage, position.x, position.y, 40, 25);

}

void createShape(){

}


boolean launchStatus(){
 return isSpaceShipLaunched;
}

PImage getImage(int ID){

  switch(ID){
  case 1:
  return loadImage("ship_yellow.png");
  
  case 2:
  return loadImage("ship_red.png");
  
  case 3:
  return loadImage("ship_green.png");

  default:
  return loadImage("ship_yellow.png");  
  }
}

PVector getTargetPlanetPosition(int ID){
 
  
  switch(ID){
  case 1:
  return new PVector(400,500) ;
  
  case 2:
  return new PVector(800,250) ;
  
  case 3:
  return new PVector(1100,350) ;

  default:
  return new PVector(400,500) ;
  }
  
}

}