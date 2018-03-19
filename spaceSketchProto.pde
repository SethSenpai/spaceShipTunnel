import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import processing.serial.*;

import fisica.*;

FWorld world;
FCircle FobjOne;
FCircle FobjTwo;
FCircle FobjThree;
FCircle FobjFour;

touchAll tPoints;

ParticleSystem ps; 

iRenderer iR;

PShader nebula;

Serial ardCom;
String comVal;

int[] serialInArray = new int[2];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;

PostFX fx;

void setup(){
  //fullScreen(P2D,SPAN);
  size(800,600,P2D);
  frameRate(60);
  smooth();
  
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0,0);
  world.setEdges();
  
  FobjOne = new FCircle(50);
  FobjOne.setFriction(1);
  FobjOne.setFill(255);
  FobjOne.setPosition(200,500);
  world.add(FobjOne);
  
  FobjTwo = new FCircle(50);
  FobjTwo.setFriction(1);
  FobjTwo.setFill(255);
  FobjTwo.setPosition(300,500);
  world.add(FobjTwo);
  
  FobjThree = new FCircle(50);
  FobjThree.setFriction(1);
  FobjThree.setFill(255);
  FobjThree.setPosition(400,500);
  world.add(FobjThree);
  
  FobjFour = new FCircle(50);
  FobjFour.setFriction(1);
  FobjFour.setFill(255);
  FobjFour.setPosition(500,500);
  world.add(FobjFour);
  
  ps = new ParticleSystem(new PVector(0,0));
  
  tPoints = new touchAll(ps);
  
  tPoints.addPoint(100,100,1,1);
  tPoints.addPoint(200,200,2,1);
  tPoints.addPoint(300,300,3,1);
  tPoints.addPoint(400,400,4,1);
  tPoints.addPoint(500,300,5,2);
  tPoints.addPoint(600,400,6,2);
  
  nebula = loadShader("nebula.glsl");
  nebula.set("resolution",float(width),float(height));
  
  //set this to adjust for final resolution during projection
  iR = new iRenderer(width,height-40,0);
  
  String portName = Serial.list()[1];
  ardCom = new Serial(this, portName, 9600);
  ardCom.bufferUntil(10);
  
  fx = new PostFX(this);  
}

void draw(){
  //handle background drawing
  background(0);
  nebula.set("time", millis() / 5000.0);
  shader(nebula);
  rect(0,0,width,height);
  resetShader();
  
  //keep particle system running
  ps.run();
  
  //make sure the touchpoints are drawn
  tPoints.run();
    
  //update physics
  world.step();
  world.draw();
  
    fx.render()
    .bloom(0.6, 20, 50)
    .compose();
  
  //make sure the internal resolution is rendered. THIS METHOD MUST ALWAYS BE CALLED LAST IN THE DRAW STACK!
  iR.render();
  
}

//used for simulation of touchpoint explosions
void mousePressed(){

}

void keyPressed(){
    /* particle simulations
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
