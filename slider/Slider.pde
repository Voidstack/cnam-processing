private static float sliderWidth = 150;
private static float sliderHeight = 10;

public class Slider {

  private Vector2D pos;
  private BoundedValue values;

  public Slider(Vector2D pos, BoundedValue values) {
    this.pos = pos;
    this.values = values;
  }

  public void draw() {
    // fond du slider
    stroke(180);
    fill(60);
    rect(pos.x, pos.y, sliderWidth, sliderHeight, 5);

    // curseur selon la valeur normalisée
    float ratio = values.normalized();
    float handleX = pos.x + ratio * sliderWidth;

    fill(200);
    noStroke();
    ellipse(handleX, pos.y + sliderHeight / 2, sliderHeight * 2, sliderHeight * 2);
  }

  public void update(float mouseX, float mouseY) {
    if (mouseY >= pos.y - sliderHeight && mouseY <= pos.y + sliderHeight * 2) {
      float ratio = constrain((mouseX - pos.x) / sliderWidth, 0, 1);
      values.set(values.min + ratio * (values.max - values.min));
    }
  }

  public float getValue() {
    return values.get();
  }
}
