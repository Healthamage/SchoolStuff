class NeuralNetworkColony{
  int networkAmount = 100;
  int bestNetworkAmount = 10;//must be sqrt of networkAmount
  ArrayList<NeuralNetwork> neuralNetworks;  
  ArrayList<Float> bestOutputs;
  int nbrInputs;
  int  nbrOutputs;
  float mutateRate = 0.01;
  NeuralNetworkColony(int nbrInputs,int  nbrOutputs){
    this.nbrInputs = nbrInputs;
    this.nbrOutputs = nbrOutputs;
    neuralNetworks = new  ArrayList<NeuralNetwork>();
    for(int i = 0 ; i < networkAmount ; i++)
      neuralNetworks.add(new NeuralNetwork(nbrInputs,nbrOutputs));
  }
  
  void update(ArrayList<Float> inputs,ArrayList<Float> desiredOutput){
    compute(inputs);
    evaluate(desiredOutput);
    //debug();
    reproduction();
    mutate();
    
  }
  
//step 1 
  void compute(ArrayList<Float> inputs){
    for(NeuralNetwork nn:neuralNetworks)
      nn.compute(inputs);
  }
  
//step 2 
  void evaluate(ArrayList<Float> desiredOutput){
    
    for(NeuralNetwork nn:neuralNetworks){
      nn.fitness = 0;
      for(int i = 0 ; i < desiredOutput.size();i++)
        nn.fitness += abs(desiredOutput.get(i) - nn.outputLayer.neurons[i].value);
    }
    java.util.Collections.sort(neuralNetworks);
    bestOutputs = new ArrayList<Float>();
    for(int i = 0 ; i < neuralNetworks.get(0).outputLayer.neurons.length;i++)
      bestOutputs.add(neuralNetworks.get(0).outputLayer.neurons[i].value);
    
  }
  
//step 3
  void reproduction(){
    ArrayList<NeuralNetwork> bestNN = new ArrayList<NeuralNetwork>();
    for(int i = 0 ; i < bestNetworkAmount ; i++)
      bestNN.add(neuralNetworks.get(i));
      
    ArrayList<NeuralNetwork> childs = new ArrayList<NeuralNetwork>();
    for(int i = 0 ; i < bestNetworkAmount ; i++){
      for(int j = 0 ; j < bestNetworkAmount ; j++){
        NeuralNetwork newNN = new NeuralNetwork(bestNN.get(i),bestNN.get(j));
        childs.add(newNN);
      }
    } 
    neuralNetworks = childs;
  }
//step 4
  void mutate(){
    
    for(NeuralNetwork nn:neuralNetworks){
      //hidden layer mutate
      for(HiddenLayer h:nn.hiddenLayers){
        for(Neuron n : h.neurons){
          for(Connection c: n.connections){
            if(random(1) > mutateRate){
              c.weight += random(-0.10,0.10);
            }
          }
        }
      }
      //output layer mutate
      for(Neuron n : nn.outputLayer.neurons){
        for(Connection c: n.connections){
          if(random(1) > mutateRate){
            c.weight += random(-0.10,0.10);
          }
        }
      }
    }
  }
  
  void debug(){
    NeuralNetwork bestNN = neuralNetworks.get(0);
    for(int i = 0 ;i < 2 ; i++)
      println( bestNN.inputLayer.neurons[i].value+"\n");
    for(int i = 0 ;i < 4 ; i++)
      println( bestNN.hiddenLayers.get(0).neurons[i].value+"\n");
  }
  
  
  
  ArrayList<Float> getBestOutputs(){
    return bestOutputs;
  }
  
  
}