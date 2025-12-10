class Currency extends PVector {

  private final PImage image;
  public int timer = 15000; // 15 secondes en millisecondes
  private int lastTime;
  float rotation;
  private Flocking main = Flocking.instance;

  private final float PADDING = 32; // marge en pixels
  
  private final int imgSize;

  Currency(float x, float y) {
    // Clamp x et y pour rester dans la zone safe
    float safeX = constrain(x, PADDING, main.width - PADDING);
    float safeY = constrain(y, PADDING, main.height - PADDING);

    this.set(safeX, safeY);

    this.image = EHUDImg.SUN.image;
    this.imgSize = 32;
    
    this.lastTime = millis();

    render();
  }

  void run(boolean isPaused) {
    if (isPaused) return;
    handlerTimer();
    render();
  }

  void handlerTimer() {
    // calcul du temps écoulé
    int currentTime = millis();
    int elapsed = currentTime - lastTime;
    lastTime = currentTime;

    // décrémente le timer
    timer -= elapsed;
  }

  // j'ai pas réussi la rotation :(
  void render() {
//    image(image, this.x - imgSize/2, this.y - imgSize/2, imgSize, imgSize);

  float pulse = sin(millis() * 0.005f) * 4;
  float size = imgSize + pulse;

  // glow
  noStroke();
  fill(255, 255, 0, 60);
  ellipse(this.x, this.y, size + 10, size + 10);

  // image
  image(image, this.x - size/2, this.y - size/2, size, size);
  noTint();
  }
}
