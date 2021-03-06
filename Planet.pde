class Planet{
  
 PImage planetImage; 
 PImage glowImage; 
 PVector planetPosition;
 float planetSize ;
 boolean enableGlow = false ;
 color c;
 
   float fadeRate = 0.5 ;
   float x = 1;
   float fadeValue;
 
 Planet(int x, int y, int size, color col)
 {
   //planetImage = loadImage("imageName");
   glowImage = loadImage("glow_yellow.png");
   planetPosition = new PVector(x,y);
   planetSize = size;
   c = col;
 }

 void display(){
  ellipseMode(CENTER);
  //checkForGlow();  
  fill(c);
  noStroke();
  ellipse(planetPosition.x, planetPosition.y, planetSize, planetSize );  
 }

 PVector getPlanetPostition(){
 return  planetPosition;
 }

 float getPlanetSize(){
 return planetSize; 
 } 

 int getLeftLimit(){
 return int ((planetPosition.x - planetSize/2)+10) ;
 }

 int getRightLimit(){
 return int ((planetPosition.x + planetSize/2)+10) ;
 }

 int getTopLimit(){
 return int ((planetPosition.y - planetSize/2)+10);
 }

 int getBottomLimit(){
 return int ((planetPosition.x + planetSize/2)+10) ;
 }

void checkForGlow(){
  if(enableGlow){
     imageMode(CENTER);
     
     fadeValue = fadeValue + (fadeRate * x);
     if(fadeValue < 0 || fadeValue > 150){
     x= x*-1;
     }
     
     tint(255, fadeValue);
     image(glowImage,planetPosition.x, planetPosition.y);
     //glowImage.resize((int)fadeValue, (int)fadeValue);     

  }
  else 
    ellipse(planetPosition.x, planetPosition.y, planetSize, planetSize );  

  
} 

}
