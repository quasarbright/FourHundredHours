float xmin = -10;
float xmax = 10;
float ymin = -10;
float ymax = 10;

Seeker seeker;
void setup(){
  size(600,600);
  seeker = new Seeker();
}

void draw(){
  background(0);
  seeker.update();
  seeker.show();
}

PVector toPixel(PVector v){
  float newx = map(v.x, xmin, xmax, 0, width);
  float newy = map(v.y, ymin, ymax, height, 0);
  return new PVector(newx, newy);
}

PVector toCoord(PVector v){
  float newx = map(v.x, 0, width, xmin, xmax);
  float newy = map(v.y, height, 0, ymin, ymax);
  return new PVector(newx, newy);
}
