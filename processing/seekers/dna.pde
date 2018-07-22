int lifeSpan = 200;
float fmag = 0.1;
float mutationRate = 0.05;
class DNA{
  PVector[] forces;
  DNA(){
    forces = new PVector[lifeSpan];
    for(int i = 0; i < lifeSpan; i++){
      forces[i] = newForce();
    }
  }
  
  PVector newForce(){
    PVector f = new PVector(fmag, 0);
    f.rotate(random(TWO_PI));
    return f;
  }
  
  void mutate(){
    for(int i = 0; i < lifeSpan; i++){
      if(random(1) < mutationRate){
        forces[i] = newForce();
      }
    }
  }
  
  DNA crossover(DNA other){
    DNA child = new DNA();
    for(int i = 0; i < lifeSpan; i++){
      if(random(1)<.5){
        child.forces[i] = forces[i];
      } else {
        child.forces[i] = other.forces[i];
      }
    }
    return child;
  }
}
