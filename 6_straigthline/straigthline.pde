int cx, cy;  // centre de l'écran

void setup() {
  size(600, 600);
  cx = width / 2;
  cy = height / 2;
  noStroke();
}

void draw() {
  background(255);
  
  // Variation de la taille selon mouseX (entre 100 et 1)
  int RESW = int(map(mouseX, 0, width, 100, 1));
  
  fill(0);
  
  // Extrémités du segment : centre → souris
  int x1 = cx;
  int y1 = cy;
  int x2 = mouseX;
  int y2 = mouseY;
  
  // Tracé avec l’algorithme de Bresenham
  bresenham(x1, y1, x2, y2, RESW);
  
  // Affichage du RESW courant
  fill(0);
  textSize(16);
  text("RESW = " + RESW, 10, height - 10);
}

void bresenham(int x0, int y0, int x1, int y1, int RESW) {
  int dx = abs(x1 - x0);
  int dy = abs(y1 - y0);
  int sx = x0 < x1 ? 1 : -1;
  int sy = y0 < y1 ? 1 : -1;
  int err = dx - dy;
  
  while (true) {
    rect(x0 - RESW/2, y0 - RESW/2, RESW, RESW);
    
    if (x0 == x1 && y0 == y1) break;
    int e2 = 2 * err;
    if (e2 > -dy) { err -= dy; x0 += sx; }
    if (e2 <  dx) { err += dx; y0 += sy; }
  }
}
