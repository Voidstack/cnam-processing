// https://iquilezles.org/articles/distfunctions2d/

public static MainApp instance;

public float lissage = 0.05;
private HUD hud;
private Tableau tableau;

void setup() {
  instance = this;
  size(600, 600, P2D);
  surface.setResizable(true);
  
  hud = new HUD(this);
  tableau = new Tableau(this);
}

void draw(){
  tableau.draw();
  hud.draw();
}

void mouseWheel(processing.event.MouseEvent e) {
  lissage += e.getCount() * 0.01;
  lissage = constrain(lissage, 0.01, 0.3);
}

SDFShape selectedShape = null;

void mousePressed() {
  // sélectionner la première forme sous la souris
  float mx = (mouseX - width/2f) / (float)height;
  float my = (mouseY - height/2f) / (float)height;

  for (SDFShape s : tableau.shapes) {
    if (s.compute(mx, my) < 0) { // clic dans la forme
      if (mouseButton == RIGHT) {
        tableau.shapes.remove(s); // supprime la shape
      } else {
        selectedShape = s; // clic gauche = sélectionner
      }
      break;
    }
  }
}

void mouseDragged() {
  if (selectedShape != null) {
    float dx = (mouseX - pmouseX) / (float)height;
    float dy = (mouseY - pmouseY) / (float)height;
    selectedShape.move(dx, dy);
  }
}

void mouseReleased() {
  selectedShape = null;
}
