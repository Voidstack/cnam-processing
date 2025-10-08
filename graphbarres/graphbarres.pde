int elements = 15;

void setup(){
  size(400,200);
  smooth();
  background(120);
  
  stroke(0);
  strokeWeight(2);
  
  println("Setup");
  
  createGraph();
}

void draw(){
    
}

void mouseReleased(){
  createGraph();
}

void createGraph(){
  background(120);
  
  int largeur = width/elements;
  
  for(int i = 0; i < elements; i++){
   rect(largeur*i, height, largeur, -int(random(0, height)));
  }
}
