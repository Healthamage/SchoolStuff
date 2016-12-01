
class InputLayer extends Layer{
  
  InputLayer(int nbrInputs){
    neurons = new Neuron[nbrInputs];
    for(int i = 0 ; i < nbrInputs ; i++)
      neurons[i] = new Neuron(0);
  }
  
}