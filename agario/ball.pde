class Ball{
  
  final static float defaultSpeed = 5;
  final static float defaultSize = 30;
  final static float defaultRadius = 15;//default hitbox
  PVector location;
  int energy;
  float size;
  float radius;
  float speed;
  float speedFactor = 1;
  float energySpeedModifier = -0.005; //represent speedLost per energy
  float energySizeModifier = 0.05; // represent sizeGain per energy
  
  boolean available;
  Ball(PVector location, int energy){
    available = true;
    this.location = location;
    this.energy = energy;
    adjustSize();
    adjustSpeed();
  }
  
  void update(PVector targetLocation){
    
    speedFactor = 1;
    
    checkFoodColision();
    checkFireColision();
    checkPlayerColision();
    checkIceColision();
    checkMudColision();
    adjustSize();
    adjustSpeed();
    moveTo(targetLocation);
    checkEdges();
  }
  
  void moveTo(PVector targetLocation){
    PVector desired = PVector.sub(targetLocation,location);
    desired.limit(speed);
    location.add(desired);
  }
  
  void checkEdges(){
    
    if(location.x - radius < 0 )
      location.x = radius;
    if(location.x + radius > width )
      location.x = width - radius;
    if(location.y - radius < 0 )
      location.y = radius;
    if(location.y + radius > height )
      location.y = height - radius;
  }
  void adjustSize(){
    size = (float)(defaultSize + (energySizeModifier * energy));
    radius = (float)size * 0.5;
  }
  
  void adjustSpeed(){
    speed = (float)((float)(defaultSpeed + (energySpeedModifier * energy))) * speedFactor;
    if(speed < 1)
      speed = 1;
  }
  
  void display(){
    fill(#0f12d8);
    noStroke();
    ellipse(location.x,location.y,size,size);
    
  }
  
  void checkFoodColision(){
    
    for(Food f:foods)
      if(PVector.dist(location,f.location) < radius){
        energy += f.energy;
        f.die();
      }
  }
  
  void checkPlayerColision(){
    
    for(Player p:players)
      if(PVector.dist(location,p.ball.location) < radius - p.ball.radius && p.ball.available){
        energy += p.ball.energy;
        p.ball.die();
      }
  }
  void checkFireColision(){
    
    for(Fire f:fires)
      if(PVector.dist(location,f.location) < radius + Fire.radius)
        die();
  }
  void checkMudColision(){
    
    for(Mud m:muds)
      if(PVector.dist(location,m.location) <  Mud.radius)
        speedFactor = 0.25;
  }
  void checkIceColision(){
   
    for(Ice i:ices)
      if(PVector.dist(location,i.location) <  Ice.radius)
        speedFactor = 2;
  }
  void die(){
    available = false;
  }
}