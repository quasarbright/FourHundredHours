///*
Population population;
int skip = 0;
boolean doSkip = false;
void setup(){
  size(600,600);
  population = new Population();
  frameRate(60);
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
}


void keyPressed(){
  population.newGeneration();
}
//*/

/*
/////////////// for manual play ////////////
Snake snake;
void setup(){
  size(600,600);
  frameRate(15);
  snake = new Snake();
}

void draw(){
  background(100);
  snake.update();
  snake.show();
}

void keyPressed(){
  PVector direction;
  switch(keyCode){
    case 87://w
      direction = new PVector(0, -1);break;
    case 65://a
      direction = new PVector(-1, 0);break;
    case 83://s
      direction = new PVector(0, 1);break;
    case 68://d
      direction = new PVector(1, 0);break;
    default:
      direction = new PVector(1, 0);
  }
  snake.setDirection(direction);
}
*/
