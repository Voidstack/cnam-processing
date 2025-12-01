// CNAM - MUX101 - P. Cubaud
// animation avec generation sonore

import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput output;
Oscil osc;
PVector pballe; // position de la balle
PVector vballe; // vitesse de la balle

void setup(){
  minim = new Minim(this);
  output = minim.getLineOut(Minim.STEREO, 512);
  // source sonore
  osc = new Oscil(440, 0.5, Waves.TRIANGLE);
  osc.patch(output);
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
  // calcul frequence pour la gamme temperee
  int loctave = int(map(pballe.y,0,height,2,7));
  int lanote = int(map(pballe.x,0,width,0,13));
  float lafreq = pow(2.0, 4.0 + loctave + lanote/12.0);
  // modification frequence de l'oscillateur
  osc.setFrequency(lafreq);
}

void keyPressed(){
  pballe = new PVector(random(0,width),random(0,height));
  vballe = new PVector(random(-10,+10),random(-10,+10));
} 