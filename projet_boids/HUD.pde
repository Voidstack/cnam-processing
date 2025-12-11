import controlP5.*;

class HUD {
  private ScrollableList fishTypeList;

  private MainApp context;
  private ControlP5 cp5;

  private static final int FONT_SIZE = 16;

  HUD(MainApp ctx) {
    this.context = ctx;

    PFont p = createFont("data/font/LuckiestGuy-Regular.ttf", FONT_SIZE);
    cp5 = new ControlP5(ctx, p);
    cp5.setAutoDraw(false); // Pourquoi ? parce que sinon controlp5 est rendu devant mon cursor custom.

    setupUI();
  }

  private void setupUI() {
    int hudY = 8; // padding top
    int hudH = 54;

    cp5.addTextlabel("fishCount")
      .setText("Poissons : 0")
      .setPosition(hudY, hudY);

    cp5.addTextlabel("moneyCount")
      .setText("Money : 0$")
      .setPosition(hudY, hudY+FONT_SIZE);

    cp5.addTextlabel("idkCount")
      .setText("idk")
      .setPosition(hudY, hudY+FONT_SIZE+FONT_SIZE);

    final Button removeBtn = cp5.addButton("removeFish")
      // .setImage(EHUDImg.BIN.image)
      .setLabel("TRASH")
      .setPosition(125, hudY)
      .onDrag(e -> context.controler.setControler(EControlerType.TRASH))
      .onClick(e -> context.controler.setControler(EControlerType.TRASH)
      ).setSize(70, hudH-hudY);
    // j'ajoute aussi le drag parce que c'est plaisant pour l'utilisateur si il drag par erreur ca fonctionne quand même.

    // je gère le state en second temps pour pouvoir attaquer ma var dans la méthode.
    //  removeBtn.onEnter(e -> removeBtn.setImage(EHUDImg.BIN_OVER.image))
    //  .onLeave(e -> removeBtn.setImage(EHUDImg.BIN.image));

    cp5.addButton("feed")
      .setLabel("Move")
      .setPosition(205, hudY)
      .onDrag(e-> context.controler.setControler(EControlerType.FEED))
      .onClick(e-> context.controler.setControler(EControlerType.FEED))
      .setSize(75, hudH-8);

    cp5.addButton("addFish")
      .setLabel("Buy")
      .setPosition( 290, hudY)
      .onDrag(e-> context.controler.setControler(EControlerType.ADD))
      .onClick(e-> context.controler.setControler(EControlerType.ADD))
      .setSize(75, hudH-8);

    fishTypeList = cp5.addScrollableList("species")
      .setPosition(375, hudY)
      .setSize(150, (hudH-8)*7)
      .setBarHeight(hudH-8)
      .setItemHeight(hudH-16)
      .onChange(e -> context.controler.setControler(EControlerType.ADD))
      .setLabel("Espèce");

    // Ici je triche un peu, j'utilise l'index de l'enum pour pouvoir retrouver le fishType selected plus tard.
    for (EFishType fishType : EFishType.values()) {
      // On pourrais faire mieux avec un string format
      String text = fishType.price + "$ " + fishType.name();
      fishTypeList.addItem(text, fishType.ordinal());
    }
    fishTypeList.setValue(0);

    final Toggle togglePause = cp5.addToggle("togglePause")
      .setLabel("PAUSE")
      .align(ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER, ControlP5.CENTER)
      .setPosition(width-65-hudY, hudY)
      .setSize(65, hudH-8)
      .setValue(context.pause);

    togglePause.onChange(e -> {
      println("togglePause.onChange");
      context.pause = e.getController().getValue() == 1;
      togglePause.setLabel(e.getController().getValue()==1? "PLAY":"PAUSE");
    }
    );
  }

  public EFishType getSelectedFishType() {
    int index = (int) fishTypeList.getValue(); // récupère l'index de l'item sélectionné
    return EFishType.values()[index];
  }

  // --- dessin du fond du HUD ---
  void draw() {
    context.noStroke();
    context.fill(40, 40, 100, 200);
    context.rect(0, 0, context.width, 64);
    //    context.stroke(200, 200, 200, 60);
    //    context.line(0, 64, context.width, 64);

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
