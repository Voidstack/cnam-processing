import processing.sound.*;

public enum ESoundEffect{
  CURRENCY("data/sound/currency.mp3"),
  GULP("data/sound/gulp.mp3"),
  ALARM("data/sound/alarm.mp3"),
  WATER_DROP("data/sound/water_drop.mp3");
  
  private final String path;
  public SoundFile sound;

  ESoundEffect(String path) {
    this.path = path;
  }

  void load(PApplet app) {
    sound = new SoundFile(app, path);
  }
}

public enum EFishType {
  GUPPY("data/images/guppy.svg", "Betta", 2, 1, .3f),
    NEON_ROUGE("data/images/neonrouge.svg", "Néon-rouge", 5, 2, .3f),
    PLATY("data/images/platy.svg", "Platy", 11, 3, .3f),
    MOLLY("data/images/molly.svg", "Molly", 17, 4, .3f),
    GOURAMI_NAIN("data/images/gouraminain.svg", "Gourami-nain", 23, 5, .3f),
    BETTA("data/images/betta.svg", "Betta", 31, 6, .3f),
    POISSON_ANGE("data/images/poissonange.svg", "Poisson-ange", 41, 7, .3f),
    DISCUS("data/images/discus.svg", "Discus", 50, 8, .3f);

  private final String path;
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
    FEED("data/cursor/food.png"),
    TRASH("data/cursor/catcher.png"),
    ADD("data/cursor/money.png");

  private final String path;
  public PImage image;

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
  
  private final String path;
  PImage image;

  EHUDImg(String path) {
    this.path = path;
  }

  void load(PApplet app) {
    image = app.loadImage(path);
  }
}
