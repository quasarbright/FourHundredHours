class Matrix {
  float[][] arr;
  int rows, cols;
  Matrix(int numRows, int numCols) {
    arr = new float[numRows][numCols];
    rows = numRows;
    cols = numCols;
  }

  void randomize() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        arr[r][c] = random(-1, 1);
      }
    }
  }

  Matrix matMul(Matrix other){
    Matrix ans = new Matrix(rows, other.cols);
    if(cols == other.rows){//check dimensions
      for(int thisrow = 0; thisrow < rows; thisrow++){
        for(int othercol = 0; othercol < other.cols; othercol++){
          //vecdot
          float sum = 0;
          for(int i = 0; i < cols; i++){
            sum += arr[thisrow][i] * other.arr[i][othercol];
          }
          ans.arr[thisrow][othercol] = sum;

        }
      }
    }
    return ans;
  }

  Matrix columnFromArr()

  String toString(){
    String ans = "";
    for(int i = 0; i < rows; i++){
      String line = "[ ";
      for(int j = 0; j < cols-1; j++){
        line += round(100*arr[i][j])/100.0 + ", ";
      }
      line += round(100*arr[i][cols-1])/100.0 + " ]";
      if(i < rows-1){
        line += "\n";
      }
      ans += line;
    }
    return ans;
  }

  Matrix addBias(){
    Matrix ans = new Matrix(rows+1, 1)
    for(int i = 0; i < rows; i++){
      ans.arr[i][0] = arr[i][0];
    }
    ans.arr[rows][0] = 1;
    return ans;
  }
}

float sigmoid(x){
  return 1 / (1 + pow((float)Math.E, -x));
}
