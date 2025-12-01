float Bx, By;     // position
float Vx, Vy;     // vitesse

void setup() {
  
   size(600, 400, P2D);       // rendu GPU
  smooth(8);                 // antialiasing (8 = max utile)
  Bx = width/2;
  By = height/2;
  Vx = random(-5, 5);
  Vy = random(-5, 5);
}

void draw() {
  background(0);

  // mise à jour position
  Bx += Vx;
  By += Vy;

  // collisions verticales
  if (Bx < 0 || Bx > width) {
    Vx = -Vx;
  }

  // collisions horizontales
  if (By < 0 || By > height) {
    Vy = -Vy;
  }

  // dessin
  ellipse(Bx, By, 20, 20);
}
