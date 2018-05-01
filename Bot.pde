class Bot extends Body {
  
  Bot() {
  x=width/2;
  y=random(450,550);
  speed=2;
  diameter=11;
  bot=true;
 }
 
 void display() {
     fill(50);
     ellipse(x,y,diameter,diameter);
   }
   
   void move() {
    x=x+speed; 
   }
  
}
