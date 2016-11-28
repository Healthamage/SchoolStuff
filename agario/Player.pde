class Player{

    Ball ball;
    NeuralNetwork AI;
    final static int defaultBallEnergy = 100;
    boolean IAControlled;
    Player(){
      AI = new NeuralNetwork(this);
      ball = createBall();
      IAControlled = true;
    }
     Player(boolean IAControlled){
      this.IAControlled = IAControlled;
      if(this.IAControlled)
        AI = new NeuralNetwork(this);
      
      ball = createBall();
    }
    
    void update(){
      PVector targetLocation;
      if(IAControlled)
        targetLocation = AI.getOutput();
      else
        targetLocation = new PVector(mouseX,mouseY);
        
      ball.update(targetLocation);
      if(!ball.available)
        ball = createBall();
      
    }
    
    void display(){
      ball.display();
    }
    
    //to avoid putting ball into fire or food
    Ball createBall(){
      boolean spotAvailable = false;
      PVector spot = new PVector();
      while(!spotAvailable){
        spot.set(random(20,width - 20),random(20, height - 20));
        spotAvailable = true;
        //check for fire colision
        for(Fire f:fires){
          if(PVector.dist(spot,f.location) < Fire.radius + Ball.defaultRadius)
            spotAvailable = false;
        }
        //check for player colision
        for(Player p:players){
          if(PVector.dist(spot,p.ball.location) < p.ball.radius * 2)
            spotAvailable = false;
        }
      }
      return new Ball(spot,defaultBallEnergy);
    }
}