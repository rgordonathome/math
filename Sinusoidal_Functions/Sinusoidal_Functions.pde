// global variables and objects //<>//
PFont serifItalic;
PFont serif;
PFont greek;
float angle = 45;
float quadrantHeight = 0;
boolean[] anglesRequested = new boolean[541];

// this function runs once
void setup() {

  // canvas size
  size(1200, 600);

  // Use Hue-Saturation-Brightness colour model
  colorMode(HSB, 360, 100, 100, 100);

  // background colour
  background(0, 0, 100); // white

  // Height that various interface elements will be constructed against
  // May need to change this if the canvas size is changed
  quadrantHeight = width/5;

  // Set fonts
  serif = loadFont("Times-Roman-24.vlw");
  serifItalic = loadFont("Times-Italic-24.vlw");
  greek = loadFont("TimesNewRomanPS-ItalicMT-24.vlw");

  // Draw initial images
  drawUnitCircle();
  drawSinusoidal();
}

// This function iterates forever
void draw() {
}

// This function responds to key presses
void keyPressed()
{
  // Change angle based on keypresses
  if (key == CODED) {
    if (keyCode == LEFT) {
      angle++;
    }
    if (keyCode == RIGHT) {
      angle--;
    }
  }

  // No negative angles
  if (angle < 0) {
    angle = 0;
  }

  // For this value of theta on the unit circle, draw that ratio vs theta on sinusoidal axis 
  if (angle <= 540) {
    anglesRequested[int(angle)] = true;
  }

  // Re-draw circle and sinusoidal  
  drawUnitCircle();
  drawSinusoidal();
  //println(angle); // DEBUG
}

// drawUnitCircle
//
// Purpose: Draws all elements of the unit circle, using the most recent angle measure.
//
// Parameters: none
void drawUnitCircle() {

  // White rectangle over entire canvas
  noStroke();
  fill(0, 0, 100);
  rect(0, 0, width, height);

  // Save regular translation settings
  pushMatrix(); 

  // Make origin for unit circle be at left side of screen
  translate(quadrantHeight, height/2);

  // Draw axes for unit circle
  stroke(0);
  strokeWeight(2);
  line(-1*quadrantHeight, 0, quadrantHeight, 0); // x-axis
  line(0, -1*quadrantHeight, 0, quadrantHeight); // y-axis

  // Labels for unit circle
  textFont(serifItalic);
  fill(0, 0, 0);
  text("x", quadrantHeight - quadrantHeight / 16, -1 * quadrantHeight / 16);
  text("y", quadrantHeight / 16, -1 * quadrantHeight + quadrantHeight / 16);

  // Unit circle itself
  noFill();
  float diameter = quadrantHeight*2 - quadrantHeight / 3 * 2;
  float radius = diameter / 2;
  ellipse(0, 0, diameter, diameter);

  // Mark unit points
  fill(0, 0, 0); // black
  textFont(serif);
  text("(1, 0)", diameter/2 + quadrantHeight / 24, quadrantHeight/8);
  ellipse(diameter/2, 0, quadrantHeight / 36, quadrantHeight / 36);
  text("(-1, 0)", (diameter/2 + (quadrantHeight / 7) * 2) * -1, quadrantHeight/8);
  ellipse(diameter/2 * -1, 0, quadrantHeight / 36, quadrantHeight / 36);
  text("(0, 1)", quadrantHeight/24, (diameter/2 + quadrantHeight / 24) * -1);
  ellipse(0, diameter/2, quadrantHeight / 36, quadrantHeight / 36);
  text("(0, -1)", quadrantHeight/24, diameter/2 + quadrantHeight / 10);
  ellipse(0, diameter/2 * -1, quadrantHeight / 36, quadrantHeight / 36);

  // Draw 45 degree reference triangle
  strokeWeight(4);
  fill(300);
  float x = cos(radians(angle)) * radius;
  float y = sin(radians(angle)) * radius;
  noStroke();
  triangle(0, 0, x, 0, x, -1*y);
  stroke(0);
  line(0, 0, x, 0);  // x
  stroke(240, 80, 90); // blue
  line(x, 0, x, -1*y); // y
  stroke(0);
  line(0, 0, x, -1*y); // r
  fill(0);

  // Draw point P on unit circle
  ellipse(x, -1*y, quadrantHeight / 36, quadrantHeight / 36);
  textFont(serifItalic);
  fill(0, 0, 0);
  float xLabel = cos(radians(angle)) * (radius + radius / 6);
  float yLabel = sin(radians(angle)) * (radius + radius / 6);
  text("P", xLabel, yLabel*-1);

  // Draw theta
  noFill();
  strokeWeight(2);
  stroke(0, 80, 90); // red
  pushMatrix();
  scale(1, -1);
  arc(0, 0, radius/4, radius/4, radians(0), radians(angle));
  popMatrix();

  // Restore original translation settings
  popMatrix();
}

