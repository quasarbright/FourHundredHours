World world;
void setup(){
  size(600,600);
  world = new World();
}

void draw(){
  world.update();
  world.show();
}