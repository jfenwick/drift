// Inspired by the research and art of Akiyoshi KITAOKA
// http://www.ritsumei.ac.jp/~akitaoka/index-e.html

// color of the background and the ellipse behind a drift
color bgcolor = color(255, 255, 255);
// color of center rectangle
color c1 = color(0, 0, 0);
// color of left ellipse
color c2 = color(0, 50, 255);
// color of right ellipse
color c3 = color(0, 200, 255);

void setup() {
  size(1280, 800  );
  background(bgcolor);
  ellipseMode(CENTER);
  rectMode(CENTER);
  smooth();
}

void draw() {
}

void mousePressed() {
  if (mouseButton == LEFT) {
    translate(mouseX, mouseY);
    Dimensions d = new Dimensions();
    fill(bgcolor);
    stroke(bgcolor);
    ellipse(0, 0, 2*abs(d.d_radius)+d.e_height, 2*abs(d.d_radius)+d.e_height);
    float angle_start = 0;
    float[] scale_amounts = {1.0, 0.84, 0.7, 0.59, 0.49, 0.41, 0.34, 0.29, 0.24, 0.20, 0.17, 0.15, 0.13, 0.11, 0.10, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.015, 0.01};
    boolean log_mode = false;
    
    if (log_mode) {
      // log version
      float log_amount = 1.0;
      for (int i = 0; i < scale_amounts.length; i++) {
        float d_scale = 1.0/log_amount;
        log_amount = log_amount + 0.20;
        for (int j=0; j<d.subdivisions; j++) {
          draw_drift(angle_start + j*d.angle, d, d_scale);
        }
        angle_start = angle_start + 7;
      }
    }
    else {
      for (int i = 0; i < scale_amounts.length; i++) {
        float d_scale = scale_amounts[i];
        for (int j=0; j<d.subdivisions; j++) {
          draw_drift(angle_start + j*d.angle, d, d_scale);
        }
        angle_start = angle_start + 7;
      }
    }
  }
}

public void draw_drift(float deg, Dimensions d, float d_scale) {
  pushMatrix();
  rotate(radians(deg));
  scale(d_scale);
  fill(c1);
  stroke(c1);
  rect(0, d.d_radius, d.r_width, d.r_height);
  fill(c2);
  stroke(c2);
  ellipse(d.r_x1, d.d_radius, d.e_width, d.e_height);
  fill(c3);
  stroke(c3);
  ellipse(d.r_x2, d.d_radius, d.e_width, d.e_height);
  popMatrix();
}

public class Dimensions {
  public float r_x1 = -12;
  public float r_x2 = 12;
  public float r_width = 20;
  public float r_height = 30;
  public float e_width = 15;
  public float e_height = 30;

  public float d_radius = -170;
  public float angle = 15;
  public float angle_start = 0;
  public float max_angle = 360;
  public float subdivisions = max_angle / angle;

  Dimensions() {
  }
}
