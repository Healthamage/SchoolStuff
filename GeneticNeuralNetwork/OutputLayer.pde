class OutputLayer extends Layer{
  
  OutputLayer(int nbrOutput,Layer previousLayer){
    neurons = new Neuron[nbrOutput];
    int nConn = previousLayer.neurons.length;
    
    for(int j = 0 ; j < nbrOutput ; j++){
      ArrayList<Connection> connections = new ArrayList<Connection>();
      for(int i = 0 ; i < nConn ; i++)
        connections.add(new Connection(previousLayer.neurons[i]));
      neurons[j] = new Neuron(connections);
    }  
  }
//REPRODUCTION CONSTRUCTOR
  OutputLayer(OutputLayer male,OutputLayer female,Layer previousLayer){
    int NNeuron = male.neurons.length;
    int nConn = previousLayer.neurons.length;
    neurons = new Neuron[NNeuron];
    
    for(int j = 0 ; j < NNeuron ; j++){
      ArrayList<Connection> connections = new ArrayList<Connection>();
      for(int i = 0 ; i < nConn ; i++)
        connections.add(new Connection(male.neurons[j].connections.get(i),female.neurons[j].connections.get(i),previousLayer.neurons[i]));
      neurons[j] = new Neuron(connections);
    } 
  }
  
  void compute(){
    for(Neuron n:neurons)
      n.compute();
  }
}