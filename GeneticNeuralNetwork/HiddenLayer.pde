//TODO REFAIRE LE LAYER DE REPRODUCTION POUR METTRE LE PREVIOUS LAYER J ATTACHAIS LA NEURONE A ELLE-MEME
class HiddenLayer extends Layer{

  HiddenLayer(int nbrPerceptron,Layer previousLayer){  
    neurons = new Neuron[nbrPerceptron];
    int nConn = previousLayer.neurons.length;
    
    for(int j = 0 ; j < nbrPerceptron ; j++){
      ArrayList<Connection> connections = new ArrayList<Connection>();
      for(int i = 0 ; i < nConn ; i++)
        connections.add(new Connection(previousLayer.neurons[i]));
      neurons[j] = new Neuron(connections);
    } 
  }
  
//REPRODUCTION CONSTRUCTOR
  HiddenLayer(HiddenLayer male , HiddenLayer female,Layer previousLayer){
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