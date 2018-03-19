//class handling the internal rendering of the sketch

class iRenderer{
  int iWidth;
  int iHeight;
  color bColor;
  
  iRenderer(int w, int h, color c){
    iWidth = w;
    iHeight = h;
    bColor = c;
  }
  
  void render(){
    float x = (width - iWidth ) / 2;
    float y = (height - iHeight) /2;
    
    fill(bColor);
    noStroke();
    
    //top block
    rect(0,0,width,y);
    
    //bottom block
    rect(0,height - y,width,y);
    
    //left block
    rect(0,0,x,height);
    
    //right block
    rect(width - x,0,x,width);
    
    stroke(1);
  }
}
