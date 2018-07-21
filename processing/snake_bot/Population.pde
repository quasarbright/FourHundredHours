class Population {
  Brain[] brains;
  int popSize;
  Population() {
    popSize = 1000;
    brains = new Brain[popSize];
    for (int i = 0; i < popSize; i++) {
      brains[i] = new Brain();
    }
  }
  boolean update() {
    for (int i = 0; i < brains.length; i++) {
      brains[i].update();
    }
    allDead: {
      for (int i = 0; i < brains.length; i++) {
        if (! brains[i].dead) {
          break allDead;
        }
      }
      newGeneration();
      return true;
    }
    return false;
  }
  void show() {
    for (int i = 0; i < brains.length; i++) {
      if (! brains[i].dead)
        brains[i].show();
    }
  }
  Brain mostFit(){
    Brain mostFit = brains[0]; //<>//
    for (int i = 1; i < popSize; i++) {
      if (brains[i].calcFitness() > mostFit.calcFitness())
        mostFit = brains[i];
    }
    return mostFit;
  }
  Brain fitnessBasedSelection() {
    long fitnessSum = 0;
    for(Brain brain:brains){
      fitnessSum+=brain.calcFitness();
    }
    long rand = floor(random(0, fitnessSum));
    long runningSum = 0;
    for(Brain brain:brains){
      runningSum += brain.calcFitness();
      if(runningSum>rand){
        return brain;
      }
    }
    return brains[brains.length-1];
  }
  void newGeneration() {
    //// add best
    //// fill rest with mutated
    //Brain[] newBrains = new Brain[popSize];
    //newBrains[0] = mostFit();
    //for (int i = 1; i < popSize; i++) {
    //  newBrains[i] = newBrains[0].crossover(newBrains[0]);
    //}
    //brains = newBrains;
    newBrains = Brain[//left off here 7-20-18 about to reimplement crossover//////////////////////////////
  }
}