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
      //make sure that fruit doesn't spawn in snake's tail
      boolean goodFruitPos;
      do {
        fruitPos = new PVector(floor(random(w)), floor(random(h)));
        goodFruitPos = true;
        for(int i = snake.history.size() - snake.tailLength; i < snake.history.size(); i++){
          if(fruitPos.equals(snake.history.get(i))){
            goodFruitPos = false;
            break;
          }
        }
      } while (!goodFruitPos);
    }
  }
  
  void show(){
    snake.show();
    //show fruit too
  }
}