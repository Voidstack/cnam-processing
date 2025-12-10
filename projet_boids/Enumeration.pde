public enum EFishType {
  GUPPY("images/guppy.svg", "Betta", 2, 1, .3f),
    NEON_ROUGE("images/neonrouge.svg", "Néon-rouge", 5, 2, .3f),
    PLATY("images/platy.svg", "Platy", 11, 3, .3f),
    MOLLY("images/molly.svg", "Molly", 17, 4, .3f),
    GOURAMI_NAIN("images/gouraminain.svg", "Gourami-nain", 23, 5, .3f),
    BETTA("images/betta.svg", "Betta", 31, 6, .3f),
    POISSON_ANGE("images/poissonange.svg", "Poisson-ange", 41, 7, .3f),
    DISCUS("images/discus.svg", "Discus", 50, 8, .3f);

  final String path;
  final int price;
  final int production;
  final float scale;
  final String name;
  PShape shape;

  EFishType(String path, String name, int price, int production, float scale) {
    this.path = path;
    this.price = price;
    this.name = name;
    this.scale = scale;
    this.production= production;
  }

  void load(PApplet app) {
    shape = app.loadShape(path);
  }
}

public enum EControlerType {
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
  BG("data/hud/background.jpg"),
  SUN("data/hud/sun.png");
  
  final String path;
  PImage image;

  EHUDImg(String path) {
    this.path = path;
  }

  void load(PApplet app) {
    image = app.loadImage(path);
  }
}
