class Body {
  
  float x,y,diameter,speed,colour;
  boolean bot;
 
  boolean borders(Border border)
   {
     //distance of object from border
     float distance = x-border.x;
     //if touching
     if(distance <= (diameter/2))
     {
       //if a bot change direction
       if(bot)
       {
         speed=speed*-1;
       }
       else
       {
         //move to the right proportional to diameter and speed
         x=x+(diameter*speed/4);
       }
     }
     //distance of object from border
     distance = border.x+border.thickness-x;
     //if touching
     if(distance <= (diameter/2))
     {
       //if a bot change direction
       if(bot)
       {
         speed=speed*-1;
       }
       else
       {
         //move to the right proportional to diameter and speed
         x=x-(diameter*speed/4);
       }
     }
     if(border.y+border.depth<=y)
     {
       return true;
     }
     else return false;
   }
   
   //if the objects touch return true
   boolean touches(Body enemies)
   {
     float distance = dist(x,y,enemies.x,enemies.y);
     if(distance < (diameter + enemies.diameter)/2)
     {
     return true;
     }
     else
     {
       return false;
     }
   }
   
   
}
