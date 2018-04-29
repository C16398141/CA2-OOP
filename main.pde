
//about


//functions
Snakehead. head;
boolean[] keys;

void setup() {
 size(500,600);
 //initialise objects
 head = new Snakehead();
 border = new Border();
 keys= new boolean[4];
 
 keys[0]=false;
 keys[1]=false;
 keys[2]=false;
 keys[3]=false;
}

void draw() {
background(100);

head.display(keys, border);

if(frameCount % 60 == 0)
  {
    enemies.add(new Enemy());
  }
  boolean b=false;

  for(Enemy e : enemies)
  {
    if(e.diameter!=0)
    {
      e.display();
      e.run();
      b=e.borders(border);
      if(b==true)
      {
       //enemies.remove(e); concurrent modulation exception
       e.diameter=0;
       head.mass--;
      }
    }
  }

}
