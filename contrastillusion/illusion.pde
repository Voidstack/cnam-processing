void setup(){
  size(800, 300, P2D);
  smooth();

  noStroke();
  // stroke(50, 50, 50, 255);
  // strokeWeight(4);           // épaisseur de la ligne
  
  background(100);
  println("Setup");
}
  
void draw(){
  int largeurBande = width/40;
  for(int i = 0; i < 40; i++){
    fill(i*255/(40-1));
    rect(largeurBande*i, 0, largeurBande, height);
  }
  
  fill(180);
  
  rect(160, 100, 30, 100);
  rect(160*2, 100, 30, 100);
  rect(160*3, 100, 30, 100);
  rect(160*4, 100, 30, 100);
  
  noLoop();
}
