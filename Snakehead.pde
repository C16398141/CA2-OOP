class Snakehead extends Body {
  
  Snakehead() {
  //initialise variables here
  x=width/2;
  y=height/2;
  diameter=15;
  speed=4;
  }
  
  void display(boolean[] keys, Border border) {
    fill(0);
    ellipse(x,y,diameter,diameter);
    if(keys[0])//up arrow pressed
    {
      y=y-speed;
    }
     if(keys[1])//down arrow pressed
    {
      y=y+speed;
    }
     if(keys[2])//left arrow pressed
    {
      x=x-speed;
    }
     if(keys[3])//right arrow pressed
    {
      x=x+speed;
    }
  }
    
  void borders(Border border)
   {
     float distance = x-border.x;
     if(distance <= (diameter/2))
     {
       x=x+10;
     }
     
     distance = border.x+border.thickness-x;
     if(distance <= (diameter/2))
     {
       x=x-10;
     }
   }
}
