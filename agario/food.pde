class Food{
  final static int defaultEnergy = 10;
  final static int defaultSize = 10;
  static final float radius = 5; //hitbox
  PVector location;
  int energy;
  float size;
  boolean available;
  
  Food(PVector location){
    this.location = location;
    size = defaultSize;
    energy = defaultEnergy;
    available = true;
  }
  
  void die(){
    available = false;
    energy = 0;
  }
  
  void display(){
    
    fill(#d8950f);
    noStroke();
    ellipse(location.x,location.y,size,size);
  }

}