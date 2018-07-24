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
      float distSq = distSqToTarget();
      if(distSq < targetSize*targetSize){
        //target has been reached
        success = true;
        dead = true;
      }
    }
  }
  
  float distSqToTarget(){
    // in pixels, not coords
    PVector pp = toPixel(p);
    PVector targetp = toPixel(target);
    return PVector.sub(pp,targetp).magSq();
  }

  float calcFitness(){
    // success always > dead
    // die of age always > die early (punish wall hit)
    if(success){
      //reached target
      return float(lifeSpan * lifeSpan) / age * float(height) / distSqToTarget();
      //guarenteed > lifeSpan
    } else {
      //dead
      if(age < lifeSpan){
        //died early
        return  age * float(height) / distSqToTarget();
        //guarenteed < lifeSpan
      } else {
        //died of age
        return lifeSpan * float(height) / distSqToTarget();
        //guarenteed < lifeSpan
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
    if(dead)stroke(255,0,0);
    strokeWeight(10);
    point(pp.x, pp.y);
    popMatrix();
  }
}
