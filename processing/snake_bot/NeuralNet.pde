/*
this file contains the logic for a neural network
with 2 identical hidden layers and biases at every layer.
Gradient descent is not implemented. Functionality
is limited to mutation, crossover, and evaluation
*/
class NeuralNet{
  Matrix wih;//ins -> hidden layer 1
  Matrix whh;//hidden layer 1 -> hidden layer 2
  Matrix who;//hidden layer 2 -> outs
  int ins, hiddens, outs;
  NeuralNet(int ins, int hiddens, int outs){//tested
    //two hidden layers with equal length, all layers are dense
    this.ins = ins;
    this.hiddens = hiddens;
    this.outs = outs;
    //initialize matrix dimensions
    wih = new Matrix(hiddens, ins+1);//ins+1 because bias
    whh = new Matrix(hiddens, hiddens+1);//hiddens+1 because bias
    who = new Matrix(outs, hiddens+1);//hiddens+1 because of bias
    //randomize weights
    wih.randomize();
    whh.randomize();
    who.randomize();
  }//7-18-18 left off about to make more neuralnet methods like evaluate
  
  Matrix evaluate(Matrix in){//basically tested
    //expects input to be formatted as a column vector
    Matrix input = in.addBias();
    
    //evaluate hidden layer 1
    Matrix h1 = wih.matMul(input);
    h1.activate();
    h1 = h1.addBias();
    
    //evaluate hidden layer 2
    Matrix h2 = whh.matMul(h1);
    h2.activate();
    h2 = h2.addBias();
    
    //evaluate output layer
    Matrix out = who.matMul(h2);
    return out;
  }
  
  void mutate(float mutationRate){//tested (through crossover)
    wih.mutate(mutationRate);
    whh.mutate(mutationRate);
    who.mutate(mutationRate);
  }
  
  NeuralNet crossover(NeuralNet other){//tested
    NeuralNet child = new NeuralNet(ins, hiddens, outs);
    Matrix[] thisWeightMatrices = {wih, whh, who};
    Matrix[] otherWeightMatrices = {other.wih, other.whh, other.who};
    Matrix[] childWeightMatrices = new Matrix[3];
    for(int weightInd = 0; weightInd < childWeightMatrices.length; weightInd++){
      Matrix thisMatrix = thisWeightMatrices[weightInd];
      Matrix otherMatrix = otherWeightMatrices[weightInd];
      Matrix childMatrix = new Matrix(thisMatrix.rows, thisMatrix.cols);
      for(int i = 0; i < childMatrix.rows; i++){
        for(int j = 0; j < childMatrix.cols; j++){
          if(random(1) < .5){
            childMatrix.arr[i][j] = thisMatrix.arr[i][j];
          } else {
            childMatrix.arr[i][j] = otherMatrix.arr[i][j];
          }
        }
      }
      childWeightMatrices[weightInd] = childMatrix;
    }
    child.wih = childWeightMatrices[0];
    child.whh = childWeightMatrices[1];
    child.who = childWeightMatrices[2];
    child.mutate(mutationRate);
    return child;
  }
  
  String toString(){
    String ans = "";
    ans += ("NeuralNet("+ins+", "+hiddens+", "+outs+"):");
    ans += "\n";
    ans += ("wih:");
    ans += "\n";
    ans += (wih);
    ans += "\n";
    ans += ("whh:");
    ans += "\n";
    ans += (whh);
    ans += "\n";
    ans += ("who:");
    ans += "\n";
    ans += (who);
    return ans;
  }
}


///////////////////////////////// tests ////////////////////
void testNNConstructor(){
  NeuralNet nn = new NeuralNet(2, 3, 2);
  println(nn);
  println("should be a 3x3, 3x4, then a 2x4 all from -1 to 1");
}

void testNNEvaluate(){
  float[] invec = {1, 1};
  Matrix input = columnFromArr(invec);
  NeuralNet nn = new NeuralNet(2, 3, 2);
  println(nn);
  println("in:");
  println(input);
  println("output:");
  println(nn.evaluate(input));
  println("no idea what it should be. Just a RunTimeError check.");
}

void testNNCrossover(){
  NeuralNet nn = new NeuralNet(2, 3, 2);
  println(nn);
  
  NeuralNet other = new NeuralNet(2, 3, 2);
  println(other);
  
  float old = mutationRate;
  mutationRate = 1;
  NeuralNet child = nn.crossover(other);
  mutationRate = old;
  println(child);
}

void runNNTests(){
  println("constructor:");
  testNNConstructor();
  println("\n\nevaluate:");
  testNNEvaluate();
  println("\n\ncrossover:");
  testNNCrossover();
  
}