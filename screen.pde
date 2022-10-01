class Screen {    //Anand Sainbileg created screen class and implemented all the methods and variables
boolean isText = false;boolean isText2 = false;boolean isText3 = false;boolean isText4 = false;boolean isText5 = false;boolean isText6 = false;
int text1X, text1Y, text2X, text2Y,text3X, text3Y,text4X, text4Y,text5X, text5Y,text6X, text6Y;
color col, col2,col3,col4,col5,col6;
PFont myFont, font1,font2,font3,font4,font5, font6;
String text,text2,text3,text4,text5,text6;
ArrayList screenWidgets; color screenColor; ArrayList screenImages; 
ArrayList starList;
PImage defaultBackground, background;
Screen(color screenColor){ 
screenWidgets=new ArrayList(); 
screenImages = new ArrayList();      //Anand Sainbileg added methods and ArrayList for image class 3/30/2022
this.screenColor=screenColor;
myFont = loadFont("AcademyEngravedLetPlain-30.vlw");
defaultBackground = loadImage("free-space-background-02.jpg");
background = defaultBackground;
}
void add(Widget w){
screenWidgets.add(w); 
}
void remove(Widget w)
{
  screenWidgets.remove(w);
}

boolean contains(Widget w)//Gerard Moylan 6/4/22 used to check whether or not to add the swap widget back for the charts after it is removed.
{
  for (int i = 0; i < screenWidgets.size(); i++)
  {
    if (screenWidgets.get(i) == w)
    {
      return true;
    }
  }
  return false;
}

void addImage(Images image){
screenImages.add(image);
}
void changeBackground(PImage Img){         // Tanuj Sood creating method to change background of differnt screens
  background=Img;
}

void draw(){
  image(background,1,1);
  //background(background);
//background(screenColor);
for(int i = 0; i<screenWidgets.size(); i++){
Widget aWidget = (Widget)screenWidgets.get(i);
aWidget.draw(); 
  }
  
for(int a = 0; a<screenImages.size(); a++){
Images image = (Images)screenImages.get(a);
image.draw();
  }
  
  if (isText){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font1);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col);
  text(text, text1X,text1Y);
  }
  if (isText2){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font2);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col2);
  text(text2, text2X,text2Y);
  }
  if (isText3){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font3);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col3);
  text(text3, text3X,text3Y);
  }
  if (isText4){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font4);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col4);
  text(text4, text4X,text4Y);
  }
  if (isText5){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font5);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col5);
  text(text5, text5X,text5Y);
  }
  if (isText6){                                  //  Tanuj Sood, 30/03/22, implementing addScreenText method
  textFont(font6);  
  textSize(NORMAL_TEXT_SIZE+15);
  fill(col6);
  text(text6, text6X,text6Y);
  }
 }
void addScreenText(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText=true;
  text1X=x;
  text1Y=y;
  text=label;
  col=colour;
  font1=someFont;
}
int getEvent(int mx, int my){
for(int i = 0; i<screenWidgets.size(); i++){ Widget aWidget = (Widget) screenWidgets.get(i); int event = aWidget.getEvent(mouseX,mouseY); if(event != EVENT_NULL){
return event; }
}
return EVENT_NULL; 
  }


// TEMP SOLUTION FOR MULTIPLE TEXTS

void addScreenText2(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText2=true;
  text2X=x;
  text2Y=y;
  text2=label;
  col2=colour;
  font2=someFont;
}

void addScreenText3(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText3=true;
  text3X=x;
  text3Y=y;
  text3=label;
  col3=colour;
  font3=someFont;
}

void addScreenText4(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText4=true;
  text4X=x;
  text4Y=y;
  text4=label;
  col4=colour;
  font4=someFont;
}

void addScreenText5(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText5=true;
  text5X=x;
  text5Y=y;
  text5=label;
  col5=colour;
  font5=someFont;
}


void addScreenText6(int x, int y, String label, color colour, PFont someFont){   //  Tanuj Sood, 30/03/22, created addScreenText method to add some text to a screen( not perfect, improve to take in multiple texts)

  isText6=true;
  text6X=x;
  text6Y=y;
  text6=label;
  col6=colour;
  font6=someFont;
}

}
