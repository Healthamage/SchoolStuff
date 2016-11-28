class Mud{
  
  final static float defaultSize = 100;
  final static float radius = 50;
  PVector location;
  float size;
  
  Mud(PVector location){
    this.location = location;
    size = defaultSize;
  }
  
  void display(){
    fill(#b25305);
    noStroke();
    ellipse(location.x,location.y,size,size);
    
  }
}