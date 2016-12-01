class Connection{

  float weight;
  Neuron neuron;
  Connection(Neuron neuron){
    this.neuron = neuron;
    weight = random(-1,1);
  }
  
//REPRODUCTION CONSTRUCTOR
  Connection(Connection male , Connection female, Neuron neuron){
    this.neuron = neuron;
    weight = (float)0.5 * (male.weight + female.weight);
  }
}