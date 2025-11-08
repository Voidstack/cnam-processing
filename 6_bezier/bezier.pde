PVector P0, P1, P2, P3;

void setup() {
  size(600, 600);
  P0 = new PVector(100, 500);
  P1 = new PVector(200, 100);
  P2 = new PVector(400, 100);
  P3 = new PVector(500, 500);
}

void draw() {
  background(0);
  P1.set(mouseX, mouseY);

  // --- courbe blanche ---
  stroke(255);
  noFill();
  beginShape();
  for (float t = 0; t <= 1; t += 0.01) {
    PVector B = bezierPoint(P0, P1, P2, P3, t);
    vertex(B.x, B.y);
  }
  endShape();

  // --- lignes de contrôle rouges ---
  stroke(255, 0, 0);
  line(P0.x, P0.y, P1.x, P1.y);
  line(P1.x, P1.y, P2.x, P2.y);
  line(P2.x, P2.y, P3.x, P3.y);

  // --- construction De Casteljau au milieu (t = 0.5) ---
  float t = 0.5;
  PVector Q0 = lerpPoint(P0, P1, t);
  PVector Q1 = lerpPoint(P1, P2, t);
  PVector Q2 = lerpPoint(P2, P3, t);

  // segments verts de 1er niveau
  stroke(0, 255, 0);
  line(Q0.x, Q0.y, Q1.x, Q1.y);
  line(Q1.x, Q1.y, Q2.x, Q2.y);

  // points de 2e niveau (R0, R1)
  PVector R0 = lerpPoint(Q0, Q1, t);
  PVector R1 = lerpPoint(Q1, Q2, t);

  // ligne verte entre R0 et R1 (indique la construction finale)
  stroke(0, 200, 0);
  strokeWeight(2);
  line(R0.x, R0.y, R1.x, R1.y);

  // point central sur la courbe (M) et marqueur
  PVector M = lerpPoint(R0, R1, t);
  noStroke();
  fill(0, 255, 0);
  ellipse(M.x, M.y, 10, 10);

  // restaurer strokeWeight par défaut pour éviter effet sur autres traits
  strokeWeight(1);

  // points de contrôle visibles
  fill(255);
  noStroke();
  ellipse(P0.x, P0.y, 8, 8);
  ellipse(P1.x, P1.y, 8, 8);
  ellipse(P2.x, P2.y, 8, 8);
  ellipse(P3.x, P3.y, 8, 8);
}

PVector lerpPoint(PVector a, PVector b, float t) {
  return new PVector(lerp(a.x, b.x, t), lerp(a.y, b.y, t));
}

PVector bezierPoint(PVector p0, PVector p1, PVector p2, PVector p3, float t) {
  float u = 1 - t;
  float x = pow(u, 3)*p0.x + 3*pow(u, 2)*t*p1.x + 3*u*pow(t, 2)*p2.x + pow(t, 3)*p3.x;
  float y = pow(u, 3)*p0.y + 3*pow(u, 2)*t*p1.y + 3*u*pow(t, 2)*p2.y + pow(t, 3)*p3.y;
  return new PVector(x, y);
}
