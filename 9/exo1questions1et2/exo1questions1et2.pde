// CCNAM - MUX101 - P. Cubaud
// fabrication d'un fichier sonore sans interaction

import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.ugens.*;

Minim minim;
AudioRecorder recorder;
AudioOutput output;
Oscil sine, sine2;
 
void setup(){
  minim = new Minim(this);
  output = minim.getLineOut(Minim.STEREO, 512);
  recorder = minim.createRecorder(output, "resultat.wav", false);
  // premier son sinusoidal
  sine = new Oscil(440, 0.5, Waves.SINE);
  // le relier vers la sortie audio
  sine.patch(output);

  // question 2 : on ajoute un deuxieme pour un meilleur son
  sine2 = new Oscil(880, 0.25, Waves.SINE);
  sine2.patch(output);

  // enregistrement du son produit pendant 2 secondes
  recorder.beginRecord();
  delay(2000);
  recorder.endRecord();
}