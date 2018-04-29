
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
  head.display(keys, border);
  
  for(Enemy e : enemies)
  {
    float distance = dist(e.x,e.y,head.x,head.y);
    if(distance < (head.mass + e.diameter)/2)
   {
     e.diameter=0;
   }
   
     for(Enemy f : enemies)
     {
       if(e.touches(f))//if the objects are touching
       {
         if(e.x<f.x)//if object i is more towards the left
         {
           e.x=e.x-2;
           f.x=f.x+2;
         }
         else
         {
           e.x=e.x+2;
           f.x=f.x-2;
         }
       }
     }
  }
}

