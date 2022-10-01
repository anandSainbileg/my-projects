//Ignacy Sus 30/03 - A class that will be able to draw the satellite depending on their shape and their diameter
class Satellite {
  int diameter;
  String shape;
  Satellite (int diameter,String shape){
  this.diameter = diameter;
  this.shape = shape;
  }
  
  void draw(){
  noStroke();
  lights();
  translate(232, 192, 0);
  sphere(112);
  
  }  
}
