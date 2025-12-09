Flock flock;
HUD hud;
Controler controler;

boolean pause;

static HashMap<String, PShape> svgCacheFlocking = null;
static String[] svgListFlocking = new String[]{};

void setup() {
  smooth(8);
  size(640, 640, P2D);
  surface.setResizable(true);
  surface.setLocation(100, 100); // x, y à l'écran
  
  initShapeList();
  initFlock();
  initUI();
  
  
  println("setup done");
}

void initUI(){
  controler = new Controler(this);
  hud = new HUD(this);
}

void initFlock(){
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 50; i++) {
    flock.addBoid(new Boid(width/2, height/2));
  }
}

void initShapeList(){
  // Création de la list de Shape.
  if (svgCacheFlocking == null) {
    svgCacheFlocking = new HashMap<String, PShape>();
    for (String name : svgListFlocking) {
      svgCacheFlocking.put(name, loadShape(name));
    }
  }
}

void draw() {
  background(50);
  flock.run(pause);
  hud.draw();
  controler.draw(mouseX, mouseY);
}

// Add a new boid into the System
void mousePressed() {
//  flock.addBoid(new Boid(mouseX, mouseY));
  controler.click(mouseX, mouseY);
}
