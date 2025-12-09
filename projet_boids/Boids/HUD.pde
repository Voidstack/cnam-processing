import controlP5.*;

class HUD {

  private Flocking context;
  private ControlP5 cp5;

  // Etat partagé (exposé pour le sketch)
  int selectedSpecies = 0;

  HUD(Flocking ctx) {
    this.context = ctx;
    cp5 = new ControlP5(ctx);
    setupUI();
  }

  private void setupUI() {
    int hudY = 8;
    int hudH = 48;

    cp5.addButton("addFish")
       .setLabel("+ Poisson")
       .setPosition(10, hudY)
       .setSize(100, hudH-8);

    cp5.addButton("removeFish")
       .setLabel("- Poisson")
       .setPosition(120, hudY)
       .setSize(100, hudH-8);

    cp5.addButton("feed")
       .setLabel("Nourrir")
       .setPosition(230, hudY)
       .setSize(90, hudH-8);

    cp5.addToggle("togglePause")
       .setLabel("Pause")
       .setPosition(330, hudY)
       .setSize(70, hudH-8)
       .setValue(context.pause)
       .onChange(e -> {
         println("togglePause.onChange");
         context.pause = e.getController().getValue() == 1;
       });
       ;

    DropdownList dd = cp5.addDropdownList("species")
                         .setPosition(410, hudY)
                         .setSize(140, hudH-8)
                         .setLabel("Espèce");
    dd.addItem("Guppy", 0);
    dd.addItem("Betta", 1);
    dd.addItem("PoissonClown", 2);
    dd.setValue(0);

    cp5.addTextlabel("fishCount")
       .setText("Poissons : 0")
       .setPosition(550, hudY + 10);
  }

  // --- dessin du fond du HUD ---
  void draw() {
    context.noStroke();
    context.fill(240, 240, 240, 80);
    context.rect(0, 0, context.width, 64);
    context.stroke(200, 200, 200, 60);
    context.line(0, 64, context.width, 64);
    
    setFishCount(context.flock.boids.size());
  }

  // --- mise à jour externe ---
  void setFishCount(int n) {
    cp5.get(Textlabel.class, "fishCount")
       .setText("Poissons : " + n);
  }

  // --- Callbacks ControlP5 ---
  public void addFish() {}
  public void removeFish() {}
  public void feed() {}

  public void species(float v) {
    selectedSpecies = (int)v;
  }

  int getSelectedSpecies() {
    return selectedSpecies;
  }
}
