enum UnionType {
  INTERSECTION_LISSE {
    float apply(float d1, float d2, float k) {
      float h = max(k - abs(d1 - d2), 0.0) / k;
      return max(d1, d2) + h*h*k*0.25;
    }
  }
  , SOUSTRACTION_LISSE {
    float apply(float d1, float d2, float k) {
      float h = max(k - abs(-d1 - d2), 0.0) / k;
      return max(d1, -d2) + h*h*k*0.25;
    }
  }
  ,
    UNION_LISSE {
    float apply(float d1, float d2, float k) {
      float h = max(k - abs(d1 - d2), 0.0) / k;
      return min(d1, d2) - h * h * k * 0.25;
    }
  };

  abstract float apply(float d1, float d2, float k);
}
