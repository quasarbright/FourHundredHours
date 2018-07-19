World world;
void setup(){
  size(600,600);
  world = new World();
  //runMatrixTests();
}

void draw(){
  world.update();
  world.show();
}