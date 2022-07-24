BM[] brownians = new BM[3000];
float theta = 2 * PI / 3000;
ArrayList<PVector> DLA = new ArrayList<PVector>();
float r = 4;
float R = r + 30;
int frame = 1;
float w;
float h;

void setup() {
  //size(1800, 1000);
  fullScreen();
  background(0);
  w = width / 2;
  h = height / 2;
  
  colorMode(HSB, 360, 100, 100, 100);

  DLA.add(new PVector(width/2, height/2));
  fill(0, 100, 100);
  ellipse(width/2, height/2, r, r);
}

void draw() {
  //stroke(0);
  //fill(0, 1.5);
  //rect(0, 0, width, height);

  noStroke();
  fill(255);
  float hue = 0;
  for (PVector p : DLA) {
    fill(hue, 100, 100);
    hue += 0.5;
    if (hue >= 360) {
      hue -= 360;
    }
    ellipse(p.x, p.y, r, r);

    if ((p.x <= r) || (p.y <= r) || (p.x >= width - r) || (p.y >= height - r)) {
      save(str(frame)+".jpg");
      brownians[4000] = new BM(0, 0);
    }
  }

  //for (int i = 0; i < width; i++) {
  //  brownians[i] = new BM(i, 0);
  //}
  //for (int j = 0; j < height; j++) {
  //  brownians[width + j] = new BM(0, j);
  //}
  
  // generate brownian motions in a circle around the centre, radius R
  for (int i = 0; i < 3000; i++) {
    brownians[i] = new BM(w + R * cos(i * theta), h + R * sin(i * theta));
  }
  
  // computation of R. this is done by finding the smallest circle about the centre containing all the DLA points, and then adding 250
  float rmax = 0;
  float d;
  for (PVector p : DLA) {
    d = sqrt((p.x - w) * (p.x - w) + (p.y - h) * (p.y - h));
    if (d > rmax) {
      rmax = d;
    }
  }
  R = rmax + 250;
  

  boolean hit = false;
  while (hit == false) {
    for (int i = 0; i < 3000; i++) {
      brownians[i].propagate();
      
      for (PVector p : DLA) {
        float dist = sqrt( (brownians[i].x - p.x)*(brownians[i].x - p.x) + (brownians[i].y - p.y)*(brownians[i].y - p.y) );
        if (dist < r) { // if collision, add bm to aggregate
          println("hit!");
          DLA.add(new PVector(brownians[i].x, brownians[i].y));
          hit = true;
          ellipse(brownians[i].x, brownians[i].y, r, r);
          break;
        }
      }
      if (hit == true) {
        break;
      }
    }
  }
  frame++;
}
