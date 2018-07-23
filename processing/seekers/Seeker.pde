float maxVel = .2;
class Seeker{
  PVector p, v, a, target;
  boolean dead, success;
  int age;
  DNA dna;
  Seeker(PVector target){
    p = new PVector(0, ymin+2);
    v = new PVector(0, 0);
    v.rotate(random(TWO_PI));
    a = new PVector(0,0);
    dead = false;
    age = 0;
    dna = new DNA();
    this.target = target;
    success = false;
  }
  
  void updateSuccess(){
    if(!dead){
      PVector pp = toPixel(p);
      PVector targetp = toPixel(target);
      if(pp.dist(targetp) < targetSize){
        //target has been reached
        success = true;
      }
    }
  }
  
  void update(){
    updateSuccess();
    if(age>=lifeSpan){
      dead = true;
    } else if(!dead && !success){
      applyForce(dna.forces[age]);
      v.limit(maxVel);
      p.add(v);
      v.add(a);
      a.mult(0);
      age++;
    }if(!checkBounds()){
      dead = true;
    }
  }
  
  void applyForce(PVector f){
    a.add(f);
  }
  
  boolean checkBounds(){
    //returns true if in bounds
    float x = p.x;
    float y = p.y;
    return (xmin <= x && x <= xmax && ymin <= y && y <= ymax);
  }
  
  Seeker crossover(Seeker other){
    Seeker child = new Seeker(target);
    child.dna = dna.crossover(other.dna);
    return child;
  }
  
  void show(){
    PVector pp = toPixel(p);
    pushMatrix();
    stroke(255);
    strokeWeight(10);
    point(pp.x, pp.y);
    popMatrix();
  }
}
