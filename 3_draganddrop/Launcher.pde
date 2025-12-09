PImage iconImg;
DraggableIcon icon;
Box target;
color backgroundColor = color(150, 50, 50);

void setup() {
  size(450, 250);
  iconImg = loadImage("icon.png");
  iconImg.resize(50, 50); // largeur 50px, hauteur 50px
  icon = new DraggableIcon(50, 50, iconImg);
  target = new Box(250, 50, 150, 150);
}

void draw() {
  background(backgroundColor);

  target.display();
  icon.update();
  icon.display();
}

void mousePressed() {
  icon.mousePressed();
}

void mouseReleased() {
  icon.mouseReleased();
}

void mouseDragged(){
  // Vérifie si l'icône est déposée dans la target
  if (target.contains(icon.x, icon.y)) {
    backgroundColor = color(50, 150, 50);
  }else{
    backgroundColor = color(150, 50, 50);
  }
}
