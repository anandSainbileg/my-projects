// Ignacy Sus - 29/03 creating a class scrollbar so that it is possible to scroll through data or queries, basing on the documentation on horizontal scrollbar on processing.org and transforming it into a vertical one
class ScrollBar {
  int sWidth, sHeight;    
  float xpos, ypos;      
  float spos, newspos;    
  float sposMin, sposMax; 
  int loose;              
  boolean over;           
  boolean locked;
  float ratio;

  ScrollBar (float xpos, float ypos, int sWidth, int sHeight, int l) {
    this.sWidth = sWidth;
    this.sHeight = sHeight;
    int heightToWidth = sHeight-sWidth ;
    ratio = (float)sHeight / (float)heightToWidth;
    this.xpos = xpos;
    this.ypos = ypos;
    spos = ypos+sHeight*0.955;
    newspos = spos;
    sposMin = ypos;
    sposMax = ypos + sHeight ;
    loose = l;
  }
// Ignacy Sus - function that update the position of the little box in the scroll bar that allows you to scroll through your data (Based on the documentation on processing.org) 29/03
  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseY-sWidth/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }
// Ignacy Sus - update the position of the box (Based on the documentation on processing.org) 29/03
  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }
// Ignacy Sus check if mouse is over the box that controls the scroll bar (Based on the documentation on processing.org), I change the order and position of x and y because im doing a vertical scroll bar 29/03
  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+sWidth &&
       mouseY > ypos && mouseY < ypos+sHeight) {
      return true;
    } else {
      return false;
    }
  }
  // Ignacy Sus - displaying both the bar and the box with which you can scroll (Based on the documentation on processing.org)29/03
  void display() {
    noStroke();
    fill(204);
    rectMode(CORNER);
    rect(xpos, ypos, sWidth, sHeight,10);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(xpos, spos, sWidth, sWidth,10);
  }
//Ignacy Sus - function that will control how fast we scroll through the data (Based on the documentation on processing.org) 29/03
  float getPos() {
    return spos * ratio;
  }
}