// drawSinusoidal
//
// Purpose: Draws the matching sine curve based on what's happening in the unit circle
//
// Parameters: none
void drawSinusoidal() {

  // Origin for unit circle at left side of screen
  translate(quadrantHeight*270/100, height/2);

  // Draw axes for sinusoidal
  stroke(0);
  strokeWeight(2);
  stroke(0, 80, 90); // red
  line(-1*quadrantHeight/3, 0, quadrantHeight*3, 0); // x-axis
  stroke(240, 80, 90); // blue
  line(0, -1*quadrantHeight, 0, quadrantHeight); // y-axis

  // Labels for sinusoidal axes
  fill(0, 0, 0);
  textFont(greek);
  String s="\u03B8";        
  text(s, quadrantHeight*2 + quadrantHeight / 8, -1 * quadrantHeight / 16);
  textFont(serifItalic);
  text("sine", quadrantHeight / 16, -1 * quadrantHeight + quadrantHeight / 16);

  // Scale for vertical axis
  float diameter = quadrantHeight*2 - quadrantHeight / 3 * 2;
  // Positive one
  strokeWeight(2);
  stroke(0);
  line(-1 * quadrantHeight / 36, -1*diameter/2, quadrantHeight / 36, -1*diameter/2);
  fill(0);
  textFont(serif);
  text("1", -1 * quadrantHeight/12, (diameter/2 - quadrantHeight/36) * -1);
  // Negative one
  line(-1 * quadrantHeight / 36, diameter/2, quadrantHeight / 36, diameter/2);
  textFont(serif);
  text("-1", -1 * quadrantHeight/8, (diameter/2 + quadrantHeight/28));

  // Scale for horizontal axis
  line(quadrantHeight/2, -1 * quadrantHeight / 36, quadrantHeight/2, 1 * quadrantHeight / 36);
  textFont(serifItalic); 
  text("90", quadrantHeight/2 - quadrantHeight / 20, quadrantHeight / 8);
  s="\u00B0";
  textFont(greek); 
  text(s, quadrantHeight/2 + quadrantHeight / 20, quadrantHeight / 8);
  line(quadrantHeight, -1 * quadrantHeight / 36, quadrantHeight, 1 * quadrantHeight / 36); 
  textFont(serifItalic); 
  text("180", quadrantHeight - quadrantHeight / 14, quadrantHeight / 8);
  textFont(greek); 
  text(s, quadrantHeight + quadrantHeight / 13, quadrantHeight / 8);
  line(quadrantHeight/2*3, -1 * quadrantHeight / 36, quadrantHeight/2*3, 1 * quadrantHeight / 36); 
  textFont(serifItalic); 
  text("270", quadrantHeight/2*3 - quadrantHeight / 14, quadrantHeight / 8);
  textFont(greek); 
  text(s, quadrantHeight/2*3 + quadrantHeight / 13, quadrantHeight / 8);
  line(quadrantHeight*2, -1 * quadrantHeight / 36, quadrantHeight*2, 1 * quadrantHeight / 36); 
  textFont(serifItalic); 
  text("360", quadrantHeight*2 - quadrantHeight / 14, quadrantHeight / 8);
  textFont(greek); 
  text(s, quadrantHeight*2 + quadrantHeight / 13, quadrantHeight / 8);

  // Plot ratio vs. theta for any angle values that have been requested
  float y2 = 0;
  float x1 = 0;
  float radius = diameter / 2;
  stroke(240, 80, 90); // blue
  strokeWeight(1);
  for (int i = 0; i <= 540; i++) {
    if (anglesRequested[i] == true) {
      y2 = sin(radians(i)) * radius;
      x1 = map(i, 0, 540, 0, quadrantHeight*3);
      line(x1, 0, x1, y2*-1);
    }
  }
  
}
