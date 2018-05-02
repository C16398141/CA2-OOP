// about
//struggled with pressed multiple arrow keys at one for diagonal movement but fixed it with a boolean array

//functions
//Snakehead head;
ArrayList <Snakehead> head;
ArrayList <Droids> droids;
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
  droids = new ArrayList<Droids>();
  border = new Border();
  slider = new Slider();
  keys= new boolean[5];
  enemies = new ArrayList<Enemy>();
  head.add(new Snakehead());
  //initialise fonts
  font = loadFont("ArialRoundedMTBold-48.vlw");
  textFont(font);
  
  //game starts off with a friendly droid- creates a droid
  droids.add(new Droids(head.get(0)));
    
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;
}

void draw() {
  background(100);
  boolean b=false;
  
  border.display();
  slider.display();
  head.get(0).borders(border);
  
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Score:",20,30);
  text(score,110,30);
  
  //tried variations of making 60 a variable that decreased as your score increased but the code wouldn't work even though the logic was perfect
  if(score<100)
  {
  if(frameCount % 60 == 0 && keys[4]==false)
  {
    enemies.add(new Enemy());
  }
  }
  else if(score<500)
  {
  if(frameCount % 45 == 0 && keys[4]==false)
  {
    enemies.add(new Enemy());
  }
  }
  else
  {
  if(frameCount % 30 == 0 && keys[4]==false)
  {
    enemies.add(new Enemy());
  }
  }
  
  for(Bot bot : bots)
  {
    bot.display();
    if(keys[4]==false)
    {
      bot.move();
    }
    bot.borders(border);
  }
  if(keys[4]==false)
    {
      head.get(0).display(keys,border);
    }
  int k=0;
  for(Droids droids : droids)
  {
    k++;
    if(keys[4]==false)
    {
      droids.draw(head.get(0),k);
    }
  }

  for(int i = enemies.size() -1; i>= 0; i--)
  {
    enemies.get(i).display();
    if(keys[4]==false)
    {
      enemies.get(i).run();
    }
    b=enemies.get(i).borders(border);
    if(b)
    {
      head.get(0).diameter--;
      
      //if on last life
      if (head.get(0).diameter==1)
      {
        //change colour to red
        head.get(0).colour=255;
      }
      
      enemies.get(i).dead=true;
    }
    
    for(Enemy e : enemies)
    {
      e.vibrate=(slider.x/15);
    }
       
    float distance = dist(enemies.get(i).x,enemies.get(i).y,head.get(0).x,head.get(0).y);
    if(distance < (head.get(0).diameter + enemies.get(i).diameter)/2)
    {
     enemies.get(i).dead = true;
     score=score+10;
     if(score % 80 == 0)
     {
       droids.add(new Droids(head.get(0)));
     }
     else if(score % 40 == 0)
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
      for(Bot bots : bots)
      {
        if(e.touches(bots))
        {
         e.dead=true;
         score=score+5;
        }
      }
      for(Droids droids : droids)
      {
        if(e.touches(droids))
        {
          e.dead=true;
          score=score+10;
        }
      }
    }
    fill(0);
    stroke(0);
    rect(290,20,153,32,10);
    fill(255,0,0);
    rect(250,10,50,50,10);
    fill(255);
    noStroke();
    rect(255,30,40,10);
    rect(270,15,10,40);
    int i;
    for(i=0; i<14; i++)
    {
      if(head.get(0).diameter<=(i+1))
      {
        fill(255);
      }
      else
      {
       fill(255,0,0); 
      }
      rect(301+(10*i),21,9,30,10);
    }
    if(keys[4])
    {
     // fill(0);
      rect(50,50,width-100,height-100,50);
      
      fill(255);
      textSize(50);
      textAlign(CENTER);
      text("PAUSED:",width/2,height/5);
      textSize(30);
      text("CONTROLS:",width/2,420);
      textSize(20);
      String instructions = "The purpose of the game is to prevent the circles of death from breaching your defenses. Armed with the touch of death, you must hunt these elusive foes down. In game upgrades occur to strengthen your defense when you reach score milestones. Friendly bots moves side to side while droids orbit your location.";
      text(instructions,75,150,350,250);
      String controls = "Use the arrow keys to move. Press spacebar to absorb the health of a friendly droid. Enjoy!";
      text(controls,75,440,350,100);  
    }
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Difficulty",70,70);
    text("Hold p to pause or to find instructions",100,height-5);
    
     if (head.get(0).diameter<1)
      {
        keys[4]=true;
        //change colour to red
        fill(255,0,0);
        rect(0,0,width,height);
        fill(255);
        textAlign(CENTER);
        textSize(50);
        text("GAME OVER",width/2,200);
        textSize(30);
        text("Your Score was: ",width/2,290);
        text(score,width/2,340);
        text("The Highscore is: ",width/2,400);
        text("12655",width/2,450);
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
  if(key==' ')
  {
    if (head.get(0).diameter<15)
    {
      if(droids.size()>0)
      {
       droids.remove(droids.size()-1);
       head.get(0).diameter++;
      }
    }
  }
  if (key =='p')
  {
   //pause
   keys[4]=true;
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
  if (key=='p')
  {
   //pause 
   keys[4]=false;
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
     }
   }
 }
}
