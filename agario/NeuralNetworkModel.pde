static class NeuralNetworkModel{
 
  
  static float distRef = 100;
  
  static float FoodWeight = 1 ;
  static float foodWeightLost = 0.01;
  static float FireWeight = 1;
  static float fireWeightLost = 0.01;
  static float ennemisWeight = 1;
  static float ennemisWeightLost = 0.01;
  static float ennemisEnergyWeight = 0.1;
  static float randomWeight = 1;
  static float standWeight = 1;
  
  static float FoodWeightVariance = 0.5 ;
  static float foodWeightLostVariance  = 0.005;
  static float FireWeightVariance  = 0.5;
  static float fireWeightLostVariance  = 0.005;
  static float ennemisWeightVariance  =0.5;
  static float ennemisWeightLostVariance  = 0.005;
  static float ennemisEnergyWeightVariance = 0.01;
  static float randomWeightVariance = 0.5;
  static float standWeightVariance = 0.5;
  
  
  
  
  
  static void neuralNetworkEvaluation(ArrayList<Player> players){
    
    FoodWeight = 0.5 * FoodWeight;
    foodWeightLost = 0.5 * foodWeightLost;
    FireWeight = 0.5 * FireWeight;
    fireWeightLost = 0.5 * fireWeightLost;
    ennemisWeight = 0.5 * ennemisWeight;
    ennemisWeightLost = 0.5 * ennemisWeightLost;
    randomWeight = 0.5 * randomWeight;
    standWeight = 0.5 * standWeight;
    ennemisEnergyWeight = 0.5 * ennemisEnergyWeight;
    
    //calcul de la ponderation
    float ponderation;
    int allPlayerScore = 0;
    for(Player p:players)
      allPlayerScore += p.ball.energy - Player.defaultBallEnergy;
    if(allPlayerScore > 0){
      
      for(Player p:players){
        ponderation = (float) (((float)(p.ball.energy - Player.defaultBallEnergy)) / allPlayerScore);
        
        FoodWeight += (float)ponderation * p.AI.FoodWeight * 0.5;
        foodWeightLost += (float)ponderation * p.AI.foodWeightLost * 0.5;
        FireWeight += (float)ponderation * p.AI.FireWeight * 0.5;
        fireWeightLost+= (float)ponderation * p.AI.fireWeightLost * 0.5;
        ennemisWeight += (float)ponderation * p.AI.ennemisWeight * 0.5;
        ennemisWeightLost += (float)ponderation * p.AI.ennemisWeightLost * 0.5;
        randomWeight += (float)ponderation * p.AI.randomWeight * 0.5;
        standWeight += (float)ponderation * p.AI.standWeight * 0.5;
        ennemisEnergyWeight += (float)ponderation * p.AI.ennemisEnergyWeight * 0.5;
      }
    }
    else{
      
      FoodWeight *= 2;
      foodWeightLost *= 2;
      FireWeight *= 2;
      fireWeightLost *= 2;
      ennemisWeight *= 2;
      ennemisWeightLost *= 2;
      randomWeight *= 2;
      standWeight *= 2; 
      ennemisEnergyWeight *= 2;
    }
    
  }
}