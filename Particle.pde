//class containing the particle object used in the particle system

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector(0,0);
  float lifespan;
  

  Particle(PVector l) {
    float rot = random(0,360);
    float speed = random(0,3);
    
    float x = speed * cos(rot);
    float y = speed * sin(rot);
    
    velocity = new PVector(x,y);
    
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    float x = velocity.x;
    float y = velocity.y;
    x = (x * -1) / 1000;
    y = (y * -1) / 1000;
    acceleration.add(new PVector(x,y));
    
    velocity.add(acceleration);
    if(velocity.x < 0.1 && velocity.x > -0.1)
    {
      x = 0;
      velocity.x = 0;
    }
    if(velocity.y < 0.1 && velocity.y > -0.1)
    {
      y = 0;
      velocity.y = 0;
    }
   
    position.add(velocity);
    float lspan = random(0.3,8);
    lifespan -= lspan;
  }

  // Method to display
  void display() {
    stroke(255,221,106, lifespan);
    fill(255,221,106, lifespan);
    ellipse(position.x, position.y, 1, 1);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
