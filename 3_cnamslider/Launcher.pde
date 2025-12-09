
private Slider[] sliders = {
  new Slider(new Vector2D(100, 50),  new BoundedValue(0, 100, 25)),
  new Slider(new Vector2D(100, 100), new BoundedValue(0, 100, 50)),
  new Slider(new Vector2D(100, 150), new BoundedValue(0, 100, 75))
};

void setup(){
  smooth(8);
  size(350, 200, P2D);
  drawSlider();
  update();
  println("setup done");
}

void draw(){
  // écrire dans le draw c'est pour les zgeg.
}

void mouseDragged() {
  println("mousePressed");  // maintenant ça s'affiche
  updateSlider(mouseX, mouseY);
  update();
}


private void update(){
  background(sliders[0].getValue(), sliders[1].getValue(), sliders[2].getValue());
  drawSlider();
}

private void drawSlider(){
  for (Slider slider : sliders) {
    slider.draw();
  }
}

private void updateSlider(int x, int y){
  for (Slider slider : sliders) {
    slider.update(x, y);
  }
}
