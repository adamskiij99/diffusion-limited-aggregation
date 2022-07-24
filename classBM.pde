class BM {
  float x;
  float y;
  float hue = random(0, 360);

  BM(float tempx, float tempy) {
    x = tempx;
    y = tempy;
  }

  void display() {
    fill(hue);
    stroke(hue, 100, 100);
    ellipse(x, y, 1, 1);
  }

  void propagate() {
    x += randomGaussian();
    y += randomGaussian();
    if (x > width) {
      x -= width;
    }
    if (x < 0) {
      x += width;
    }
    if (y > height) {
      y -= height;
    }
    if (y < 0) {
      y += height;
    }
  }
}
