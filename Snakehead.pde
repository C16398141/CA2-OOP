class Snakehead{
float x,y,mass,speed;

Snakehead() {
//initialise variables
x=width/2;
y=height/2;
mass=15;
speed=3;
}

void display(boolean[] keys, Border border) {
    fill(0);
    ellipse(x,y,mass,mass);
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

}
