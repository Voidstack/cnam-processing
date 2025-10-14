/**
 * Flocking
 * by Daniel Shiffman.
 *
 * An implementation of Craig Reynold's Boids program to simulate
 * the flocking behavior of birds. Each boid steers itself based on
 * rules of avoidance, alignment, and coherence.
 *
 * Click the mouse to add a new boid.
 */

Flock flock;

static HashMap<String, PShape> svgCacheFlocking = null;  // OK
static String[] svgListFlocking = new String[]{"arte.svg",
  "target.svg"};

void setup() {
  surface.setResizable(true); // autorise le redimensionnement

  // Création de la list de Shape.
  if (svgCacheFlocking == null) {
    svgCacheFlocking = new HashMap<String, PShape>();
    for (String name : svgListFlocking) {
      svgCacheFlocking.put(name, loadShape(name));
    }
  }
  svgCacheFlocking.get("arte.svg").setFill(color(250, 77, 35));

  smooth(8);
  size(640, 640, P2D);
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2, height/2));
  }
}

void draw() {
  background(50);

  flock.run();

  createArte();
//  createTarget();
}

void createArte() {
  // L'app6 dans son état naturel
  pushMatrix();
  translate(width-65, 25);
  // Charger et afficher le SVG aléatoire
  scale(.5);
  shape(svgCacheFlocking.get("arte.svg"), 0, 0);
  popMatrix();
}

void createTarget(){
  pushMatrix();
  translate(mouseX, mouseY);
  scale(.5);
  shape(svgCacheFlocking.get("target.svg"), 0, 0);
  popMatrix();
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX, mouseY));
  flock.moveTowards(mouseX, mouseY);
}
