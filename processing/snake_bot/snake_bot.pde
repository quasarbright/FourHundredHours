Population population;
//Brain brain;
void setup(){
  size(600,600);
  population = new Population();
  //brain = new Brain();
  frameRate(15);
  //runMatrixTests();
  //runNNTests();
}

void draw(){
  background(100);
  population.update();
  population.show();
  //brain.update();
  //brain.show();
 
}


void keyPressed(){
  //PVector direction;
  //switch(keyCode){
  //  case 87://w
  //    direction = new PVector(0, -1);break;
  //  case 65://a
  //    direction = new PVector(-1, 0);break;
  //  case 83://s
  //    direction = new PVector(0, 1);break;
  //  case 68://d
  //    direction = new PVector(1, 0);break;
  //  default:
  //    direction = new PVector(1, 0);
  //}
  //world.snake.direction = direction;
  population.new_generation();
}