import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.serial.*;

import fisica.*;

FWorld world;
//FCircle FobjOne;
//FCircle FobjTwo;
//FCircle FobjThree;
//FCircle FobjFour;

touchAll tPoints;

ParticleSystem ps; 

iRenderer iR;

bGround bg;

Serial ardCom;
String comVal;

int[] serialInArray = new int[2];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;

PostFX fx;

Planet planet1, planet1_tar, planet2, planet2_tar, planet3, planet3_tar; 

SpaceShip spaceShip;
SpaceTeam spaceTeam1, spaceTeam2, spaceTeam3;

void setup(){
  fullScreen(P2D,SPAN);
  //size(1920,1080,P2D);
  frameRate(60);
  smooth();
  
  tPoints = new touchAll(ps);
  
  ps = new ParticleSystem(new PVector(0,0));  
  
  //setup the world (Setting up physics engine)
  setupWorld();
  //setup the planets (Spawning & Target points)
  setupPlanets();
  
  //set this to adjust for final resolution during projection
  iR = new iRenderer(width,height-40,0);  
  
  String portName = Serial.list()[0];
  ardCom = new Serial(this, portName, 9600);
  ardCom.bufferUntil(10);
  
  fx = new PostFX(this);  
  
    
  //Create spaceTeams that contains multiple spaceships;  
  spaceTeam1 = new SpaceTeam(1);
  spaceTeam2 = new SpaceTeam(2);
  spaceTeam3 = new SpaceTeam(3);
  
  bg = new bGround("background.png",70,0.5);
  
}

void draw(){
  //handle background drawing
  background(0);

  bg.run();
  
  //make sure the touchpoints are drawn
  tPoints.run();
  
  displayPlanets();
  
    //keep particle system running
  ps.run();
    
  //update physics
  world.step();
  world.draw();
  
    fx.render()
    .bloom(0.6, 20, 50)
    .compose();
  
  //make sure the internal resolution is rendered. THIS METHOD MUST ALWAYS BE CALLED LAST IN THE DRAW STACK!
  iR.render();
  

  
    if(spaceTeam1 != null){
     spaceTeam1.run();
  }
  
   if(spaceTeam2 != null){
     spaceTeam2.run();
  }
   
   if(spaceTeam3 != null){
     spaceTeam3.run();
  }
  
}

//used for simulation of touchpoint explosions
void mousePressed(){

}

void keyPressed(){
    // particle simulations
    if(key == '1'){
      tPoints.pointTouched(1); //this would get triggered when someone touches a point
    }
    if(key == '2'){
      tPoints.pointTouched(2); //this would get triggered when someone touches a point
    }
    if(key == '3'){
      tPoints.pointTouched(3); //this would get triggered when someone touches a point
    }
    if(key == '4'){
      tPoints.pointTouched(4); //this would get triggered when someone touches a point
    }
    /*
    if(key == '1'){   
      for(int i=0; i<5 ; i++){
      spaceTeam1.addSpaceShip(new SpaceShip(200,300,1));
      }
    }
    if(key == '2'){
      for(int i=0; i<5 ; i++){
      spaceTeam2.addSpaceShip(new SpaceShip(600,450,2));
      }
    }
    if(key == '3'){
      for(int i=0; i<5 ; i++){
      spaceTeam3.addSpaceShip(new SpaceShip(1000,100,3));
      }
    }
    if(key == '4'){
       planet1_tar.enableGlow = true;
    }*/
}

void serialEvent(Serial ardCom) { 
  comVal = ardCom.readString(); 
  String[] a = comVal.split(",");
  //println(a);
  if(a.length == 6){
   tPoints.updateValues(a);
  }
  else
  {
   println("incomplete input"); 
  }
} 

void setupPlanets(){
  /*
  tPoints.addPoint(100,100,50,1,1);
  tPoints.addPoint(200,200,80,2,1);
  tPoints.addPoint(300,300,50,3,1);
  tPoints.addPoint(400,400,20,4,2);
  tPoints.addPoint(500,300,20,5,2);
  tPoints.addPoint(600,400,20,6,2);
  */
  
  planet1 = new Planet(200,300,50);
  tPoints.addPoint(200,300,50,1,1);
  
  planet1_tar = new Planet(400,500,70);
  tPoints.addPoint(400,500,70,2,2);
  
  planet2 = new Planet(600,450,80);
  tPoints.addPoint(600,450,80,3,1);
  
  planet2_tar = new Planet(800,250,40);
  tPoints.addPoint(800,250,40,4,2);
  
  planet3 = new Planet(1000,100,50);
  tPoints.addPoint(1000,100,50,5,1);
  
  planet3_tar = new Planet(1100,350,75);
  tPoints.addPoint(1100,350,75,6,2);
}

void displayPlanets(){
 
  planet1.display();
  planet1_tar.display();
  planet2.display();
  planet2_tar.display();
  planet3.display();
  planet3_tar.display();
  
}

void setupWorld(){

 Fisica.init(this);
  world = new FWorld();
  world.setGravity(0,0);
  world.setEdges();
}
