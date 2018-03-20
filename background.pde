class bGround{
  PImage bg;
  float posX;
  float posY;
  float direction;
  float speed;
  int transparency;
  
   bGround(String image , int t, float s){
     bg = loadImage(image);
     transparency = t;
     speed = s;
     direction = 0;
     posX = -1 * (bg.width / 3);
     posY = -1 * (bg.height / 3);     
   }
   
   void run(){
     
    float x = speed * cos(direction);
    float y = speed * sin(direction);
    
    posX = posX + x / 3;
    posY = posY + y / 3;
    
    direction = direction + 0.002;
    
    tint(255,255,255,transparency);
    image(bg,posX,posY);
    noTint();
   }
}
