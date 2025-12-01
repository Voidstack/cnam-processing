// --- CONSTANTES ---
int WIDTH = 800, HEIGHT = 400;
int paddleW = 15, paddleH = 80;
float ballSize = 15;

// --- VARIABLES ---
float ballX, ballY;
float vx, vy;

float p1Y, p2Y;
float speed = 6;

boolean running = false;
boolean gameOver = false;
    
void setup() {
  size(800, 400, P2D);
  smooth(8);

  resetGame();
}

void resetGame() {
  ballX = WIDTH/2;
  ballY = HEIGHT/2;

  // vitesse aléatoire (ni trop faible ni verticale pure)
  vx = random(3, 5) * (random(1) < 0.5 ? -1 : 1);
  vy = random(2, 4) * (random(1) < 0.5 ? -1 : 1);

  p1Y = HEIGHT/2 - paddleH/2;
  p2Y = HEIGHT/2 - paddleH/2;

  running = false;
  gameOver = false;
}

void draw() {
  background(20);

  // Affichage
  drawPaddles();
  drawBall();

  if (!running) {
    fill(255);
    textAlign(CENTER);
    text("Appuie sur ESPACE pour démarrer", WIDTH/2, HEIGHT/2);
    return;
  }

  if (gameOver) {
    fill(255, 80, 80);
    textAlign(CENTER);
    text("PERDU !  ESPACE pour rejouer", WIDTH/2, HEIGHT/2);
    return;
  }

  updateBall();
  checkCollisions();
  handleControls();
}

void drawPaddles() {
  fill(255);
  rect(20, p1Y, paddleW, paddleH);
  rect(WIDTH - 20 - paddleW, p2Y, paddleW, paddleH);
}

void drawBall() {
  fill(255);
  ellipse(ballX, ballY, ballSize, ballSize);
}

void updateBall() {
  ballX += vx;
  ballY += vy;

  // rebond haut/bas
  if (ballY < ballSize/2 || ballY > HEIGHT - ballSize/2) vy *= -1;

  // Défaite ?
  if (ballX < 0) gameOver = true;
  if (ballX > WIDTH) gameOver = true;
}

void checkCollisions() {

  // Paddle gauche
  if (ballX - ballSize/2 < 20 + paddleW &&
      ballY > p1Y && ballY < p1Y + paddleH) {
    vx *= -1;
    ballX = 20 + paddleW + ballSize/2;
  }

  // Paddle droite
  if (ballX + ballSize/2 > WIDTH - 20 - paddleW &&
      ballY > p2Y && ballY < p2Y + paddleH) {
    vx *= -1;
    ballX = WIDTH - 20 - paddleW - ballSize/2;
  }
}

void handleControls() {
  // Joueur 1 : Z / S
  if (keyPressed && key == 'z') p1Y -= speed;
  if (keyPressed && key == 's') p1Y += speed;

  // Joueur 2 : ↑ / ↓
  if (keyPressed && keyCode == UP) p2Y -= speed;
  if (keyPressed && keyCode == DOWN) p2Y += speed;

  // Limiter les raquettes au terrain
  p1Y = constrain(p1Y, 0, HEIGHT - paddleH);
  p2Y = constrain(p2Y, 0, HEIGHT - paddleH);
}

// Lancement/reset
void keyPressed() {
  if (key == ' ') {
    if (gameOver) resetGame();
    running = true;
  }
}
