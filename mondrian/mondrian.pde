void setup(){
  size(400,400);
  smooth();
  background(120);
  println("Setup");
  
    mmondrian(0, 0, width, height);
}

void draw(){
  
}

void keyPressed() {
  if (int(key) == 19 && keyCode == 83) { // Ctrl+S
    save("mon_image.png");
  }
}

void mouseReleased() {
  subdivision=0;
  mmondrian(0, 0, width, height);
  println("Subdivison :"+ subdivision);
}

color[] colors = {#FF0000, #FFFF00, #0000FF, #FFFFFF, #FFFFFF}; // Palette style Mondrian
int subdivision = 0;

void mmondrian(float x, float y, float w, float h) {
  subdivision++;
  
  // Condition d'arrêt pour éviter trop de subdivisions
  if (w < 60 || h < 60) {
    fill(colors[int(random(colors.length))]);
    stroke(0);
    strokeWeight(6); // style Mondrian épais
    rect(x, y, w, h);
    return;
  }
  
  int splits = int(random(1, 4)); // Nombre de divisions (1 à 3)
  
  // Décider si on divise horizontalement ou verticalement
  boolean horizontal = random(1) > 0.5;
  
  float[] points = new float[splits+1];
  points[0] = 0;
  points[splits] = horizontal ? h : w;
  
  // Générer des points de division aléatoires
  for (int i = 1; i < splits; i++) {
    points[i] = (horizontal ? h : w) * random(0.2, 0.8); // éviter divisions trop petites
  }
  java.util.Arrays.sort(points);
  
  for (int i = 0; i < splits; i++) {
    float nx = x + (horizontal ? 0 : points[i]);
    float ny = y + (horizontal ? points[i] : 0);
    float nw = horizontal ? w : points[i+1] - points[i];
    float nh = horizontal ? points[i+1] - points[i] : h;
    
    // Appel récursif
    if (random(1) > 0.3) { // certains rectangles ne se subdivisent pas
      mmondrian(nx, ny, nw, nh);
    } else {
    fill(colors[int(random(colors.length))]);
      stroke(0);
      strokeWeight(6);
      rect(nx, ny, nw, nh);
    }
  }
}
