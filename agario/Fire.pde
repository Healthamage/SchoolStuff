class Fire{
  
  final static float defaultSize = 75;
  final static float radius = 37.5; //hitbox
  PVector location;
  float size; //<>//
  
  Fire(PVector location){
    this.location = location;
    size = defaultSize;
  }
  
  void display(){
    fill(#ff5d00);
    noStroke();
    ellipse(location.x,location.y,size,size);
    
  }
}