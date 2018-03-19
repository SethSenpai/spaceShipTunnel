boolean triggerFrames(int skip){
 if(frameCount % skip == 1){
   return true;
 }
 else
 {
   return false;
 }
}
