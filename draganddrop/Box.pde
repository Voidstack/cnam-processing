class Box {
  float x, y, w, h;
  
  Box(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    stroke(0);
    fill(220);
    rect(x, y, w, h);
  }
  
  boolean contains(float px, float py) {
    return px > x && px < x + w && py > y && py < y + h;
  }
}
