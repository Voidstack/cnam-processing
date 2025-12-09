public Flock flock;
public HUD hud;
public Controler controler;
public boolean pause;

void setup() {
  smooth(8);
  size(640, 640, P2D);
  surface.setResizable(true);
  //surface.setLocation(100, 100);

  initEnum();
  initFlock();
  initUI();


  println("setup done");
}

private void initEnum() {
  for (EControlerType type : EControlerType.values()) {
    type.load(this);
  }

  for (EFishType type : EFishType.values()) {
    type.load(this);
  }
}

void initUI() {
  controler = new Controler(this);
  hud = new HUD(this);
}

void initFlock() {
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 10; i++) {
    flock.addBoid(new Boid(width/2, height/2));
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
