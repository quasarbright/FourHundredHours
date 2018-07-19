/*
this file contains the logic for snake handling
and fruit handling. Fruit check happens here
*/
class World{
  Snake snake;
  PVector fruitPos;
  color my_color;
  
  World(){
    my_color = color(floor(random(255)), floor(random(255)), floor(random(255)), 127);
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
    fill(my_color);
    snake.show();
    //show fruit too
    rect(fruitPos.x*width/w, fruitPos.y*height/h, width/w, height/h);
  }
}
