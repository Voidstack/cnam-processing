class Vector2D {
  float x, y;

  Vector2D(float x, float y) {
    this.x = x;
    this.y = y;
  }

  Vector2D add(Vector2D v) {
    return new Vector2D(x + v.x, y + v.y);
  }

  Vector2D sub(Vector2D v) {
    return new Vector2D(x - v.x, y - v.y);
  }

  Vector2D mult(float s) {
    return new Vector2D(x * s, y * s);
  }

  Vector2D div(float s) {
    return new Vector2D(x / s, y / s);
  }

  float mag() {
    return sqrt(x * x + y * y);
  }

  Vector2D normalize() {
    float m = mag();
    return (m == 0) ? new Vector2D(0, 0) : div(m);
  }

  float dot(Vector2D v) {
    return x * v.x + y * v.y;
  }

  float dist(Vector2D v) {
    return sqrt(sq(x - v.x) + sq(y - v.y));
  }
}