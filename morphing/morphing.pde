PImage imgStart, imgEnd, imgInter;

int N = 10;
int n = 0;

void setup() {
  size(512, 512);
  imgStart = loadImage("img_1.jpg");
  imgEnd = loadImage("img_2.jpg");
  imgStart.filter(GRAY);
  imgEnd.filter(GRAY);
  imgInter = createImage(imgStart.width, imgStart.height, RGB);
  frameRate(2); // pour visualiser les étapes lentement
}

void draw() {
  imgInter.loadPixels();
  imgStart.loadPixels();
  imgEnd.loadPixels();

  for (int i = 0; i < imgInter.pixels.length; i++) {
    float grayStart = brightness(imgStart.pixels[i]);
    float grayEnd = brightness(imgEnd.pixels[i]);
    float gray = ((float)(N - n) / N) * grayStart + ((float)n / N) * grayEnd;
    imgInter.pixels[i] = color(gray);
  }

  imgInter.updatePixels();
  image(imgInter, 0, 0);

  n++;
  if (n > N) noLoop();
}
