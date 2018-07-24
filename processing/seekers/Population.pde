int popsize = 100;
int targetSize = 15;
class Population{
  PVector target;
  Seeker[] seekers;
  Obstacle[] obstacles;
  Population(){
    target = new PVector(0, ymax-2);
    seekers = new Seeker[popsize];
    for(int i = 0; i < popsize; i++){
      seekers[i] = new Seeker(target);
    }
    obstacles = new Obstacle[1];
    obstacles[0] = new Obstacle(new PVector(-5,0),10,1);
    println(obstacles[0].checkHitbox(new PVector(0,0)));
  }
  
  void update(){
    if(allDone()){
      newGen();
    }
    for(Seeker s:seekers){
      for(Obstacle obs:obstacles){
        if(obs.checkHitbox(s.p)){
          s.dead = true;
        }
      }
      s.update();
    }
  }
  
  boolean allDone(){
    for(Seeker s:seekers){
      if(!s.dead){
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
    for(Obstacle obs:obstacles){
      obs.show();
    }
  }
  
  Seeker fitnessBasedSelection(){
    float fitnessSum = 0;
    for(Seeker s:seekers){
      fitnessSum += s.calcFitness();
    }
    float rand = random(fitnessSum);
    float runningSum = 0;
    for(Seeker s:seekers){
      runningSum += s.calcFitness();
      if(runningSum >= rand)
        return s;
    }
    return seekers[seekers.length - 1];
  }
  
  Seeker mostFit(){
    float bestFitness = -1;
    Seeker bestSeeker = seekers[0];
    for(Seeker s:seekers){
      if(s.calcFitness() > bestFitness){
        bestFitness = s.calcFitness();
        bestSeeker = s;
      }
    }
    return bestSeeker;
  }
  
  void newGen(){
    Seeker[] newSeekers = new Seeker[popsize];
    //pass on clone of best
    Seeker mostFit = new Seeker(target);
    mostFit.dna = mostFit().dna;
    newSeekers[0] = mostFit;
    for(int i = 1; i < popsize; i++){
      Seeker mom = fitnessBasedSelection();
      Seeker dad = fitnessBasedSelection();
      newSeekers[i] = mom.crossover(dad);
    }
    seekers = newSeekers;
  }
}
