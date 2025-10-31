import gab.opencv.*;
import java.awt.*;

OpenCV opencv;

void setup() {
  size(500, 500);
  opencv = new OpenCV(this, "img.jpg");
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  Rectangle[] faces = opencv.detect();
  
  image(opencv.getInput(), 0, 0);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  for(int i =0; i < faces.length; i++){
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);    
  }
  save("detection.png");
}
