static public Flocking instance; // singleton (oui, c'est pas bien)

public Flock flock;
public HUD hud;
public Controler controler;
public boolean pause;

public int money = 0;

void setup() {
  this.instance =this;
  smooth(8);
  size(640, 640, P2D);
  surface.setResizable(true);
    surface.setTitle("RIP Windows Vista");
//  surface.setLocation(100, 100);

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

  for (EHUDImg type : EHUDImg.values()) {
    type.load(this);
  }
}

private void initUI() {
  controler = new Controler(this);
  hud = new HUD(this);
}

private void initFlock() {
  flock = new Flock(this);
  // Add an initial set of boids into the system
  for (int i = 0; i < 10; i++) {
    flock.addBoid(new Boid(width/2, height/2));
  }

  Currency currency = new Currency(width/2, height/2);
  flock.addCurrency(currency);
}

void draw() {
  background(50);
  drawBg();

  flock.runBoid(pause);
  flock.runCurrency(pause, mouseX, mouseY);
  hud.draw();

  controler.draw(mouseX, mouseY);
}

private void drawBg() {
  PImage bg = EHUDImg.BG.image;
  float scale = max((float)width / bg.width, (float)height / bg.height);
  float w = bg.width * scale;
  float h = bg.height * scale;
  image(bg, (width - w)/2, (height - h)/2, w, h);
}

// Add a new boid into the System
void mousePressed() {
  if (height - mouseX < 48) return; // click sur le menu (à refaire)
  controler.click(mouseX, mouseY);
}

void mouseDragged(){
  if (height - mouseX < 48) return; // click sur le menu (à refaire)
  controler.drag(mouseX, mouseY);
}
