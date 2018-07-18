class World{
  Snake snake;
  PVector fruitPos;
  
  World(){
    snake = new Snake();
    fruitPos = new PVector(floor(random(w)), floor(random(h)));
  }
  
  void update(){
    //update first, then increase tail length so the extra bit of tail appears after next move
    snake.update();
    if(snake.pos.equals(fruitPos)){
      snake.tailLength++;
    }
  }
  
  void show(){
    snake.show();
    //show fruit too
  }
}