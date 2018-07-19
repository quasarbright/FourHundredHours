class Matrix {
  float[][] arr;
  int rows, cols;
  Matrix(int numRows, int numCols) {//tested
    arr = new float[numRows][numCols];
    rows = numRows;
    cols = numCols;
  }

  Matrix(float[][] a){//tested
    arr = a;
    rows = a.length;
    cols = a[0].length;
  }

  void randomize() {//tested
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        arr[r][c] = random(-1, 1);
      }
    }
  }

  Matrix matMul(Matrix other){//tested
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

  Matrix getTranspose(){//tested
    Matrix ans = new Matrix(cols, rows);
    for(int i = 0; i< rows; i++){
      for(int j = 0; j< cols; j++){
        ans.arr[j][i] = arr[i][j];
      }
    }
    return ans;
  }

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

  Matrix addBias(){//tested
    Matrix ans = new Matrix(rows+1, 1);
    for(int i = 0; i < rows; i++){
      ans.arr[i][0] = arr[i][0];
    }
    ans.arr[rows][0] = 1;
    return ans;
  }

  Matrix clone(){
    Matrix ans = new Matrix(rows, cols);
    for(int i = 0; i < rows; i++){
      for(int j = 0; j < cols; j++){
        ans.arr[i][j] = arr[i][j];
      }
    }
    return ans;
  }
}

Matrix columnFromArr(float[] a){//tested
  float[][] aa = {a};
  Matrix ans = new Matrix(aa);
  return ans.getTranspose();
}

float sigmoid(float x){
  return 1 / (1 + pow((float)Math.E, -x));
}

/////////////////////// tests /////////////////////////////////

void testMatMul(){
  Matrix A, B;
  A = new Matrix(2, 3);
  B = new Matrix(3, 1);
  float[][] aarr = {{0.0, -0.16, -0.54}, {0.89, -0.84, -0.16}};
  A.arr = aarr;
  float[][] barr = {{-0.71}, {-0.35}, {0.28}};
  B.arr = barr;
  //A.randomize();
  //B.randomize();
  //println(A);
  //println(B);
  //println(A.matMul(B));
  float[][] carr = {{-0.1}, {-0.38}};
  Matrix correct = new Matrix(carr);
  Matrix ans = A.matMul(B);
  println("correct:");
  println(correct);
  println("answer:");
  println(ans);
}

void testGetTranspose(){
  float[][] aarr = {{1, 2, 3}};
  Matrix A = new Matrix(aarr);
  Matrix ans = A.getTranspose();
  float[][] carr = {{1},{2},{3}};
  Matrix correct = new Matrix(carr);
  println("correct:");
  println(correct);
  println("answer:");
  println(ans);
}

void testColumnFromArr(){
  float[] aarr = {1, 2, 3};
  Matrix ans = columnFromArr(aarr);
  float[][] carr = {{1},{2},{3}};
  Matrix correct = new Matrix(carr);
  println("correct:");
  println(correct);
  println("answer:");
  println(ans);
}

void testAddBias(){
  float[][] aarr = {{1}, {2}, {3}};
  Matrix A = new Matrix(aarr);
  Matrix ans = A.addBias();
  float[][] carr = {{1}, {2}, {3}, {1}};
  Matrix correct = new Matrix(carr);
  println("correct:");
  println(correct);
  println("answer:");
  println(ans);
}

void runMatrixTests(){
  println("matMul");
  testMatMul();
  println("getTranspose");
  testGetTranspose();
  println("columnFromArr");
  testColumnFromArr();
  println("addBias");
  testAddBias();
}