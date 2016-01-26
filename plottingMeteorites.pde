/*
 Meteorite strike plotter. Reads meteoritessize.csv, a data file containing
 records of 34.5k meteorite strikes (furnished courtesy of Nick Felton 
 and posted by Golan Levin at 
 http://golancourses.net/2016/resources/meteoritessize.zip)
 
 Projects the UN-flag-style map of the Earth, with the North Pole at the center
 and the South Pole as the entire circumference of the map. (Lots of
 distortion the farther south the map goes.)
 
 Completed by R. Zacharias (rzachari@andrew.cmu.edu) for Golan Levin's
 Interactive Art and Computational Design class at CMU, spring 2016.
 
 Released to the public domain by the author.
 */

Table table;

void setup() {
  size(800, 800);
  pixelDensity(2);

  // draw polar plot
  stroke(230);
  strokeWeight(1); 
  int latSpacer = 100;
  pushMatrix();
  translate(width/2, height/2);
  // rings
  for (int i = 8*latSpacer; i>-1; i-=latSpacer) {
    ellipse(0, 0, i, i);
  }
  // radial lines
  for (int r = 0; r<8; r++) {
    rotate(r*PI/8);
    line(0, -height/2, 0, height/2);
  }

  // open data csv, make arrays to hold values
  table = loadTable("meteoritessize.csv", "header, csv");
  float[] lat = new float[table.getRowCount()];
  float[] longitude = new float[table.getRowCount()];

  // read through csv and load values into lat and longitude arrays
  for (int t = 1; t < table.getRowCount(); t++) {
    lat[t] = table.getFloat(t, "Coordinate 1");
    longitude[t] = table.getFloat(t, "Coordinates 2");
    //println("lat, long = " + lat[t] + '\t' + longitude[t]);
  }

  // red dots
  stroke(255, 0, 0);

  // draw a point on the map for each point in the csv
  smooth(); 
  strokeWeight(2.0); 
  for (int x = 0; x < lat.length; x++) {
    float r = floatMap(lat[x], -90, 90, 400, 0);
    float theta = floatMap(longitude[x], -180, 180, 0, TWO_PI);
    pushMatrix();
    rotate(theta);
    point(r, 0); // to draw points
    //ellipse(r, 0, 2, 2); // to draw ellipses
    popMatrix();
  }

  popMatrix();
}

void draw() {
  // nothing to see here
}


// just does "map" math on floats (map is usually defined for ints only by default)
float floatMap(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}