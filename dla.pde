int parts = 2;
BM[] brownians = new BM[parts];
float theta = 2 * PI / (float)parts;
ArrayList<PVector> DLA = new ArrayList<PVector>();
float r = 2;
float R = r + 20;
int frame = 1;
float w;
float h;
boolean circles = false;

void setup() {
  //size(1800, 1000);
  fullScreen();
  background(0);
  w = width / 2;
  h = height / 2;

  colorMode(HSB, 360, 100, 100, 100);

  DLA.add(new PVector(w, h));
  fill(0, 100, 100);
  ellipse(w, h, r, r);
}

void draw() {
  //stroke(0);
  //fill(0, 1.5);
  //rect(0, 0, width, height);
  background(0);

  noStroke();
  fill(255);
  float hue = 0;
  for (PVector p : DLA) {
    fill(hue, 100, 100);
    hue += 0.03;
    if (hue >= 360) {
      hue -= 360;
    }
    ellipse(p.x, p.y, r, r);

    if ((p.x <= r) || (p.y <= r) || (p.x >= width - r) || (p.y >= height - r)) {
      save(str(frame)+".jpg");
      brownians[parts] = new BM(0, 0);
    }
  }

  // generate brownian motions in a circle around the centre, radius R
  for (int i = 0; i < parts; i++) {
    brownians[i] = new BM(w + R * cos(i * theta + random(2 * PI)), h + R * sin(i * theta + random(2 * PI)));
  }

  // computation of R. this is done by finding the smallest circle about the centre containing all the DLA points, and then adding 25
  float rmax = 0;
  float d;
  for (PVector p : DLA) {
    d = sqrt((p.x - w) * (p.x - w) + (p.y - h) * (p.y - h));
    if (d > rmax) {
      rmax = d;
    }
  }
  R = rmax + 25;

  noFill();
  stroke(0, 0, 100);
  // choose whether or not to display birth/death circles. toggled by mouse press
  if (circles == true) {
    ellipse(w, h, 2 * R, 2 * R);
    ellipse(w, h, 2 * 4 * R, 2 * 4 * R);
  }

  boolean hit = false;
  while (hit == false) {
    for (int i = 0; i < parts; i++) {
      brownians[i].propagate();
      //brownians[i].display();

      for (PVector p : DLA) {
        float dist = sqrt( (brownians[i].x - p.x)*(brownians[i].x - p.x) + (brownians[i].y - p.y)*(brownians[i].y - p.y) );
        if (dist < r) { // if collision, add bm to aggregate
          println(frame);
          DLA.add(new PVector(brownians[i].x, brownians[i].y));
          hit = true;
          ellipse(brownians[i].x, brownians[i].y, r, r);
          break;
        }
        if (dist > 4 * R) {
          hit = true; // not actually hit
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

void mousePressed() {
  circles = !circles;
}
