class Obstacle{
  PVector p;
  float w, h;
  Obstacle(PVector p, float w, float h){
    this.p = p;
    this.w = w;
    this.h = h;
  }
  
  boolean checkHitbox(PVector v){
    //returns true if v is in the rectangle hitbox
    float l = p.x;
    float r = p.x + w;
    float u = p.y + h;
    float d = p.y;
    return (l <= v.x && v.x <= r && d <= v.y && v.y <= u);
  }
  
  void show(){
    pushMatrix();
    noStroke();
    fill(255,0,0,100);
    PVector pp = toPixel(p);
    float wp = map(w, 0, xmax-xmin, 0, width);
    float hp = map(h, 0, ymax-ymin, 0, height);
    rect(pp.x,pp.y-hp,wp,hp);
    popMatrix();
  }
}
