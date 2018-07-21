/*
this file contains logic for the snake's movement
and death conditions, but does not check for fruit.
Fruit is handled in world and death cleanup is handled
in population
*/
int w = 20;
int h = 20;
class Snake {
  PVector pos;
  ArrayList<PVector> history;
  int tailLength;
  PVector direction;
  boolean dead;
  int lifetime = 0;

  Snake() {
    pos = new PVector(floor(w/2), floor(h/2));
    //pos = new PVector((w/2), (h/2));
    history = new ArrayList<PVector>();
    history.add(pos.copy());
    tailLength = 1;
    direction = new PVector(1, 0);
    dead = false;
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

  void update() {
    if(!dead){
      lifetime++;
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
      }
    }
  }
  
  void show(){
    for (int i = 1; i <= tailLength; i++) {
      PVector pos_tmp = history.get(history.size()-i);
      rect(pos_tmp.x*width/w, pos_tmp.y*height/h, width/w, height/h);
    }
  }
}