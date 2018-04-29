class Enemy {
float x,y,diameter,z,c,d,e,vibrate;;
  float speed;
  
  Enemy() {
   x= random(width/4,width/2);
   y= 75;
   z=0;
   vibrate=1;
   c=random(255);
   d=random(255);
   e=random(255);
   diameter = 10;
   speed = random(1,1.5);
   }
   
   void display() {
     fill(c,d,e);
     ellipse(x,y,diameter,diameter);
   }
   
    void run() {
      y = y + speed;
      x = x + random (-vibrate,vibrate);
      x = x + z;
      if (frameCount % 30 == 0)
      {
        //if framecount divided by a second is zero
        z = random(-2*speed,2*speed);
      }
   }
}
