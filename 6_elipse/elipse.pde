float a = 200; // demi-grand axe
float b = 200; // demi-petit axe

void setup() {
  size(600, 600);
  noFill();
  stroke(0);
}

void draw() {
  background(255);
  translate(width / 2, height / 2);
  
  // n varie de 0.1 à 10 selon la position de la souris
  float n = map(mouseX, 0, width, 0.1, 10);
  
  beginShape();
  for (float t = -PI; t <= PI; t += 0.01) {
    float x = a * pow(abs(cos(t)), 2.0 / n) * sgn(cos(t));
    float y = b * pow(abs(sin(t)), 2.0 / n) * sgn(sin(t));
    vertex(x, y);
  }
  endShape(CLOSE);
  
  // affichage du paramètre n
  fill(0);
  textSize(16);
  text("n = " + nf(n, 1, 2), -width/2 + 10, height/2 - 10);
}

float sgn(float v) {
  if (v > 0) return 1;
  if (v < 0) return -1;
  return 0;
}
