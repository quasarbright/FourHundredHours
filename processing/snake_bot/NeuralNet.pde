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
}