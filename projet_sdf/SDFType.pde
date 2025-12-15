// https://iquilezles.org/articles/distfunctions2d/
public enum SDFType {
  CIRCLE {
    float dist(float x, float y, float[] p) {
      return MainApp.dist(x, y, p[0], p[1]) - p[2];
    }
    float[] defaultParams() {
      return new float[]{0, 0, 0.15f}; // x, y, radius
    }
  }
  ,
    BOX {
    float dist(float x, float y, float[] p) {
      float dx = abs(x - p[0]) - p[2];
      float dy = abs(y - p[1]) - p[3];
      return max(dx, dy);
    }
    float[] defaultParams() {
      return new float[]{0, 0, 0.15f, 0.15f}; // x, y, width, height
    }
  }
  , EQUILATERAL_TRIANGLE {
  float dist(float x, float y, float[] p) {
    float k = sqrt(3.0f);
    float px = abs(x - p[0]) - p[2];
    float py = (y - p[1]) + p[2] / k;
    
    if (px + k * py > 0.0f) {
      float newPx = (px - k * py) / 2.0f;
      float newPy = (-k * px - py) / 2.0f;
      px = newPx;
      py = newPy;
    }
    
    px -= constrain(px, -2.0f * p[2], 0.0f);
    
    float len = sqrt(px * px + py * py);
    float sign = py < 0 ? -1.0f : 1.0f;
    return -len * sign;
  }
  float[] defaultParams() {
    return new float[]{0, 0, 0.2f}; // x, y, radius
  }
}
  , HEART {
    float dist(float x, float y, float[] p) {
      float scale = p[2];
      float px = abs(x - p[0]) / scale;
      float py = -(y - p[1]) / scale; // Inversé pour avoir le cœur à l'endroit

      if (py + px > 1.0f) {
        float dx = px - 0.25f;
        float dy = py - 0.75f;
        return (sqrt(dx * dx + dy * dy) - sqrt(2.0f) / 4.0f) * scale;
      }

      float d1x = px;
      float d1y = py - 1.0f;
      float dist1 = d1x * d1x + d1y * d1y;

      float maxVal = max(px + py, 0.0f);
      float d2x = px - 0.5f * maxVal;
      float d2y = py - 0.5f * maxVal;
      float dist2 = d2x * d2x + d2y * d2y;

      return sqrt(min(dist1, dist2)) * (px - py < 0 ? -1.0f : 1.0f) * scale;
    }
    float[] defaultParams() {
      return new float[]{0, 0, 0.2f}; // x, y, scale
    }
  };

  abstract float dist(float x, float y, float[] params);
  abstract float[] defaultParams();

  // Méthode pour créer une shape avec couleur random
  public SDFShape createDefault(MainApp p) {
    int randomColor = p.color(p.random(255), p.random(255), p.random(255));
    return p.new SDFShape(this, defaultParams(), randomColor);
  }
}
