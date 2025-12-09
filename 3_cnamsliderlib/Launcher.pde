import controlP5.*;

ControlP5 cp5;
float sldValue1, sldValue2, sldValue3 = 50;

void setup() {
  smooth(8);
  size(350, 200, P2D);
  cp5 = new ControlP5(this);
  initSlider();
  background(sldValue1, sldValue2, sldValue3);
  println("setup done");
}

private void initSlider() {
  cp5.addSlider("sldValue1")          // le nom de la variable liée
    .setPosition(50, 50)          // position x, y
    .setSize(150, 20)             // largeur, hauteur
    .setRange(0, 255)             // valeur min et max
    .setValue(sldValue1);             // valeur initiale

  cp5.addSlider("sldValue2")          // le nom de la variable liée
    .setPosition(50, 100)          // position x, y
    .setSize(150, 20)             // largeur, hauteur
    .setRange(0, 255)             // valeur min et max
    .setValue(sldValue2);             // valeur initiale

  cp5.addSlider("sldValue3")          // le nom de la variable liée
    .setPosition(50, 150)          // position x, y
    .setSize(150, 20)             // largeur, hauteur
    .setRange(0, 255)             // valeur min et max
    .setValue(sldValue3);             // valeur initiale
}

void draw() {
  // écrire dans le draw c'est pour les zgeg.
}

void mouseDragged() {
  background(sldValue1, sldValue2, sldValue3);
}
