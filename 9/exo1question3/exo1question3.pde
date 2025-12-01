// CNAM - MUX101 - P. Cubaud
// generation de notes aleatoires

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

  // generation de 30 notes aleatoires
  recorder.beginRecord();
  for (int i=0;i<30;i++) {
    // calcul frequence pour la gamme temperee
    int loctave = int(random(3,6));
    int lanote = int(random(0,13));
    float lafreq = pow(2.0, 4.0 + loctave + lanote/12.0);
    // modification frequence de l'oscillateur
    sine.setFrequency(lafreq);
    sine2.setFrequency(lafreq*2.0);
    // duree pour chaque note
    delay(300);
  }
  recorder.endRecord();
  println("generation terminee");
}
 