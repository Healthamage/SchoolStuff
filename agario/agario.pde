//TODO 
//la methode getOutput dans le neuralNetwork qui va faire l analyse des inputs et donnees un PVector desired pour la ball


//time management variables
long previousTime = 0;
long currentTime = 0;
long deltaTime;
long displayAcc = 0;
long displayDelay = 25;
long updateAcc = 0;
long updateDelay = 25;
long gameAcc = 0;
long gameDelay = 30000;
int gameCount = 0;

long foodRespawnAcc;
long foodRespawnDelay = 500;

int startingFoodAmount = 100;
int fireAmount = 5;
int playerAmount = 10;
int mudAmount = 5;
int iceAmount = 5;
ArrayList<Food> foods;
ArrayList<Fire> fires;
ArrayList<Player> players;
ArrayList<Mud> muds;
ArrayList<Ice> ices;

void setup(){
  fullScreen();
  //size(640,480);
  
  createGame();
 
}

void draw(){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime; 
  
  updateAcc += deltaTime;
  if(updateAcc > updateDelay){
    updateAcc = 0 ;
    update();
  }
  
  displayAcc += deltaTime;
  if(displayAcc > displayDelay){
    displayAcc = 0 ;
    display();
  }

  gameAcc += deltaTime;
  if(gameAcc > gameDelay)
    gameFinish();
  
  foodRespawnAcc += deltaTime;
  if(foodRespawnAcc > foodRespawnDelay){
    foodRespawnAcc = 0;
    foods.add(new Food(new PVector(random(20,width - 20),random(20, height - 20))));
  }
    
}
void update(){
  
  for(Player p :players)
     p.update();
  
  for(int i = foods.size()-1 ; i >= 0 ;i--)
    if(!foods.get(i).available)
      foods.remove(i);
     
}

void display(){
  
  background(255);
  for(Food f:foods)
    f.display();
  for(Fire f:fires)
    f.display();
  for(Ice i:ices)
    i.display();
  for(Mud m:muds)
    m.display();
  for(Player p:players)
    p.display();
    
  text("gameCount: " + gameCount, 20,10);
  text("foodWeight: " + nfc(NeuralNetworkModel.FoodWeight,2), 200,10);
  text("foodWeightLost: " + nfc(NeuralNetworkModel.foodWeightLost,2), 200,20);
  text("fireWeight: " + nfc(NeuralNetworkModel.FireWeight,2), 350,10);
  text("fireWeightLost: " + nfc(NeuralNetworkModel.fireWeightLost,2), 350,20);
  text("ennemisWeight: " + nfc(NeuralNetworkModel.ennemisWeight,2), 500,10);
  text("ennemisWeightLost: " + nfc(NeuralNetworkModel.ennemisWeightLost,2), 500,20);
  text("ennemisEnergyWeight: " + nfc(NeuralNetworkModel.ennemisEnergyWeight,2), 500,30);
  text("randomWeight: " + nfc(NeuralNetworkModel.randomWeight,2), 650,10);
  text("standWeight: " + nfc(NeuralNetworkModel.standWeight,2), 650,20);
}

void createGame(){
  foods = new ArrayList<Food>();
  fires = new ArrayList<Fire>();
  players = new ArrayList<Player>();
  ices = new ArrayList<Ice>();
  muds = new ArrayList<Mud>();
  
  for(int i = 0 ; i < fireAmount ; i++)
    fires.add(createFire());
  for(int i = 0 ; i < mudAmount ; i++)
    muds.add(createMud());
  for(int i = 0 ; i < iceAmount ; i++)
    ices.add(createIce());
  for(int i = 0 ; i < startingFoodAmount ; i++)
    foods.add(createFood());
  for(int i = 0 ; i < playerAmount ; i++)
    players.add(new Player());

  gameCount++;
}
//to avoid putting food in fire or player
Food createFood(){
  boolean spotAvailable = false;
  PVector spot = new PVector();
  while(!spotAvailable){
    spot.set(random(20,width - 20),random(20, height - 20));
    spotAvailable = true;
    //check for fire colision
    for(Fire f:fires){
      if(PVector.dist(spot,f.location) < Fire.radius + Food.radius)
        spotAvailable = false;
    }
    //check for player colision
    for(Player p:players){
      if(PVector.dist(spot,p.ball.location) < p.ball.radius + Food.radius)
        spotAvailable = false;
    }
  }
  return new Food(spot);
}

//to avoid putting fire onto another fire , mud , ice
Fire createFire(){
  boolean spotAvailable = false;
  PVector spot = new PVector();
  while(!spotAvailable){
    spot.set(random(20,width - 20),random(20, height - 20));
    spotAvailable = true;
    //check for fire colision
    for(Fire f:fires){
      if(PVector.dist(spot,f.location) < Fire.radius * 2)
        spotAvailable = false;
    }
    //check for player colision
    for(Player p:players){
      if(PVector.dist(spot,p.ball.location) < p.ball.radius + Fire.radius)
        spotAvailable = false;
    }
    //check for mud colision
    for(Mud m:muds){
      if(PVector.dist(spot,m.location) < Mud.radius + Fire.radius)
        spotAvailable = false;
    }
    //check for ice colision
    for(Ice i:ices){
      if(PVector.dist(spot,i.location) < Ice.radius + Fire.radius)
        spotAvailable = false;
    }
  }
  return new Fire(spot);
}

//to avoid putting Mud onto fire,ice,another mud
Mud createMud(){
  boolean spotAvailable = false;
  PVector spot = new PVector();
  while(!spotAvailable){
    spot.set(random(20,width - 20),random(20, height - 20));
    spotAvailable = true;
    //check for mud colision
    for(Mud m:muds){
      if(PVector.dist(spot,m.location) < Mud.radius * 2)
        spotAvailable = false;
    }
    //check for ice colision
    for(Ice i:ices){
      if(PVector.dist(spot,i.location) < Ice.radius + Mud.radius)
        spotAvailable = false;
    }
    //check for fire colision
    for(Fire f:fires){
      if(PVector.dist(spot,f.location) < Fire.radius + Mud.radius)
        spotAvailable = false;
    }
  }
  return new Mud(spot);
}

//to avoid putting ice onto fire,mud,another ice
Ice createIce(){
  boolean spotAvailable = false;
  PVector spot = new PVector();
  while(!spotAvailable){
    spot.set(random(20,width - 20),random(20, height - 20));
    spotAvailable = true;
    //check for mud colision
    for(Mud m:muds){
      if(PVector.dist(spot,m.location) < Mud.radius + Ice.radius)
        spotAvailable = false;
    }
    //check for ice colision
    for(Ice i:ices){
      if(PVector.dist(spot,i.location) < Ice.radius * 2)
        spotAvailable = false;
    }
    //check for fire colision
    for(Fire f:fires){
      if(PVector.dist(spot,f.location) < Fire.radius + Ice.radius)
        spotAvailable = false;
    }
  }
  return new Ice(spot);
}


void gameFinish(){
  
  NeuralNetworkModel.neuralNetworkEvaluation(players);
  createGame();
  gameAcc = 0;
}