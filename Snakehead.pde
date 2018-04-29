class Snakehead{
float x,y,mass,speed;

Snakehead()
//initialise variables
x=width/2;
y=height/2;
mass=15;
speed=3;
}

void display() {
if(keyPressed==true)
    {
     if(keyCode==UP)
     {
       y--;
     }
     if(keyCode==DOWN)
     {
       y++;
     }
     if(keyCode==RIGHT)
     {
       x++;
     }
    if(keyCode==LEFT)
    {
      x--;
    }
    keyReleased();
   }
  }
}
