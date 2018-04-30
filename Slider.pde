class Slider {

 int x,y,r,max,min;
  
  Slider() {
    x=50;
    r=20;
    max=150;
    min=50;
  }
  
  void display() {
    fill(255);
    rect(50,50,100,4);
    fill(255,0,0);
    ellipse(x,52,r,r);
  }

}
