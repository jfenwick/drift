// Inspired by the research and art of Akiyoshi KITAOKA
// http://www.ritsumei.ac.jp/~akitaoka/index-e.html

// color of the background and the ellipse behind a drift
color bgcolor = color(255, 255, 255);
// color of center rectangle
color c1 = color(0, 0, 0);
// color of left ellipse
color c2 = color(100, 50, 255);
// color of right ellipse
color c3 = color(0, 200, 255);

boolean back_ellipse = true;

void setup() {
  size(1280, 800);
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
    // optional ellipse to makes the drift shape blend in with background
    if (back_ellipse) {
      ellipse(0, 0, 2*d.d_radius+d.e_height, 2*d.d_radius+d.e_height);
    }
    float cur_angle = 0;
    float[] scale_amounts = {1.0, 0.84, 0.7, 0.59, 0.49, 0.41, 0.34, 0.29, 0.24, 0.20, 0.17, 0.15, 0.13, 0.11, 0.10, 0.08, 0.07, 0.06, 0.05, 0.04, 0.03, 0.02, 0.015, 0.01};
    int drift_mode = 2;
    
    switch(drift_mode) {
      case 0:
        // log version
        float log_amount = 1.0;
        for (int i = 0; i < scale_amounts.length; i++) {
          float d_scale = 1.0/log_amount;
          log_amount = log_amount + 0.20;
          for (int j=0; j<d.subdivisions; j++) {
            float inner_angle = cur_angle + j*d.angle;
            draw_node(inner_angle, d, d_scale);
          }
          cur_angle = cur_angle + d.angle/2;
        }
        break;
      case 1:
        // freaky spiral
        for (int i = 0; i < scale_amounts.length; i++) {
          float d_scale = scale_amounts[i];
          for (int j=0; j<d.subdivisions; j++) {
            // increase outer angle instead of just inner angle
            cur_angle = cur_angle + j*d.angle;
            draw_node(cur_angle, d, d_scale);
          }
          cur_angle = cur_angle + d.angle/2;
        }
        break;
      case 2:
      default:
        // hard coded array version
        for (int i = 0; i < scale_amounts.length; i++) {
          float d_scale = scale_amounts[i];
          for (int j=0; j<d.subdivisions; j++) {
            // increase angle by d.angle each time
            float inner_angle = cur_angle + j*d.angle;
            draw_node(inner_angle, d, d_scale);
          }
          cur_angle = cur_angle + d.angle/2;
        }
      break;
    }
  }
}

public void draw_node(float deg, Dimensions d, float d_scale) {
  pushMatrix();
  rotate(radians(deg));
  scale(d_scale);
  // rect behind both ellipses
  fill(c1);
  stroke(c1);
  rect(0, d.d_radius, d.r_width, d.r_height);
  // left ellipse
  fill(c2);
  stroke(c2);
  ellipse(d.r_x1, d.d_radius, d.e_width, d.e_height);
  // right ellipse
  fill(c3);
  stroke(c3);
  ellipse(d.r_x2, d.d_radius, d.e_width, d.e_height);
  popMatrix();
}

public class Dimensions {
  // x center of left ellipse
  public float r_x1 = -12;
  // x center of right ellipse
  public float r_x2 = 12;
  // rect width
  public float r_width = 20;
  // rect height
  public float r_height = 30;
  // ellipse width (left and right)
  public float e_width = 15;
  // ellipse height (left and right)
  public float e_height = 30;
  // distance from center
  public float d_radius = 170;
  // angle between each each node
  public float angle = 15;
  // total number of degrees
  public float max_angle = 360;
  // number of subdivisions
  public float subdivisions = max_angle / angle;

  Dimensions() {
  }
}
