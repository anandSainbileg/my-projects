class Images {            // Anand Sainbileg added and implemented image class to import images 3/30/2022
PImage currentImage;
int x;
int y;
int width;
int height;
Images(int x, int y, int width, int height){
this.x = x;
this.y = y;
this.width = width;
this.height = height;
  }
void getImageEvent(int event){
  if(event == 109){
    currentImage = kalamSat;
  }
 }
 void draw(){
 image(currentImage, x, y, width, height);
 }
}
