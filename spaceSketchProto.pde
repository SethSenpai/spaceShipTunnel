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

void setup(){
  fullScreen(P2D,SPAN);
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
  tPoints.addPoint(300,300,3,2);
  tPoints.addPoint(400,400,4,2);
  
  nebula = loadShader("nebula.glsl");
  nebula.set("resolution",float(width),float(height));
  
  //set this to adjust for final resolution during projection
  iR = new iRenderer(width,height,0);
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
  
  //make sure the internal resolution is rendered. THIS METHOD MUST ALWAYS BE CALLED LAST IN THE DRAW STACK!
  iR.render();
  
}

//used for simulation of touchpoint explosions
void mousePressed(){

}

void keyPressed(){
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
}
