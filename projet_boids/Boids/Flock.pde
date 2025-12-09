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
  }

  void moveTowards(int x, int y) {
    for (Boid b : boids) {
      b.moveTowards(new PVector(x, y));
    }
  }
}
