import controlP5.*;

class HUD {
  private ScrollableList fishTypeList;

  private Flocking context;
  private ControlP5 cp5;

  HUD(Flocking ctx) {
    this.context = ctx;

    PFont p = createFont("data/font/LuckiestGuy-Regular.ttf", 16);
    cp5 = new ControlP5(ctx, p);
    cp5.setAutoDraw(false); // Pourquoi ? parce que sinon l'ui est rendu devant mon cursor custom.

    setupUI();
  }

  private void setupUI() {
    int hudY = 8; // padding top
    int hudH = 54;

    final Button removeBtn = cp5.addButton("removeFish")
      .setImage(EHUDImg.BIN.image)
      .setLabel("- Poisson")
      .setPosition(8, hudY)
      .onClick(e -> {
      context.controler.setControler(EControlerType.TRASH);
    }
    ).setSize(EHUDImg.BIN.image.width, EHUDImg.BIN.image.height);

    // je gère le state en second temps pour pouvoir attaquer ma var dans la méthode.
    removeBtn.onEnter(e -> removeBtn.setImage(EHUDImg.BIN_OVER.image))
    .onLeave(e -> removeBtn.setImage(EHUDImg.BIN.image));

    cp5.addButton("addFish")
      .setLabel("+ Poisson")
      .setPosition( 60, hudY)
      .onClick(e-> {
      context.controler.setControler(EControlerType.ADD);
    }
    ).setSize(100, hudH-8);

    cp5.addButton("feed")
      .setLabel("Nourrir")
      .setPosition(230, hudY)
      .onClick(e-> {
      context.controler.setControler(EControlerType.FEED);
    }
    ).setSize(90, hudH-8);

    cp5.addToggle("togglePause")
      .setLabel("Pause")
      .align(ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER)
      .setPosition(330, hudY)
      .setSize(70, hudH-8)
      .setValue(context.pause)
      .onChange(e -> {
      println("togglePause.onChange");
      context.pause = e.getController().getValue() == 1;
    }
    );

    fishTypeList = cp5.addScrollableList("species")
      .setPosition(410, hudY)
      .setSize(140, (hudH-8)*7)
      .setBarHeight(hudH-8)
      .setItemHeight(hudH-8)
      //      .align(ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER)
      .onClick(e -> {
      context.controler.setControler(EControlerType.MOVE);
    }
    ).setLabel("Espèce");

    // Ici je triche un peu, j'utilise l'index de l'enum pour pouvoir retrouver le fishType selected plus tard.
    for (EFishType fishType : EFishType.values()) {
      // On pourrais faire mieux avec un string format
      String text = fishType.price + "$ " + fishType.name();
      fishTypeList.addItem(text, fishType.ordinal());
    }
    fishTypeList.setValue(0);

    cp5.addTextlabel("fishCount")
      .setText("Poissons : 0")
      .setPosition(550, hudY + 5);

    cp5.addTextlabel("moneyCount")
      .setText("Money : 0$")
      .setPosition(550, hudY+20);

    cp5.addTextlabel("")
      .setText("")
      .setPosition(550, hudY+20);
  }

  public EFishType getSelectedFishType() {
    int index = (int) fishTypeList.getValue(); // récupère l'index de l'item sélectionné
    return EFishType.values()[index];
  }

  // --- dessin du fond du HUD ---
  void draw() {
    context.noStroke();
    context.fill(240, 240, 240, 80);
    context.rect(0, 0, context.width, 64);
    context.stroke(200, 200, 200, 60);
    context.line(0, 64, context.width, 64);

    setFishCount(context.flock.boids.size());
    setMoney(context.money);

    cp5.draw();
  }

  // --- mise à jour externe ---
  void setFishCount(int n) {
    cp5.get(Textlabel.class, "fishCount")
      .setText("Poissons : " + n);
  }

  void setMoney(int money) {
    cp5.get(Textlabel.class, "moneyCount")
      .setText("Money : " + money + "$");
  }
}
