/*
this file contains logic for the snake's movement
and death conditions, but does not check for fruit.
Fruit is handled in world and death cleanup is handled
in population
*/
int w = 20;
int h = 20;
int maxLifeSpan = 4*(w+h);
class Snake {
  PVector pos;
  ArrayList<PVector> history;
  int tailLength;
  PVector direction;
  boolean dead;
  int lifetime = 0;
  int remainingLife = maxLifeSpan;
  PVector fruitPos;
  color my_color;
  

  Snake() {
    pos = new PVector(floor(random(w)), floor(random(h)));
    //pos = new PVector((w/2), (h/2));
    history = new ArrayList<PVector>();
    history.add(pos.copy());
    tailLength = 1;
    direction = new PVector(1, 0);
    dead = false;
    fruitPos = new PVector(floor(random(w)), floor(random(h)));
    my_color = color(floor(random(255)), floor(random(255)), floor(random(255)), 127);
  }
  
  void setDirection(PVector v_){
    PVector v = v_.copy();
    PVector reverse = v.copy().mult(-1);
    if(!reverse.equals(direction)){
      direction = v;
    }
  }
  
  PVector getDirection(){
    return direction;
  }
  
  boolean updateFruit(){
    //returns whether the snake ate a fruit
    boolean ans = false;
    if(pos.equals(fruitPos)){
      tailLength++;
      ans = true;
      //make sure that fruit doesn't spawn in snake's tail
      boolean goodFruitPos;
      do {
        fruitPos = new PVector(floor(random(w)), floor(random(h)));
        goodFruitPos = true;
        for(int i = history.size() - tailLength; i < history.size(); i++){
          if(fruitPos.equals(history.get(i))){
            goodFruitPos = false;
            break;
          }
        }
      } while (!goodFruitPos);
    }
    return ans;
  }

  void update() {
    if(!dead){
      lifetime++;
      remainingLife--;
      PVector newpos = pos.copy();
      newpos.add(direction);
      //check bounds
      if (newpos.x >= w || newpos.x < 0 || newpos.y >= h || newpos.y < 0) {
        dead = true;
      } else {
        //check tail
        for (int i = 1; i <= tailLength; i++) {
          PVector pos_tmp = history.get(history.size()-i);
          if(pos_tmp.equals(newpos)){
            dead = true;
          }
        }
      }
      if(!dead){
        pos = newpos;
        history.add(pos.copy());
        if(updateFruit()){
          remainingLife = maxLifeSpan;
        } else {
          remainingLife--;
          if(remainingLife == 0 && tailLength < 7){
            dead = true;
          }
        }
      }
    }
  }
  
  void show(){
    fill(my_color);
    //show snake
    for (int i = 1; i <= tailLength; i++) {
      PVector pos_tmp = history.get(history.size()-i);
      rect(pos_tmp.x*width/w, pos_tmp.y*height/h, width/w, height/h);
    }
    //show fruit
    rect(fruitPos.x*width/w, fruitPos.y*height/h, width/w, height/h);
  }
}