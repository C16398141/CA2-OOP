// about
//struggled with pressed multiple arrow keys at one for diagonal movement but fixed it with a boolean array

//functions
//Snakehead head;
ArrayList <Snakehead> head;
Border border;
Slider slider;
boolean[] keys;
ArrayList <Enemy> enemies;
ArrayList <Bot> bots;
int score=0;
PFont font;
//music import
import ddf.minim.*;
Minim minim;
AudioPlayer music;

void setup() {
  size(500,600);
  
  //music
  minim= new Minim(this);
  music = minim.loadFile("Best_Dramatic_music_ever.mp3");
  music.play();
  music.rewind();
  
  //initialise objects
  head = new ArrayList<Snakehead>();
  bots = new ArrayList<Bot>();
  border = new Border();
  slider = new Slider();
  keys= new boolean[4];
  enemies = new ArrayList<Enemy>();
  
  head.add(new Snakehead());
  
  //initialise fonts
  font = loadFont("ArialRoundedMTBold-48.vlw");
  textFont(font);
  
  //head = new ArrayList<Snakehead>();
  /*
  int i;
  for(i=0; i<3; i++)
  {
    head.add(new Snakehead());
    //try to give identifing unique value through variable from 1-x
    //(x being the no. heads. then get(0).mass is the biggest and the largest current unique
    //value is the first to be r
    
  }*/
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;
}

void draw() {
  background(100);
  boolean b,c=false;
  
  border.display();
  slider.display();
  c=head.get(0).borders(border);
  
  fill(255);
  textSize(20);
  text("Score:",10,20);
  text(score,100,20);
  
  if(frameCount % 60 == 0)
  {
    enemies.add(new Enemy());
  }
  
  for(Bot bot : bots)
  {
    bot.display();
    bot.move();
    bot.borders(border);
  }
  head.get(0).display(keys,border);
  
  for(int i = enemies.size() -1; i>= 0; i--)
  {
    enemies.get(i).display();
    enemies.get(i).run();
    enemies.get(i).dead=enemies.get(i).borders(border);
    if(enemies.get(i).dead==true)
    {
      head.get(0).diameter--;
      enemies.remove(i);
    }
    float distance = dist(enemies.get(i).x,enemies.get(i).y,head.get(0).x,head.get(0).y);
    if(distance < (head.get(0).diameter + enemies.get(i).diameter)/2)
    {
     enemies.get(i).dead = true;
     score=score+10;
     if(score % 50 == 0)
     {
       bots.add(new Bot());
     }
    }
    
    if(enemies.get(i).dead==true)
    {
      enemies.remove(i);
    }
  }
    
    for(Enemy e : enemies)
    {
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
