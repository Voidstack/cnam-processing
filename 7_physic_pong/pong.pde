// Pong physique — Processing 4
int W = 800, H = 400;

// Raquettes
int paddleW = 14, paddleH = 90;
float p1x = 20, p2x;
float p1y, p2y;
float paddleSpeed = 6;

// Balle
float R = 12;
float bx, by;
float vx, vy;

// Physique
float gravity = 0.25;
float bounceFriction = 0.99;  // amortissement rebonds
float paddleFriction = 0.99;  // amortissement au contact paddle

// Etat du jeu
boolean running = false;
boolean gameOver = false;
String endMsg = "";

void setup() {
  size(800, 400, P2D);
  smooth(4);
  
  p2x = W - 20 - paddleW;
  resetGame();
  textAlign(CENTER, CENTER);
  textSize(18);
}

void resetGame() {
  // Raquettes
  p1y = H/2 - paddleH/2;
  p2y = H/2 - paddleH/2;

  // Balle
  bx = W/2;
  by = H/2;
  vx = random(3.5, 5.0) * (random(1) < 0.5 ? -1 : 1);
  vy = random(1.5, 3.0) * (random(1) < 0.5 ? -1 : 1);

  running = false;
  gameOver = false;
  endMsg = "";
}

void draw() {
  background(18);

  // Info commandes
  fill(255);
  text("Z/S : Gauche — ↑/↓ : Droite — ESPACE : start/reset — G : inverse gravité", W/2, 18);

  drawPaddles();
  drawBall();

  if (!running) {
    fill(gameOver ? color(255,150,150) : 200);
    text(gameOver ? endMsg + " — ESPACE pour rejouer" : "Appuie sur ESPACE pour démarrer", W/2, H/2);
    return;
  }

  handleControls();

  // Gravité
  vy += gravity;

  // Déplacement balle
  bx += vx;
  by += vy;

  // Rebonds haut/bas
  if (by < R) { by = R; vy *= -bounceFriction; vx *= bounceFriction; }
  if (by > H - R) { by = H - R; vy *= -bounceFriction; vx *= bounceFriction; }

  // Collisions raquettes
  checkPaddleCollision();

  // Sortie gauche/droite -> défaite
  if (bx < -R || bx > W + R) {
    gameOver = true;
    running = false;
    endMsg = (bx < -R) ? "Droite gagne — Gauche a manqué" : "Gauche gagne — Droite a manqué";
    return;
  }

  // Stabilisation sur bord
  if ((bx <= R || bx >= W - R) && sqrt(vx*vx + vy*vy) < 0.25) {
    gameOver = true;
    running = false;
    float distLeft = abs(bx - p1x - paddleW/2);
    float distRight = abs(bx - p2x - paddleW/2);
    endMsg = (distLeft < distRight) ? "Gauche trop proche — Gauche perd" : "Droite trop proche — Droite perd";
    return;
  }
}

void drawPaddles() {
  fill(255);
  rect(p1x, p1y, paddleW, paddleH);
  rect(p2x, p2y, paddleW, paddleH);
}

void drawBall() {
  fill(255, 230, 80);
  ellipse(bx, by, R*2, R*2);
}

void handleControls() {
  if (keyPressed) {
    if (key == 'z' || key == 'Z') p1y -= paddleSpeed;
    if (key == 's' || key == 'S') p1y += paddleSpeed;
    if (keyCode == UP) p2y -= paddleSpeed;
    if (keyCode == DOWN) p2y += paddleSpeed;
  }
  p1y = constrain(p1y, 0, H - paddleH);
  p2y = constrain(p2y, 0, H - paddleH);
}

void checkPaddleCollision() {
  // Paddle gauche
  if (bx - R < p1x + paddleW && bx - R > p1x && by > p1y && by < p1y + paddleH && vx < 0) {
    bx = p1x + paddleW + R;
    float rel = (by - (p1y + paddleH/2)) / (paddleH/2);
    vy += rel * 4.0;
    vx = -vx * paddleFriction;
    vy *= paddleFriction;
  }
  // Paddle droite
  if (bx + R > p2x && bx + R < p2x + paddleW && by > p2y && by < p2y + paddleH && vx > 0) {
    bx = p2x - R;
    float rel = (by - (p2y + paddleH/2)) / (paddleH/2);
    vy += rel * 4.0;
    vx = -vx * paddleFriction;
    vy *= paddleFriction;
  }
}

void keyPressed() {
  if (key == ' ') {
    if (gameOver) resetGame();
    running = true;
  }
  if (key == 'g' || key == 'G') gravity = -gravity;
  if (key == 'r' || key == 'R') resetGame();
}
