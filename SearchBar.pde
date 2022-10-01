// Ignacy Sus 24/03/2022 In charge of creating search bar class
class SearchBar extends Widget {
int maxlen; boolean returnInput; boolean resetLabel;
SearchBar(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event,int fontSize, int maxlen){
  super(x,y,width,height,label,widgetColor,widgetFont,event,fontSize,false,noImg);
  this.maxlen=maxlen;
  returnInput = false;
  resetLabel = false;
}

// Ignacy Sus - Create the label using user's input and calling the store() function if user hits enter
// Ignacy Sus - I spent lot of time fixing what I thought was a bug, but in fact I in my label there was always the "Enter" at the end, the solution was simply removing the last element of the string which has to "Enter" 30/03
// Ignacy Sus - the bug was still there so was my another solution was to check if the key is correct in the main program and only allow correct keys to be saved from there
  void append(char s){
    if (resetLabel){ 
      label = "";
      resetLabel = false;
    }
    if (s== SHIFT){
      label = label.substring(0,label.length()-1);
    }
    if(s==BACKSPACE){
    if(!label.equals(""))
      label=label.substring(0,label.length()-1);
    else if (label.equals("")){
      label = "";
    }
     }
     else if (label.length() <maxlen)
      label+=str(s);
     if (s==ENTER){
      returnInput = true;
      label = label.substring(0,label.length()-1);
    }
   }
   // Ignacy Sus 5/04/2022 method to change x and y outside od this class without creating a new object but using the same one
   void changeXY(int x, int y){
     this.x = x;
     this.y = y;
   }
   // Ignacy Sus 5/04/2022 analogical method to change width and height outside od this class without creating a new object but using the same one
   void changeWidthHeight(int wid, int hei){
     this.width = wid;
     this.height = hei;
   }
// Ignacy Sus function that return the label typed by the user if he enters enter
  String store(){
    //println("this is the label in store" +label);
    //println("this is its length" + label.length());
    returnInput = false;
    resetLabel = true;
    return label;
  }
  // Ignacy Sus 6/04 added function in case I just want to return label without resetting the boolean values
  String justLabel(){
    if (label.equalsIgnoreCase("search"))return "";
    else return label;
  }
 
  
}
