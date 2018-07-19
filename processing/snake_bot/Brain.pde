//TODO after implementing brain, implement its use in snake///////////////////////
/*
This file contains the logic for handling
the connection of the world and neural network.
brains have worlds and neural networks.
*/
class Brain{
  World world;
  NeuralNetwork nn;
  boolean dead;
  Brain(){
    world = new World();
    nn = new NeuralNetwork(24, 16, 4);
    dead = false;
  }
  
  Brain(NeuralNetwork nn){
    world = new World();
    this.nn = nn;
    dead = false;
  }
  
  void update(){
    if(!dead){
      //scan world, feed & eval nn
      float x = world.snake.pos.x;
      float y = world.snake.pos.y;
      
      //find walls
      float distToRightWall = w - x;
      float distToLeftWall = x + 1;//because wall is x=-1
      float distToBottomWall = h - y;
      float distToTopWall = y+1;
      //diagonal find walls
      float rad2 = sqrt(2);
      float distToTopLeftWall = min((x+1)*rad2, (y+1)*rad2);
      float distToTopRightWall = min((w-x)*rad2, (y+1)*rad2);
      float distToBottomLeftWall =  min((x+1)*rad2, (h-y)*rad2);
      float distToBottomRightWall = min((w-x)*rad2, (h-y)*rad2);
      
      //find tail
      float r, ur, u, ul, l, dl, d, dr;
      r = w+h;
      ur = w+h;
      u = w+h;
      ul = w+h;
      l = w+h;
      dl = w+h;
      d = w+h;
      dr = w+h;
      for (int i = 2; i <= world.snake.tailLength; i++) {//loop through tail, skip head
        PVector tailPos = world.snake.history.get(world.snake.history.size()-i);
        PVector disp = PVector.sub(p, new PVector(x, y));
        if(disp.x == 0){//above or below
          if(tailPos.y>y){//below
            d = min(d, tailPos.y - y);
          } else {//won't be == because it'd be dead
            u = min(d, y - tailPos.y);
          }
        } else if(disp.y == 0){//to the left or right
          if(tailPos.x > x){//to the right
            r = min(r, tailPos.x-x);
          } else {
            l = min(l, x-tailPos.x);
          }
        } else if(disp.y == disp.x){//below and right or up and left
          float distance = abs(disp.x * rad2);
          if(disp.y>0){//below and right
            dr = min(dr, distance);
          } else {
            ul = min(ul, distance);
          }
        } else if(disp.y == -1*disp.x){//above and right or below and left
          float distance = abs(disp.x * rad2);
          if(disp.y>0){//below and left
            dl = min(dl, distance);
          } else {//above and right
            ur = min(ur, distance);
          }
        }
      }
      //check fruit
      float fr, fur, fu, ful, fl, fdl, fd, fdr;
      fr = w+h;
      fur = w+h;
      fu = w+h;
      ful = w+h;
      fl = w+h;
      fdl = w+h;
      fd = w+h;
      fdr = w+h;
      ////////////////////left off here 7-19-18
      ////////////////////still have to check fruit, eval nn, change direction, and update
      
      
      world.snake.update();
    }
    dead = world.snake.dead;
  }
  void show(){
    world.show();
  }
  
  Brain crossover(Brain other){
    NeuralNetwork childnn = nn.crossover(other.nn);
    return new Brain(childnn);
  }
  
  float calcFitness(){
    int len = world.snake.tailLength;
    return len*len;
  }
}

//check nearest wall, tail, etc


/*
boolean dead
NeuralNetwork nn
World world
void update()
  choose direction based on world and nn
  call world.update()
  update dead boolean
  check isDead to update
void show()
  call world.show()
Brain crossover(Brain other)
*/