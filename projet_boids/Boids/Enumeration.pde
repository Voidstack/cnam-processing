public enum EFishType {
  GUPPY("images/guppy.svg", "Betta", 2),
    NEON_ROUGE("images/neonrouge.svg", "Néon-rouge", 5),
    PLATY("images/platy.svg", "Platy", 11),
    MOLLY("images/molly.svg", "Molly", 17),
    GOURAMI_NAIN("images/gouraminain.svg", "Gourami-nain", 23),
    BETTA("images/betta.svg", "Betta", 31),
    POISSON_ANGE("images/poissonange.svg", "Poisson-ange", 41),
    DISCUS("images/discus_2.svg", "Discus", 50);

  final String path;
  final int price;
  final String name;
  PShape shape;

  EFishType(String path, String name, int price) {
    this.path = path;
    this.price = price;
    this.name = name;
  }

  void load(PApplet app) {
    shape = app.loadShape(path);
  }
}

public enum EControlerType {
  MOVE("cursor/wave.png"),
    FEED("cursor/food.png"),
    TRASH("cursor/catcher.png"),
    ADD("cursor/money.png");

  final String path;
  PImage image;

  EControlerType(String path) {
    this.path = path;
  }

  void load(PApplet app) {
    image = app.loadImage(path);
  }
}

// ici je n'utilise pas vraiment la logique lié aux enum
// mais j'apprépréce la simplicité d'utilisation des enum 
// dans le cas présent
public enum EHUDImg{
  BIN("data/hud/bin.png"),
  BG("data/hud/background.jpg"),
  SUN("data/hud/sun.png"),
  BIN_OVER("data/hud/bin_over.png");

  final String path;
  PImage image;

  EHUDImg(String path) {
    this.path = path;
  }

  void load(PApplet app) {
    image = app.loadImage(path);
  }
}
