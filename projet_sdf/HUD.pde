import controlP5.*;

class HUD {
  private MainApp context;
  private ControlP5 cp5;

  private static final int FONT_SIZE = 16;

  private Textlabel scoreLabel;

  HUD(MainApp ctx) {
    this.context = ctx;

    PFont p = createFont("data/cmunssdc.ttf", FONT_SIZE);
    cp5 = new ControlP5(ctx, p);
    //    cp5.setAutoDraw(false);

    setupUI();
  }

  private void setupUI() {
    int hudY = 8; // padding top
    int hudH = 54;

    cp5.addButton("reset")
      .setLabel("RESET")
      .setPosition(8, hudY)
      .onClick(e -> {
      context.tableau.reset();
      context.lissage =0.05;
    }
    )
    .setSize(70, hudH-hudY);

    String[] sdfShapes = new String[SDFType.values().length];
    for (int i = 0; i < SDFType.values().length; i++) {
      sdfShapes[i] = SDFType.values()[i].name();
    }

    ScrollableList list = cp5.addScrollableList("selectedType")
      .setPosition(78 + hudY, hudY)
      .setSize(225, 205)
      .setLabel("Ajouter")
      .setBarHeight(hudH-8)
      .setOpen(false)
      .setItemHeight(hudH-16)
      .addItems(sdfShapes)
      .onChange(e -> {
      int index = (int) e.getController().getValue(); // index sélectionné
      SDFType selected = SDFType.values()[index];      // convertir en enum
      context.tableau.shapes.add(selected.createDefault(MainApp.instance));
    }
    );

    String[] sdfNames = new String[UnionType.values().length];
    for (int i = 0; i < UnionType.values().length; i++) {
      sdfNames[i] = UnionType.values()[i].name();
    }

    ScrollableList li = cp5.addScrollableList("selectSDF")
      .setPosition(width -188, hudY)
      .setSize(180, 205)
      .setOpen(false)
      .setLabel("Type d'union")
      .setBarHeight(hudH-8)
      .setItemHeight(hudH-16)
      .addItems(sdfNames)
      .onChange(e -> {
      int index = (int) e.getController().getValue(); // index sélectionné
      UnionType selected = UnionType.values()[index];      // convertir en enum
      println("SDF sélectionné : " + selected);
      context.tableau.unionType = selected;
    }
    );
    //    li.setValue(0);

    cp5.addTextlabel("info")
      .setText("""Click droit sur une forme pour la supprimer""")
      .setPosition(10, height - 30)
      .setColorValue(color(255));


    scoreLabel = cp5.addTextlabel("lissage")
      .setText("Lissage: " + context.lissage)
      .setPosition(8, hudH+16+8)
      .setColorValue(color(255));
  }

  // --- dessin du fond du HUD ---
  void draw() {
    context.noStroke();
    context.fill(40, 40, 100, 200);
    context.rect(0, 0, context.width, 64);
    scoreLabel.setText("Lissage: " + String.format("%.0f", context.lissage*100));
  }
}
