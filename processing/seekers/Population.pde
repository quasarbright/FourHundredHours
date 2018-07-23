int popsize = 100;
int targetSize = 15;
class Population{
  PVector target;
  Seeker[] seekers;
  Population(){
    target = new PVector(0, ymax-10);
    seekers = new Seeker[popsize];
    for(int i = 0; i < popsize; i++){
      seekers[i] = new Seeker(target);
    }
  }
  
  void update(){
    if(allDone()){
      newGen();
    }
    for(Seeker s:seekers){
      s.update();
    }
  }
  
  boolean allDone(){
    for(Seeker s:seekers){
      if(!s.dead || s.success){
        return false;
      }
    }
    return true;
  }
  
  void show(){
    pushMatrix();
    PVector targetp = toPixel(target);
    fill(0,255,0);
    noStroke();
    ellipse(targetp.x, targetp.y, targetSize*2, targetSize*2);
    popMatrix();
    for(Seeker s:seekers){
      s.show();
    }
  }
  
  void newGen(){
    seekers = new Seeker[popsize];
    for(int i = 0; i < popsize; i++){
      //seekers[i] = new Seeker(target);
    }
  }
}
