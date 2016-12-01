
class Neuron{
  float value = 0;
  ArrayList<Connection> connections = new ArrayList<Connection>();
  
  Neuron(){}
  
  Neuron(float value){
    this.value = value;
  }
  
  Neuron(ArrayList<Connection> connections){
    this.connections = connections;
  }
  
  void compute(){
    value = 0;
    for(Connection c:connections)
      value += c.neuron.value * c.weight;
      
  }
  
  void addConnection(Connection connection){connections.add(connection);}
  
}