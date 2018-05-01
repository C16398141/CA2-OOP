class Body {
  
  float x,y,diameter,speed;
  boolean bot;
 
  boolean borders(Border border)
   {
     float distance = x-border.x;
     if(distance <= (diameter/2))
     {
       if(bot)
       {
         speed=speed*-1;
       }
       else
       {
         x=x+(diameter*speed/4);
       }
     }
     distance = border.x+border.thickness-x;
     if(distance <= (diameter/2))
     {
       if(bot)
       {
         speed=speed*-1;
       }
       else
       {
         x=x-(diameter*speed/4);
       }
     }
     if(border.y+border.depth<=y)
     {
       return true;
     }
     else return false;
   }
   
}
