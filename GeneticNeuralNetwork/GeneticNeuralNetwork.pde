//todo revoir a ne pas obliger l attribution des inputs a la construction du neuralNetwork
//voir a l evaluation des neuralNetwork avec une series de input et de output desired
NeuralNetworkColony nnc;
void setup(){
  size(640,480);
  
  nnc = new NeuralNetworkColony(2,1);
  
}

void draw(){
  background(255);
  fill(0);
  ArrayList<Float> inputs = new ArrayList<Float>();
  inputs.add(random(100));
  inputs.add(random(100));
  ArrayList<Float> desiredOutputs = new ArrayList<Float>();
  desiredOutputs.add(inputs.get(0) + inputs.get(1) );

  nnc.update(inputs,desiredOutputs);
  text(inputs.get(0) +" + " + inputs.get(1) +" = " + nnc.getBestOutputs().get(0) , 20,20);
  
  
  
  
  
  float error = nnc.getBestOutputs().get(0) - desiredOutputs.get(0);
  text("error = " + error, 20,40);
  delay(50);
 
}