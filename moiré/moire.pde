int spacing = 10;

void setup(){
  size(800,800, P2D);
  //smooth();
  println("Setup");
   
  redraw();
}

void redraw(){
  background(150);
  
  for(int i = 0; i <= width; i=i+spacing){
    line(i, 0, width-i, width);
    line(0, i, width, width-i);
  }
}

void draw(){}

// écoute l'événement de molette
void mouseWheel(MouseEvent event) {
  float e = event.getCount(); 
  spacing -= e;
  spacing = constrain(spacing, 1, 30);
  
  redraw();
}
