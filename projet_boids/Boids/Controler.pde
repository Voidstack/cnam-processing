// Pour séparer la logique du controler
class Controler {
  private Flocking context;
  public EControlerType currentControler;

  Controler(Flocking context) {
    this.context = context;
    this.context.noCursor();
    this.currentControler = EControlerType.MOVE;
  }

  /**
  * Affichage et offset sur l'image du cursor.
  **/
  void draw(int coordX, int coordY) {
    PImage img = currentControler.image;
    float ox = img.width  * 0.5;
    float oy = img.height * 0.5;
    context.image(img, coordX-ox, coordY-oy);
  }

  void click(int coordX, int coordY) {
    switch (currentControler) {
    case MOVE:
      context.flock.moveTowards(coordX, coordY);
      println("move");
      break;
    case FEED:
      context.flock.moveTowards(coordX, coordY);
      println("feed");
      break;
    case ADD:
      EFishType fish = context.hud.getSelectedFishType();
      context.flock.addBoid(new Boid(coordX, coordY, fish));
      println("add");
      break;
    case TRASH:
      context.flock.removeBoid(coordX, coordY);
      println("trash");
      break;
    default:
      println("ERR: le controler n'est pas géré.");
    }
  }

  void setControler(EControlerType controlerType) {
    this.currentControler = controlerType;
  }
}
