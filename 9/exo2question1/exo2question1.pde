// CNAM - MUX101 - P. Cubaud
// animation sans generation sonore

PVector pballe; // position de la balle
PVector vballe; // vitesse de la balle

void setup(){
  size(400,400);
  pballe = new PVector(random(0,width),random(0,height));
  vballe = new PVector(random(-10,+10),random(-10,+10));
}

void draw(){
  background(0);
  fill(250);
  ellipse(pballe.x,pballe.y,30,30);
  // test collision avec les bords de l'ecran
  if (pballe.x < 0) {
    pballe.x = 0;
    vballe.x *= -1;
  }
  if (pballe.x > width) {
    pballe.x = width;
    vballe.x *= -1;
  }  
  if (pballe.y < 0) {
    pballe.y = 0;
    vballe.y *= -1;
  }
  if (pballe.y > height) {
    pballe.y = height;
    vballe.y *= -1;
  }  
  pballe.x += vballe.x;
  pballe.y += vballe.y;
}

void keyPressed(){
  pballe = new PVector(random(0,width),random(0,height));
  vballe = new PVector(random(-10,+10),random(-10,+10));
}