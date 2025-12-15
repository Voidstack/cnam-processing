// Singleton, c'est pas bien mais le context étant unique, c'est pas trop grave.
// et puis c'est bien pratique
static public MainApp instance;

public Aquarium flock;
public HUD hud;
public Controler controler;
public boolean pause;

public int money = 50; // default

void setup() {
  MainApp.instance =this;
  smooth(8);
  size(640, 640, P2D);
  surface.setResizable(true);
  surface.setTitle("les ti poissons");
  surface.setLocation(100, 100);

  initEnum();
  initFlock();
  initUI();

  println("setup done");
}

/** Permet de charger les différents Asset, ils sont alors accessible partout depuis une simple Enum. **/
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
  
  for(ESoundEffect sf : ESoundEffect.values()){
    sf.load(this);
  }
}

private void initUI() {
  controler = new Controler(this);
  hud = new HUD(this);
}

private void initFlock() {
  flock = new Aquarium(this);
  // Add an initial set of boids into the system
  for (int i = 0; i < 10; i++) {
    flock.addBoid(new Fish(width/2, height/2));
  }

  Currency currency = new Currency(width/2, height/2);
  flock.addCurrency(currency);
}

void draw() {
  background(10, 125, 245);
//  drawBg();

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
  if(hud.cp5.isMouseOver()) return;
  controler.click(mouseX, mouseY);
}

void mouseDragged() {
  if(hud.cp5.isMouseOver()) return;
  controler.drag(mouseX, mouseY);
}
