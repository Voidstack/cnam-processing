PImage img;
int N = 5; // prendre 1 pixel tous les N

void setup() {
  smooth();
  size(500, 500, P2D);
  img = loadImage("img.jpg"); // mettre le chemin de ton image
  img.loadPixels();
}

void draw() {
  background(0);

  for (int y = 0; y < img.height; y += N) {
    for (int x = 0; x < img.width; x += N) {
      color c = img.pixels[y * img.width + x];
      fill(c);
//      noStroke();
      rect(x, y, N, N); // dessine un carré de taille N pour "remplir" l'espace
    }
  }

//  noLoop(); // on ne redessine qu'une fois
}

// écoute l'événement de molette
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); // négatif = vers le haut, positif = vers le bas
  N -= e; // on inverse car vers le haut = -1
  N = constrain(N, 5, 50);
}
