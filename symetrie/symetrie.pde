PVector last; // dernier point

void setup(){
  size(400, 400);
  smooth();

  // noStroke();
  stroke(50, 50, 50, 255);
  strokeWeight(4);           // épaisseur de la ligne
  
  background(100);
  println("Setup");
  
  last = new PVector(mouseX, mouseY);
}

void draw(){
  
}

int lastTime = 0;

void mouseDragged(){
    if (millis() - lastTime > 50) { // 100 ms entre deux updates

      drawLine();

      lastTime = millis();
    }
}

void drawLine() {
  // ligne continue de la dernière position vers la position actuelle
  line(last.x, last.y, mouseX, mouseY);
  // ligne miroir
  line(width - last.x, last.y, width - mouseX, mouseY);
  
  // mettre à jour le dernier point
  last.set(mouseX, mouseY);
}

void drawCircle(){
      fill(50, 50, 50, 127);
      circle(mouseX, mouseY, 20);
      circle(width-mouseX , mouseY, 20);  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    println("Clear");
    background(100);
  }
  last = new PVector(mouseX, mouseY);
}
