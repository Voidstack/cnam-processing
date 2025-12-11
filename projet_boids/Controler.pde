// Pour séparer la logique du controler
class Controler {
  private MainApp context;
  public EControlerType currentControler;

  private final int CURSOR_SIZE = 64;

  Controler(MainApp context) {
    this.context = context;
    //    this.context.noCursor();
    this.currentControler = EControlerType.FEED;
  }

  /**
   * Affichage et offset sur l'image du cursor.
   **/
  void draw(int coordX, int coordY) {
    PImage img = currentControler.image;
    context.image(img, coordX, coordY, CURSOR_SIZE, CURSOR_SIZE);

    if (currentControler==EControlerType.ADD) {
      int price = context.hud.getSelectedFishType().price;

      // shadow simpliste
      context.textSize(24);
      context.fill(0);
      context.text("-"+price+"$", coordX + CURSOR_SIZE - 25 +3, coordY + CURSOR_SIZE / 2 -25 +3);

      context.textSize(24);
      
      if(context.money>= price) context.fill(255);
      else context.fill(255, 0, 0);

      context.text("-"+price+"$", coordX + CURSOR_SIZE - 25, coordY + CURSOR_SIZE / 2 -25);

      // Exemple : PShape à côté
      PShape s = context.hud.getSelectedFishType().shape;
      context.pushMatrix();
      context.translate(coordX + CURSOR_SIZE + 10, coordY+15);
      context.rotate(radians(40));
      context.scale(.3f);
      context.shape(s);
      context.popMatrix();
    }
  }

  void click(int coordX, int coordY) {
    switch (currentControler) {
    case FEED:
      context.flock.moveTowards(coordX, coordY);
      ESoundEffect.ALARM.sound.play();
      println("feed");
      break;
    case ADD:
      EFishType fish = context.hud.getSelectedFishType();
      if (context.money < fish.price) return;
      context.money -= fish.price;
      context.flock.addBoid(new Fish(coordX, coordY, fish));
      ESoundEffect.WATER_DROP.sound.play();
      println("add");
      break;
    case TRASH:
      context.flock.tryRemoveBoid(coordX, coordY);
      println("trash");
      break;
    default:
      println("WARN: le controler n'est pas géré dans le click.");
    }
  }

  void drag(int coordX, int coordY) {
    switch (currentControler) {
    case TRASH:
      context.flock.tryRemoveBoid(coordX, coordY);
      println("trash");
      break;
    default:
      println("WARN: le controler n'est pas géré dans le drag.");
    }
  }

  void setControler(EControlerType controlerType) {
    this.currentControler = controlerType;
  }
}
