// The Flock (a list of Boid objects)
public static int MAX_BOIDS = 50;

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run(boolean isPaused) {
    for (Boid b : boids) {
      b.run(boids, isPaused);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    if (boids.size() < MAX_BOIDS)
      boids.add(b);
    else
       print("L'aquarium est plein");
  }
  
  /**
  * Permet de del un boid proche des coord en param.
  * On del le premier boid retourné pour simplifier mais en vrai il faudrais faire le plus proche
  **/
  void removeBoid(int x, int y){
    PVector mousePos = new PVector(x, y);
    Boid boidToDel = null;
    for(Boid b : boids){
       if(mousePos.dist(b.position) < 35) {
          boidToDel = b;
       }
    }
    if(boidToDel != null){
      println("Suppression d'un boid");
      boids.remove(boidToDel);
    }
  }

  void moveTowards(int x, int y) {
    for (Boid b : boids) {
      b.moveTowards(new PVector(x, y));
    }
  }
}
