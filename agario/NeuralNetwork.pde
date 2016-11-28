//input layer
//distance to closest food 
//distance to closest fire

//difference between energy with each ennemis
//distance to each ennemis

//first analyse layer
//computing foodWeight with defaultFoodWeight and foodWeightLost per distance                #defaultFoodWeight #foodWeightLost
//computing fireWeight with defaultFireWeight and fireWeightLost per distance                #defaultFireWeight #fireWeightLost
//computing the ennemisWeight with the difference between energy                             #ennemisWeightPerEnergy
//computing the ennemisWeight with the ennemisWeight and the ennemisWeightLost per distance  #ennemiWeightLost

//second analyse layer
//compute the decision of what to do attack ennemis, flee ennemis , eat food, avoid fire depending of the weight of ennemis food and fire

//output layer
//compute desired location
public enum Decision{EATFOOD,AVOIDFIRE,EATENNEMI,AVOIDENNEMI,STANDSTILL,RANDOMMOVE}
class NeuralNetwork{
  
  float FoodWeight;
  float foodWeightLost;
  float FireWeight;
  float fireWeightLost;
  float ennemisWeight;
  float ennemisWeightLost;
  float randomWeight;
  float standWeight;
  float ennemisEnergyWeight;
  Player player;
  
  NeuralNetwork(Player player){
    this.player = player;
    FoodWeight = NeuralNetworkModel.FoodWeight + random(-NeuralNetworkModel.FoodWeightVariance,NeuralNetworkModel.FoodWeightVariance);
    foodWeightLost = NeuralNetworkModel.foodWeightLost + random(-NeuralNetworkModel.foodWeightLostVariance,NeuralNetworkModel.foodWeightLostVariance);
    
    FireWeight = NeuralNetworkModel.FireWeight + random(-NeuralNetworkModel.FireWeightVariance,NeuralNetworkModel.FireWeightVariance);
    fireWeightLost = NeuralNetworkModel.fireWeightLost + random(-NeuralNetworkModel.fireWeightLostVariance,NeuralNetworkModel.fireWeightLostVariance);
    
    ennemisWeight = NeuralNetworkModel.ennemisWeight + random(-NeuralNetworkModel.ennemisWeightVariance,NeuralNetworkModel.ennemisWeightVariance);
    ennemisWeightLost = NeuralNetworkModel.ennemisWeightLost + random(-NeuralNetworkModel.ennemisWeightLostVariance,NeuralNetworkModel.ennemisWeightLostVariance); 
    
    randomWeight = NeuralNetworkModel.randomWeight + random(-NeuralNetworkModel.randomWeightVariance,NeuralNetworkModel.randomWeightVariance);
    standWeight = NeuralNetworkModel.standWeight + random(-NeuralNetworkModel.standWeightVariance,NeuralNetworkModel.standWeightVariance);
    
    ennemisEnergyWeight = NeuralNetworkModel.ennemisEnergyWeight + random(-NeuralNetworkModel.ennemisEnergyWeightVariance,NeuralNetworkModel.ennemisEnergyWeightVariance);
    
    if(FoodWeight < 0)
      FoodWeight = 0;
    if(foodWeightLost < 0)
      foodWeightLost = 0;
      
    if(FireWeight < 0)
      FireWeight = 0;
    if(fireWeightLost < 0)
      fireWeightLost = 0;
      
    if(ennemisWeight < 0)
      ennemisWeight = 0;
    if(ennemisWeightLost < 0)
      ennemisWeightLost = 0;
      
    if(randomWeight < 0)
      randomWeight = 0;
    if(standWeight < 0)
      standWeight = 0;

  }
  
  
  PVector getOutput(){
    
  //FIRST LAYER INPUT
    //ennemis data
    float bestDistance = 99999;
    float distance;
    int index = 0;
    for(int i = 0 ; i < players.size();i++)
      if((distance = PVector.dist(player.ball.location,players.get(i).ball.location)) < bestDistance && distance != 0){
        bestDistance = distance;
        index = i;
      }
    Player closestPlayer = players.get(index);
    
    //fire data
    bestDistance = 99999;
    for(int i = 0 ; i < fires.size();i++)
      if((distance = PVector.dist(player.ball.location,fires.get(i).location)) < bestDistance){
        bestDistance = distance;
        index = i;
      }
    Fire closestFire = fires.get(index);
    
    //food data
    bestDistance = 99999;
    for(int i = 0 ; i < foods.size();i++)
      if((distance = PVector.dist(player.ball.location,foods.get(i).location)) < bestDistance){
        bestDistance = distance;
        index = i;
      }
    Food closestFood = foods.get(index);
    
    
  //FIRST LAYER ANALYSE CALCULE THE WEIGHT OF EACH ELEMENT
    float foodDecisionWeight = (float) FoodWeight - (foodWeightLost * (PVector.dist(player.ball.location,closestFood.location) - NeuralNetworkModel.distRef));
    float fireDecisionWeight = (float) FireWeight - (fireWeightLost * (PVector.dist(player.ball.location,closestFire.location)- NeuralNetworkModel.distRef));
    float ennemiDecisionWeight = (float) ennemisWeight - (ennemisWeightLost * (PVector.dist(player.ball.location,closestPlayer.ball.location)- NeuralNetworkModel.distRef));
    ennemiDecisionWeight += (float)ennemisEnergyWeight * (player.ball.energy - closestPlayer.ball.energy);
    //println("food: "+foodDecisionWeight);
    //println("fire: "+fireDecisionWeight);
    //println("ennemi: "+ennemiDecisionWeight);
  //SECOND LAYER ANALYSE HIGHEST WEIGHT
    Decision decision = Decision.EATFOOD;
    float bestWeight = foodDecisionWeight;
    if(fireDecisionWeight > bestWeight){
      decision = Decision.AVOIDFIRE;
      bestWeight = fireDecisionWeight;
    }
    if(ennemiDecisionWeight > bestWeight){
      bestWeight = ennemiDecisionWeight;
      if(closestPlayer.ball.energy >= player.ball.energy)
        decision = Decision.AVOIDENNEMI;
      else
        decision = Decision.EATENNEMI;
    }
    if(fireDecisionWeight > bestWeight){
      decision = Decision.AVOIDFIRE;
      bestWeight = fireDecisionWeight;
    }
    /*
    if(randomWeight > bestWeight){
      decision = Decision.RANDOMMOVE;
      bestWeight = randomWeight;
    }*/
    if(standWeight > bestWeight){
      decision = Decision.STANDSTILL;
      bestWeight = standWeight;
    }
  //output APPLY DECISION
    PVector output;
    PVector diff;
    switch(decision){
      case EATFOOD:
        diff = PVector.sub(player.ball.location,closestFood.location);
        output = PVector.sub(player.ball.location,diff);
        break;
      case AVOIDFIRE:
        diff = PVector.sub(player.ball.location,closestFire.location);
        output = PVector.add(player.ball.location,diff);
        break;
      case EATENNEMI:
        diff = PVector.sub(player.ball.location,closestPlayer.ball.location);
        output = PVector.sub(player.ball.location,diff);
        break;
      case AVOIDENNEMI:
        diff = PVector.sub(player.ball.location,closestPlayer.ball.location);
        output = PVector.add(player.ball.location,diff);
        break;
      case RANDOMMOVE:
        output = new PVector(random(width),random(height));
        break;
      case STANDSTILL:
        output = player.ball.location;
        break;
      default:
        output = new PVector(0,0);
    }
    println(decision);
    return output;
    
  }
}