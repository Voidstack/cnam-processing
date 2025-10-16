class DraggableIcon {
  float x, y;
  float w, h;
  boolean dragging = false;
  float offsetX, offsetY;
  PImage img;
  
  float size;
  
  DraggableIcon(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    this.img = img;
    this.w = img.width;
    this.h = img.height;
  }
  
  void update() {
    if (dragging) {
      x = mouseX + offsetX;
      y = mouseY + offsetY;
    }
  }
  
  void display() {
    // Changement d'état en fonction de la souris
    if (over()) {
      if (dragging) {
        tint(150); // noir quand clic dessus
      } else {
        tint(200); // gris quand souris dessus
      }
    } else {
      noTint(); // blanc / normal
    }
    image(img, x, y);
  }
  
  boolean over() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
  
  void mousePressed() {
    if (over()) {
      dragging = true;
      offsetX = x - mouseX;
      offsetY = y - mouseY;
    }
  }
  
  void mouseReleased() {
    dragging = false;
  }
}
