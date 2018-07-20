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
  
  float[] look(){
    /////////////////scan surroundings/////////////
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
        PVector disp = PVector.sub(tailPos, new PVector(x, y));
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
      PVector fruitPos = world.fruitPos;
      PVector disp = PVector.sub(fruitPos, new PVector(x, y));
      if(disp.x == 0){//above or below
        if(fruitPos.y>y){//below
          fd = min(fd, fruitPos.y - y);
        } else {//won't be == because it'd be dead
          fu = min(fd, y - fruitPos.y);
        }
      } else if(disp.y == 0){//to the left or right
        if(fruitPos.x > x){//to the right
          fr = min(fr, fruitPos.x-x);
        } else {
          fl = min(fl, x-fruitPos.x);
        }
      } else if(disp.y == disp.x){//below and right or up and left
        float distance = abs(disp.x * rad2);
        if(disp.y>0){//below and right
          fdr = min(fdr, distance);
        } else {
          ful = min(ful, distance);
        }
      } else if(disp.y == -1*disp.x){//above and right or below and left
        float distance = abs(disp.x * rad2);
        if(disp.y>0){//below and left
          fdl = min(fdl, distance);
        } else {//above and right
          fur = min(fur, distance);
        }
      }
      
      float[] in_arr = {
        distToRightWall,
        distToTopRightWall,
        distToTopWall,
        distToTopLeftWall,
        distToLeftWall,
        distToBottomLeftWall,
        distToBottomWall,
        distToBottomRightWall,
        r, ur, u, ul, l, dl, d, dr,
        fr, fur, fu, ful, fl, fdl, fd, fdr
      };
      return in_arr;
      ////////////////end of scan surroundings//////////////
  }
  
  void changeDirection(){
    float[] in_arr = look();
    //evaluate nn to find a direction
    Matrix ins = columnFromArr(in_arr);
    Matrix outs_mat = nn.evaluate(ins);
    //println(nn);//debug
    //println(outs_mat, "\n");//debug
    float[] outs = {
      outs_mat.arr[0][0],//r
      outs_mat.arr[1][0],//u
      outs_mat.arr[2][0],//l
      outs_mat.arr[3][0],//d
    };
    
    //find the best direction
    float best = -1;
    int bestInd = -1;
    for(int i = 0; i < outs.length; i++){
      if(outs[i] > best){
        bestInd = i;
        best = outs[i];
      }
    }
    //change direction
    PVector newDirection;
    switch(bestInd){
      case 0:newDirection = new PVector(1, 0);break;//r
      case 1:newDirection = new PVector(0, -1);break;//u
      case 2:newDirection = new PVector(-1, 0);break;//l
      case 3:newDirection = new PVector(0, 1);break;//d
      default:newDirection = new PVector(-1,-5);//shouldn't get here
    }
    world.snake.setDirection(newDirection);
  }
  
  
  
  void update(){
    if(!dead){
      changeDirection();
      world.update();
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
  
  long calcFitness(){
    int len = world.snake.tailLength;
    int lifetime = world.snake.lifetime;
    long fitness;
    //fitness is based on length and lifetime
    if (len < 10) {
      fitness = floor(lifetime *lifetime * pow(2, (floor(len))));
    } else {
      //grows slower after 10 to stop fitness from getting stupidly big
      //ensure greater than len = 9
      fitness =  lifetime * lifetime;
      fitness *= pow(2, 10);
      fitness *=(len-9);
    }
    return fitness;
  }
  
  void mutate(){
    nn.mutate(mutationRate);
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