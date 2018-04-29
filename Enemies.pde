class Enemy {
float x,y,diameter,z;
  float speed;
  
  Enemy() {
   x= random(width/4,width/2);
   y= 75;
   z=0;
   diameter = 10;
   speed = random(1,1.5);
   }
   
   void display() {
     fill(100);
     ellipse(x,y,diameter,diameter);
   }
   
    void run() {
      y = y + speed;
      x = x + z;
      if (frameCount % 30 == 0)
      {
        //if framecount divided by a second is zero
        z = random(-2*speed,2*speed);
      }
   }
}
