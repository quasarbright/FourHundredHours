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
      newGeneration();
    }
  }
  void show() {
    for (int i = 0; i < brains.length; i++) {
      if (! brains[i].dead)
        brains[i].show();
    }
  }
  Brain fitnessBasedSelection() {
    Brain mostFit = brains[0];
    for (int i = 1; i < popSize; i++) {
      if (brains[i].calcFitness() > mostFit.calcFitness())
        mostFit = brains[i];
    }
    return mostFit;
  }
  void newGeneration() {
    // add best
    // fill rest with mutated
    Brain[] newBrains = new Brain[popSize];
    newBrains[0] = fitnessBasedSelection();
    for (int i = 1; i < popSize; i++) {
      brains[i] = newBrains[0].mutate();
    }
    brains = newBrains;
  }
}
