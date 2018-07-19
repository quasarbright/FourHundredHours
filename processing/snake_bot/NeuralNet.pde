class NeuralNet{
  Matrix wih;//ins -> hidden layer 1
  Matrix whh;//hidden layer 1 -> hidden layer 2
  Matrix who;//hidden layer 2 -> outs
  int ins, hiddens, outs;
  NeuralNet(int ins, int hiddens, int outs){
    this.ins = ins;
    this.hiddens = hiddens;
    this.outs = outs;
    wih = new Matrix(hiddens, ins+1);//ins+1 because bias
    whh = new Matrix(hiddens, hiddens+1);//hiddens+1 because bias
    who = new Matrix(outs, hiddens+1);//hiddens+1 because of bias
    //randomize weights
    wih.randomize();
    whh.randomize();
    who.randomize();
  }//7-18-18 left off about to make more neuralnet methods like evaluate
  
  Matrix evaluate(Matrix input){
    //expects input to be formatted as a column vector
    Matrix h1 = wih.matMul(input);
    h1.activate();
    h1.addBias();
    
    Matrix h2 = whh.matMul(h1);
    h2.activate();
    h2.addBias();
    
    Matrix out = who.matMul(h2);
    return out;
  }
}