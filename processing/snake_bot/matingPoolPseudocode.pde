/*
Brain fitnessBasedSelection(){
  float fitnessSum = sum of fitnesses from all brains
  float rand = random(0, fitnessSum)
  float runningSum = 0
  for brain in brains
    runningSum += brain.fitness
    if(runningSum > rand)
      return brain
}
void nextGeneration(){
  Brain[] newBrains = Brain[populationSize]
  while newBrains isn't full
    Brain brain1 = fitnessBasedSelection()
    Brain brain2 = fitnessBasedSelection()
    Brain child = brain1.crossover(brain2)
    add child to newBrains
   replace brains with newBrains
}

*/