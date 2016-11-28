class Ice{
  
  final static float defaultSize = 80;
  final static float radius= 40;
  PVector location;
  float size;
  
  
  Ice(PVector location){
    this.location = location;
    size = defaultSize;
  }
  
  void display(){
    fill(#069da3);
    noStroke();
    ellipse(location.x,location.y,size,size);
    
  }
}