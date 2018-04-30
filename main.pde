//about
//struggled with pressed multiple arrow keys at one for diagonal movement but fixed it with a boolean array


//functions
Snakehead. head;
Border border;
boolean[] keys;
ArrayList <Enemy> enemies;

void setup() {
 size(500,600);
 //initialise objects
 head = new Snakehead();
 border = new Border();
 slider = new Slider();
 keys= new boolean[4];
 enemies = new ArrayList<Enemy>();
 
 keys[0]=false;
 keys[1]=false;
 keys[2]=false;
 keys[3]=false;
}

void draw() {
background(100);
border.display();
slider.display();
head.borders(border);

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

void keyPressed()
{
  if(keyCode==UP)
  {
    keys[0]=true;
  }
  if(keyCode==DOWN)
  {
    keys[1]=true;
  }
  if(keyCode==LEFT)
  {
    keys[2]=true;
  }
  if(keyCode==RIGHT)
  {
    keys[3]=true;
  }
}

void keyReleased()
{
 if(keyCode==UP)
  {
    keys[0]=false;
  }
  if(keyCode==DOWN)
  {
    keys[1]=false;
  }
  if(keyCode==LEFT)
  {
    keys[2]=false;
  }
  if(keyCode==RIGHT)
  {
    keys[3]=false;
  }
}

void mouseDragged()
{
 if (slider.x-slider.r < mouseX && mouseX < slider.x+slider.r)//if within x range
 {
   if(32 < mouseY && mouseY < 72)//and within y range
   {
     if ( mouseX < slider.max && mouseX > slider.min)//within slider limits
     {
       slider.x=mouseX;//move
       for(Enemy e : enemies)
       {
         e.vibrate=(slider.x/30);
       }
     }
   }
 }
}
