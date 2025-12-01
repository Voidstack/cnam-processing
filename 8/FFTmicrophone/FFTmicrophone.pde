// CNAM - MUX101 - P. Cubaud
// analyse spectrale minimale
// version utilisant le microphone comme source

import ddf.minim.*;
import ddf.minim.analysis.*;

int bufferSize;
int h,rectwid;

Minim minim;
FFT myFFT;
AudioInput myInput;

void setup () {
  size(700,200);
  minim = new Minim(this);  
  myInput = minim.getLineIn(Minim.MONO, 1024, 44100);
  myFFT=new FFT(myInput.bufferSize(), myInput.sampleRate() );
}

void draw() {
  background(255,255,255);
  stroke(0,0,255);
  myFFT.forward(myInput.mix);
  // dessin du spectre, on agrandit par 4 pour voir les barres
  for (int i=0; i<myFFT.specSize(); i++) {
    h = int(myFFT.getBand(i)*4);
    line(i,height,i,height-h);
  }
  
  // trace les frequences tous les 1000Hz
  stroke(255,0,0);
  for (int i=1; i<=22; i++) {
    line(i*width/22,0,i*width/22,height);
  }
}

void mousePressed() {
 // pour effacer a la demande
 background(255,255,255);
}

void stop() {
 // pour faire plaisir a minim
  myInput.close();
  minim.stop();
  super.stop();
}