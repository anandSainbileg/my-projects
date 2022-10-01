//Ignacy Sus 1/04/2022 Creating a highlight class that will highlight when the user wants to press on a text 
class Highlight extends Widget {
  String secLabel, thirdLabel, fourthLabel, fifthLabel, sixthLabel;
  int posLab1, posLab2, posLab3, posLab4, posLab5, posLab6;
  Highlight (int x,int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, int fontSize, String secLabel, String thirdLabel, String fourthLabel, String fifthLabel, String sixthLabel) {
    super(x,y,width,height,label,widgetColor,widgetFont,event,fontSize,false,noImg);
    this.secLabel=secLabel;
    this.thirdLabel = thirdLabel;
    this.fourthLabel = fourthLabel;
    this.fifthLabel = fifthLabel;
    this.sixthLabel = sixthLabel;
    posLab4 = (int)(displayWidth*0.03);
    posLab1 = (int)(displayWidth*0.06);
    posLab2 = (int)(displayWidth*0.23);
    posLab3 = (int) (displayWidth*0.33);
    posLab5 = (int) (displayWidth*0.42);
    posLab6 = (int) (displayWidth*0.48);
    this.labelColor = (150);
  }
  //@ Overriding the method draw
  //Ignacy Sus 6/04 adding more labels to be shown on the screen
  void draw(){
    fill(labelColor);
    textSize(fontSize);
    //textFont(widgetFont);
    text(fourthLabel,posLab4, y+height-10);
    text(label, posLab1, y+height-10);
    text(secLabel, posLab2, y+height-10);
    text(thirdLabel, posLab3, y+height-10);
    text(fifthLabel, posLab5, y+height-10);
    text(sixthLabel, posLab6, y+height-10);
    
   
  }
  //Ignacy Sus drawing the highlight line 
  // Ignacy Sus 6/04  now it highlights the font instead of the (ugly) line
  void highlight(){
    this.labelColor = color(128,0,128);
    
  }
  // Ignacy Sus 6/04 get position of each label
  int posLabel(int i){
    switch (i){
      case 1: return posLab4;
      case 2: return posLab1;
      case 3: return posLab2;
      case 4: return posLab3;
      case 5: return posLab5;
      case 6: return posLab6;
      default: return 0;
    }
  }
  //Ignacy Sus get the string of each label
  String getLabel(int i){
    switch (i){
      case 1: return fourthLabel;
      case 2: return label;
      case 3: return secLabel;
      case 4: return thirdLabel;
      case 5: return fifthLabel;
      case 6: return sixthLabel;
      default: return "";
    }
  }
 
}
