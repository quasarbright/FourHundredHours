int w = 20;
int h = 20;
class Snake {
  PVector pos;
  ArrayList<PVector> history;
  int tailLength;
  PVector direction;
  boolean dead;

  Snake() {
    pos = new PVector(floor(random(w)), floor(random(h)));
    history = new ArrayList<PVector>();
    tailLength = 1;
    direction = new PVector(1, 0);
    dead = false;
  }

  void update() {
    PVector newpos = pos.copy();
    newpos.add(direction);
    if (!(newpos.x >= w || newpos.x < 0 || newpos.y >= h || newpos.y < 0)) {
      pos = newpos;
      history.add(pos.copy());
    } else {
      dead = true;
    } //left off about to check tail hit but you should try to draw for now
    
    if (pos == fruit.pos) {
      tailLength += 1;
    }
  }
  
  void show(){
    //
  }
}
