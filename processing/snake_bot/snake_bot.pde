World world;
void setup(){
  size(600,600);
  world = new World();
  frameRate(15);
  //runMatrixTests();
}

void draw(){
  background(100);
  world.update();
  world.show();
}