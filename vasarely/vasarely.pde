color[] grays = {color(255), color(191), color(127), color(63), color(0)};
int elements = 10;

void setup(){
  size(400,400);
  smooth();
  background(0);
  noStroke();
  println("Setup");
  
  drawImage();
}

void draw(){
    
}

void mouseReleased() {
   drawImage();
}

void drawImage(){
 background(0);
  int size = width>height?width/elements:height/elements;

  for(int x = 0; x<elements; x++){
    for(int y = 0; y<elements; y++){
     fill(grays[int(random(0, grays.length))]);
     rect(x*size, y*size,  size, size);
     fill(grays[int(random(0, grays.length))]);
     circle(x*size+size/2, y*size+size/2, size-5);
    }
  } 
}
