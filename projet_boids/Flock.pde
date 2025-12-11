// The Flock (a list of Boid objects)
  
class Flock {
  private static final int MAX_BOIDS = 50;
  private static final int MAX_CURRENCY = 50;
  private static final int RANGE_DETECTION_BOID = 35;
  private static final int RANGE_DETECTION_CURRENCY = 20;
  
  private final ArrayList<Boid> boids = new ArrayList<>(); // An ArrayList for all the boids
  private final ArrayList<Currency> currencys = new ArrayList<>();

  private Flocking context;

  Flock(Flocking context) {
    this.context = context;
  }

  void runBoid(boolean isPaused) {
    for (Boid b : boids) {
      b.run(boids, isPaused);  // Passing the entire list of boids to each boid individually
    }
  }

  void runCurrency(boolean isPaused, int x, int y) {
    for (Currency c : currencys) {
      c.run(isPaused);
    }
    this.removeCurrency(new PVector(x, y));
  }

  void addBoid(Boid b) {
    if (boids.size() < MAX_BOIDS)
      boids.add(b);
    else
      print("L'aquarium est plein de poisson");
  }

  void addCurrency(Currency c) {
    if (currencys.size() < MAX_CURRENCY)
      currencys.add(c);
    else
      print("L'aquarium est plein de $");
  }

  /**
   * Permet de del un boid proche des coord en param.
   * On del le premier boid retourné pour simplifier mais en vrai il faudrais faire le plus proche
   **/
  void tryRemoveBoid(int x, int y) {
    PVector mousePos = new PVector(x, y);
    Boid boidToDel = null;
    for (Boid b : boids) {
      if (mousePos.dist(b.position) < RANGE_DETECTION_BOID) {
        boidToDel = b;
      }
    }
    if (boidToDel != null) {
      println("Suppression d'un boid");
      boids.remove(boidToDel);
      ESoundEffect.GULP.sound.play();
    }
  }
  
  /**
  * Test de del la currency fonction de la pos.
  */
  void removeCurrency(PVector mousePos){
    Currency toDel = null;
    for(Currency item : currencys){
      if(item.timer < 0) toDel = item;
      if(mousePos.dist(item) < RANGE_DETECTION_CURRENCY){
        context.money += item.value; // EARN MONEY !
        ESoundEffect.CURRENCY.sound.play();
        toDel = item;
      }
    }
    if(toDel != null){
      println("Suppression d'un currency");
      currencys.remove(toDel);
    }
  }

  void moveTowards(int x, int y) {
    for (Boid b : boids) {
      b.moveTowards(new PVector(x, y));
    }
  }
}
