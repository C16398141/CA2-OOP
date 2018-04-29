class Border {
  float x,y,thickness,depth;
  
  Border() {
    //initialise variables here
    x=25;
    y=75;
    thickness=450;
    depth=500;
  }
  void display() {
    fill(255);
    rect(x, y, thickness, depth);
  }
}
