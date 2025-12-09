// Pour séparer la logique du controler
class Controler {

  private HashMap<EControlerType, PImage> imgCache;
  private String[] imgList = {
    "cursor/cursor.png",
    "cursor/hand.png",
    "cursor/hand.png"
  };

  private Flocking context;
  public EControlerType currentControler;
  private PImage img;

  Controler(Flocking context) {
    this.context = context;
    this.context.noCursor();
    this.currentControler = EControlerType.MOVE;
    imgCache = new HashMap<EControlerType, PImage>();
    loadImages();
    updateCursor();
  }

  private void loadImages() {
    imgCache.put(EControlerType.MOVE, context.loadImage(imgList[0]));
    imgCache.put(EControlerType.FEED, context.loadImage(imgList[1]));
    imgCache.put(EControlerType.ADD,  context.loadImage(imgList[2]));
  }

  void draw(int coordX, int coordY) {
    context.image(img, coordX, coordY);
  }

  void click(int coordX, int coordY) {
    switch (currentControler) {
      case MOVE:
        context.flock.moveTowards(coordX, coordY);
        break;

      case FEED:
        //context.flock.feedAt(coordX, coordY);
        break;

      case ADD:
        //context.flock.addFish(coordX, coordY);
        break;
    }
  }

  void setControler(EControlerType controlerType) {
    this.currentControler = controlerType;
    updateCursor();
  }

  private void updateCursor() {
    img = imgCache.get(currentControler);
  }
}

enum EControlerType {
  MOVE, FEED, ADD
}
