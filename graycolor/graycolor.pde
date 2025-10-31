PImage imgAdd;
PImage imgAddGray;

PImage imgSous;
PImage imgSousGray;

void setup() {
  size(800, 800);
  noLoop(); // exécute draw() une seule fois

  imgAdd = loadImage("additive.png"); // Remplace par le nom de ton image
  imgAddGray = createImage(imgAdd.width, imgAdd.height, RGB);

  imgSous = loadImage("soustractive.png");
  imgSousGray = createImage(imgSous.width, imgSous.height, RGB);

  imgAdd.loadPixels();
  imgAddGray.loadPixels();
  
  imgSous.loadPixels();
  imgSousGray.loadPixels();

  for (int i = 0; i < imgAdd.pixels.length; i++) {
    color c = imgAdd.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);
    
    float gray = (r+g+b)/3;

    imgAddGray.pixels[i] = color(gray);
  }

  imgAddGray.updatePixels();
  
  // sous
  for (int i = 0; i < imgSous.pixels.length; i++) {
    color c = imgSous.pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    float gray = (r+g+b)/3;

    imgSousGray.pixels[i] = color(gray);
  }

  imgSousGray.updatePixels();
}

void draw() {
  image(imgAdd, 0, 0);
  image(imgAddGray, imgAdd.width, 0);
  
  image(imgSous, 0, 400);
  image(imgSousGray, imgSous.width, imgSous.height);
}
