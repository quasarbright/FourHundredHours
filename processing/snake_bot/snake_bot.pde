Population population;
//Brain brain;
//World world;

int skip = 1;
boolean doSkip = false;
void setup(){
  //noStroke();
  size(600,600);
  population = new Population();
  //brain = new Brain();
  //world = new World();
  frameRate(15);
  //runMatrixTests();
  //runNNTests();
}

void draw(){
  background(100);
  if(doSkip){
    for(int i = 0; i < skip; i++){
      while(!population.update()){}//update returns true upon new generation
    }
    doSkip = false;
  } else {
    if(population.update()){
      doSkip = true;
    }
    population.show();
  }
  
  //brain.update();brain.show();
  //world.update();world.show();
}


//void keyPressed(){
//  /*
//  PVector direction;
//  switch(keyCode){
//    case 87://w
//      direction = new PVector(0, -1);break;
//    case 65://a
//      direction = new PVector(-1, 0);break;
//    case 83://s
//      direction = new PVector(0, 1);break;
//    case 68://d
//      direction = new PVector(1, 0);break;
//    default:
//      direction = new PVector(1, 0);
//  }
//  world.snake.setDirection(direction);
//  */
//  population.newGeneration();
//}