/*
Game: Circles of Death
Author: Chris Clarke
Date: 22/10/2024 cos I'm ahead of my time
*/

//function declarations of independence
ArrayList <Snakehead> head;
ArrayList <Droids> droids;
ArrayList <Enemy> enemies;
ArrayList <Bot> bots;
boolean[] keys;
PFont font;
int score=0;
Border border;
Slider slider;

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
  
  //game starts off with a friendly droid- creates a droid object
  droids.add(new Droids(head.get(0)));

}

void draw() {
  background(100);
  boolean b=false;
  
  //display objects
  border.display();
  slider.display();
  
  //ensure head instance stays within the border
  head.get(0).borders(border);
  
  //display score
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Score:",20,30);
  text(score,110,30);
  
  //tried variations of making 60 a variable that decreased as your score increased but the code wouldn't work even though the logic was perfect
  if(score<100)
  {
    //every second if the game is not paused
    if(frameCount % 60 == 0 && keys[4]==false)
    {
      //create instance
      enemies.add(new Enemy());
    }
  }
  else if(score<500)
  {
    if(frameCount % 50 == 0 && keys[4]==false)
    {
      enemies.add(new Enemy());
    }
  }
  else
  {
    if(frameCount % 40 == 0 && keys[4]==false)
    {
      enemies.add(new Enemy());
    }
  }
  
  for(Bot bot : bots)
  {
    //display all bots
    bot.display();
    //if the game isn't paused
    if(keys[4]==false)
    {
      //enable movement
      bot.move();
    }
    //ensure it stays within the border
    bot.borders(border);
  }
  
  //if not paused
  if(keys[4]==false)
  {
    //display the snakehead, postion altered with the parameter keys confined within the border
    head.get(0).display(keys,border);
  }
  
  int k=0;
  for(Droids droids : droids)
  {
    k++;
    //if not paused
    if(keys[4]==false)
    {
      //display all droids, position dependant on head's position
      droids.draw(head.get(0),k);
    }
  }

  //for all enemies
  for(int i = enemies.size() -1; i>= 0; i--)
  {
    //display the enemies
    enemies.get(i).display();
    //move if not paused
    if(keys[4]==false)
    {
      enemies.get(i).run();
    }
    //check if reached southern border or destination
    b=enemies.get(i).borders(border);
    
    //if reached destination
    if(b)
    {
      //head loses a life
      head.get(0).diameter--;
      
      //if on last life
      if (head.get(0).diameter==1)
      {
        //change colour to red
        head.get(0).colour=255;
      }
      //setup removal of enemy
      enemies.get(i).dead=true;
    }
    
    for(Enemy e : enemies)
    {
      //vibrates proportional to slider position
      e.vibrate=(slider.x/15);
    }
    
    //distance between enemy and snakehead
    float distance = dist(enemies.get(i).x,enemies.get(i).y,head.get(0).x,head.get(0).y);
    //if touching or being eaten
    if(distance < (head.get(0).diameter + enemies.get(i).diameter)/2)
    {
     enemies.get(i).dead = true;
     score=score+10;
     
     //add droid per 80 score reached
     if(score % 80 == 0)
     {
       droids.add(new Droids(head.get(0)));
     }
     else if(score % 40 == 0)
     {
       bots.add(new Bot());
     }
    }
    
    //remove enemy if dead
    if(enemies.get(i).dead==true)
    {
      enemies.remove(i);
    }
  }
    
    for(Enemy e : enemies)
    {
      for(Enemy f : enemies)
      {
        //if the objects are touching separate them
        if(e.touches(f))
        {
          //if object e is more towards the left
          if(e.x<f.x)
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
        //if bot touches enemy, kill enemy
        if(e.touches(bots))
        {
         e.dead=true;
         score=score+5;
        }
      }
      for(Droids droids : droids)
      {
        //if droid touches enemy, kill enemy
        if(e.touches(droids))
        {
          e.dead=true;
          score=score+10;
        }
      }
    }
    //create health bar
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
    //create individual bars
    for(i=0; i<14; i++)
    {
      //if head health decreases fill bar white
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
    //if paused display pause menu
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
    
    //display texts
    textAlign(LEFT);
    textSize(15);
    fill(255);
    text("Difficulty",70,70);
    text("Hold p to pause or to find instructions",100,height-5);
    
    //if snakehead is dead display end game menu with score and highscore
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
    //if head is not at max health
    if (head.get(0).diameter<15)
    {
      //if there are droids present
      if(droids.size()>0)
      {
       //remove droid and add health to snakehead
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
 //if within x range
 if (slider.x-slider.r < mouseX && mouseX < slider.x+slider.r)
 {
   //and within y range
   if(32 < mouseY && mouseY < 72)
   {
     //and within slider limits
     if ( mouseX < slider.max && mouseX > slider.min)
     {
       //move slider
       slider.x=mouseX;
     }
   }
 }
}
