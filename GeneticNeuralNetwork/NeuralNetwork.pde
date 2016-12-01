class NeuralNetwork implements Comparable{
//build variables
  InputLayer inputLayer;
  OutputLayer outputLayer;
  ArrayList<HiddenLayer> hiddenLayers;
  int hiddenLayerAmount;
  int hiddenLayerPerceptronAmount;
  
  float fitness;
  
  NeuralNetwork(int nbrInputs, int nbrOutput){
  //input layer
    inputLayer = new InputLayer(nbrInputs);
    
  //hidden layer
    hiddenLayers = new ArrayList<HiddenLayer>();
    hiddenLayerAmount = (int)Math.cbrt(nbrInputs);
    hiddenLayerPerceptronAmount = nbrInputs +1;
    int hiddenLayerPerceptronWeightAmount = nbrInputs;
    Layer previousLayer = inputLayer;
    for(int i = 0 ; i < hiddenLayerAmount ;i++){
      hiddenLayers.add(new HiddenLayer(hiddenLayerPerceptronAmount,previousLayer));
      hiddenLayerPerceptronWeightAmount = hiddenLayerPerceptronAmount;
      previousLayer = hiddenLayers.get(i);
    }
    
  //output layer
    outputLayer = new OutputLayer(nbrOutput,hiddenLayers.get(hiddenLayers.size()-1));  
  }
  
  
//REPRODUCTION CONSTRUCTOR
  NeuralNetwork(NeuralNetwork male, NeuralNetwork female){
    int nbrInputs = male.inputLayer.neurons.length;
  //input layer
    inputLayer = new InputLayer(nbrInputs);
    
  //hidden layer
    hiddenLayers = new ArrayList<HiddenLayer>();
    hiddenLayerAmount = male.hiddenLayerAmount;
    hiddenLayerPerceptronAmount = nbrInputs +1;
    Layer previousLayer = inputLayer;
    for(int i = 0 ; i < hiddenLayerAmount ;i++){
      hiddenLayers.add(new HiddenLayer(male.hiddenLayers.get(i),female.hiddenLayers.get(i),previousLayer));
      previousLayer = hiddenLayers.get(i);
    }
    
    
  //output layer
    outputLayer = new OutputLayer(male.outputLayer,female.outputLayer,previousLayer);  
  }





  void compute(ArrayList<Float> inputs){
    for(int i = 0 ; i < inputLayer.neurons.length;i++)
      inputLayer.neurons[i].value = inputs.get(i);

    for(HiddenLayer h:hiddenLayers)
      h.compute();
    outputLayer.compute();
    
  }
  
  void display(){
 
  }
  
  int compareTo(Object other){
    NeuralNetwork neuralNetwork = (NeuralNetwork)other;
    return Float.compare(fitness, neuralNetwork.fitness);
  }
}