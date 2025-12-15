// Classe utilitaire pour une forme
public class SDFShape {
  SDFType type;
  float[] params;
  color myColor;

  SDFShape(SDFType type, float[] params, color myColor) {
    this.type = type;
    this.params = params;
    this.myColor = myColor;
  }

  float compute(float x, float y) {
    return type.dist(x, y, params);
  }

  // Déplace la forme en ajoutant dx, dy
  public void move(float dx, float dy) {
    params[0] += dx;
    params[1] += dy;
  }
}
