class BoundedValue {
  float min;
  float max;
  float current;

  BoundedValue(float min, float max, float current) {
    this.min = min;
    this.max = max;
    this.current = constrain(current, min, max);
  }

  void set(float value) {
    current = constrain(value, min, max);
  }

  void add(float delta) {
    current = constrain(current + delta, min, max);
  }

  float get() {
    return current;
  }

  float normalized() {
    return (current - min) / (max - min);
  }
}
