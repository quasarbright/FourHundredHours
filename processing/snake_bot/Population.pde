class Population {
  Brain[] brains;
  int popSize;
  Population() {
    popSize = 100;
    brains = new Brain[popSize];
    for (int i = 0; i < popSize; i++) {
      brains[i] = new Brain();
    }
  }
  void update() {
    for (int i = 0; i < brains.length; i++) {
      brains[i].update();
    }
    allDead: {
      for (int i = 0; i < brains.length; i++) {
        if (! brains[i].dead) {
          break allDead;
        }
      }
      new_generation();
    }
  }
  void show() {
    for (int i = 0; i < brains.length; i++) {
      if (! brains[i].dead)
        brains[i].show();
    }
  }
  Brain fitnessBasedSelection(){
    float fitnessSum = 0;
    for (int i = 0; i < brains.length; i++) {
      fitnessSum += brains[i].calcFitness();
    }
    float rand = random(0, fitnessSum);
    float runningSum = 0;
    for (int i = 0; i < brains.length; i++) {
      runningSum += brains[i].calcFitness();
      if(runningSum > rand) {
        return brains[i];
      }
    }
    return brains[brains.length-1];

  }
  void new_generation() {
    Brain[] newBrains = new Brain[popSize];
    for (int i = 0; i < popSize; i++) {
      Brain mom  = fitnessBasedSelection();
      Brain dad = fitnessBasedSelection();
      newBrains[i] = mom.crossover(dad);
    }
    brains = newBrains;
  }
}
