int popsize = 100;
class Population{
  Seeker[] seekers;
  Population(){
    seekers = new Seeker[popsize];
    for(int i = 0; i < popsize; i++){
      seekers[i] = new Seeker();
    }
  }
  
  void update(){
    if(allDead()){
      newGen();
    }
    for(Seeker s:seekers){
      s.update();
    }
  }
  
  boolean allDead(){
    for(Seeker s:seekers){
      if(!s.dead){
        return false;
      }
    }
    return true;
  }
  
  void show(){
    for(Seeker s:seekers){
      s.show();
    }
  }
  
  void newGen(){
    seekers = new Seeker[popsize];
    for(int i = 0; i < popsize; i++){
      seekers[i] = new Seeker();
    }
  }
}
