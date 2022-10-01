// Ignacy Sus 05/04 Creating a piechart that can be interactive with the user for the queries
class PieChart {
  int sort, x, y, sum;
  ArrayList <SpaceObject> allObjects;
  String sortBy, typeOnGraph, title;
  ArrayList <String> yLegends;
  ArrayList <SpaceObject> sortedObjects;
  ArrayList <Integer> store;
  ArrayList <Float> storedAngles;
  ArrayList <IntList> colors;
  PFont font; float startFrom;
  PieChart(ArrayList <SpaceObject> allObjects, String sortBy, String typeOnGraph, PFont font, String title){
    this.allObjects = allObjects;
    this.sortBy = sortBy;
    sortedObjects = new ArrayList <SpaceObject> ();
    this.typeOnGraph= typeOnGraph;
    yLegends = new ArrayList <String> ();
    store = new ArrayList <Integer> ();
    storedAngles = new ArrayList <Float> ();
    colors = new ArrayList <IntList> ();
    this.font = font;
    this.title = title;
    startFrom = 0.4;
    sum = 0;
  }
  // Ignacy Sus 5/04/2022 Changing the sortType to int format if it's date ( as the date is initially in string format)
  int sortToInt(){
    try{
            String date = "";
            for ( int i =0; i<4;i++){
              date +=sortBy.charAt(i);
            }
            int number = Integer.parseInt(date);
            return number;
        }
   catch (NumberFormatException e){
            println(e);
        }
        return 0;
  }
  //Ignacy Sus 5/04/2022 Changing from string to int the date of an object
  int dateToInt (SpaceObject object){
    try{  
            
            String date = "";
            for ( int i =0; i<4;i++){
              date +=str(object.LDate.charAt(i));
            }
            int number = Integer.parseInt(date);
            return number;
        }
   catch (NumberFormatException e){
            println(e);
        }
        return FALSE_VALUE ;
  }
  // Ignacy Sus 5/04 creating an arrayList of only the object i want to consider ( for now it's only the objects with a specific year, it's easier later to work with less values when going through loops)
  void sortByType (){
    for (SpaceObject object : allObjects){
      if(object.LDate.length()>=4){
        if (dateToInt (object)==sortToInt()&&!sortedObjects.contains(object)){
         sortedObjects.add(object);
        }
      }
       
    }
  }
 
  
  // Ignacy Sus 5/04 this function is useful as it trasnforms the total numbers of f.e. satellites of all the countries and change the proprotion so if a value would be equal to sum
  // the it would rescaled to 360 -> as 360 (2pi) in a circle is the whole space
  float scaleAngle (int sum, int value){
    return (value*2*PI/sum);
  }
    //Ignacy Sus 5/04 Counting the data we want to obtain. In this case f.e. I'm going through the sorted objects and each time there is a new object i check if there was an object
  // from this country before. If not I add to a StringArralist the name of its country AND add a value 1 to an integer arrayList -> this means that there is one satellite of that country
  // If a county is already in the list I change the value of f.e. 1 to 1+1 which would be 2 in this case.
  void updateDataForChart(){
    if (typeOnGraph.equalsIgnoreCase("country")){
      for (SpaceObject object : sortedObjects){
        if (!yLegends.contains(object.state)){
          yLegends.add(object.state);
          store.add(1);
        }
        else {
          int value = store.get(yLegends.indexOf(object.state));
          value +=1;
          store.set(yLegends.indexOf(object.state),value);
        }
      }
    }
  }
  // Ignacy Sus 7/04/2022 function to calculate the percentages!
  int calculateSum(){
    sum = 0;
    for( Integer value : store){
      sum +=value;
    }
    return sum;
  }
  // Ignacy Sus 5/04 Scaling the frequencies of a specific event in the store arrayList  to angle proportion (so max is 360) and adding the trasnformed  value to a new arraylist
  void dataToAngle (){
    int sum = 0;
    for (Integer value : store){
      sum += value;
    }
    for (Integer value : store){
     storedAngles.add(scaleAngle(sum,value));
    }
  }
//Ignacy Sus 5/04 Functino to build the chart. I call my previous functions and draw the pieChart using the arc() function I also call here the function assignColor which is used to assign color to each differenet country
  void buildPieChart (){
    float latestAngle = 0;
    if (storedAngles.size()==0){
      sortByType ();
      updateDataForChart();
      dataToAngle();
    }
    
    for (int i = 0; i < storedAngles.size(); i++) {
      fill(assignColor(i));
      stroke(0);
      arc(width*0.6, height/2, width*0.35, width*0.35, latestAngle, latestAngle+storedAngles.get(i),PIE);
      latestAngle += storedAngles.get(i);
   }
  }
  //Ignacy Sus function to change year
  void changeYear (String year){
    if (year.length() ==4){
      this.sortBy = year;
    }
    
  }
  // Ignacy Sus 5/04 assigning color based on the type ( f.e. country)
  color assignColor(int i){
    Random generator = new Random(i);
    int num = generator.nextInt(255);
    int num2 = generator.nextInt(255);
    int num3 = generator.nextInt(255);
    return color(num, num2, num3);
  }
  
  // Ignacy Sus shows the legend ( so the names and data on the left)
  // Ignacy Sus 6/04 updated the code so if the size of the countries is immense the display changes so it doesnt overflow
  // Ignacy Sus 7/04 updated the code to see the exact percentages
  void showLegend(){
    textFont(font);
    textSize(14);
    for ( int i = 0; i<yLegends.size();i++){
      fill(assignColor(i));
      stroke(0);
       
        if (yLegends.size()>40){
          startFrom = 0.0;
        }
        else if (yLegends.size()>30){
          startFrom=0.2;
        }
        else if (yLegends.size()>20){
          startFrom=0.3;
        }
        else if (yLegends.size()>10){
          startFrom=0.35;
        }
        else startFrom = 0.4;
        float percentage = Math.round((store.get(i)*100.0)/calculateSum()*100.0)/100.0;
        text(yLegends.get(i)+": "+store.get(i)+(store.get(i)>1?" satellites":" satellite")+ " ("+(percentage) + "%)",width*0.8,height*startFrom+i*20);
        rectMode(CENTER);
        rect(width*0.79,height*(startFrom-0.01)+i*20,width*0.01,width*0.01);
        rectMode(CORNER);
      }
    stroke(0);
    textSize(30);
    fill(TITLE_PIE_CHART_COLOR);
    text (title, width *0.3, height*0.05);
  
    }
    
  // Ignacy Sus 5/04 Extending the names from their abbreviation 
  // Ignacy Sus 6/04 updated again to have more full names (now 50k database)
  void extendNames(){
    for (int i = 0; i < yLegends.size() ; i++){
      switch (yLegends.get(i)){
        case "US": yLegends.set(i,"United States");
          break;
        case "SU": yLegends.set(i,"Soviet Union");
          break;
        case "I": yLegends.set(i, "Italy");
          break;
        case "UK": yLegends.set(i, "United Kingdom");
          break;
        case "CA": yLegends.set(i, "Canada");
          break;
        case "AO": yLegends.set(i,"Angola");
          break;
        case "AR": yLegends.set(i,"Argentine");
          break;
        case "AT": yLegends.set(i,"Austria");
          break;
        case "AU": yLegends.set(i,"Australia");
          break;
        case "CN": yLegends.set(i,"China");
          break;
        default:
      }
    }
  }
  // Ignacy Sus 5/04 draw the piechart and legend
  void draw(){
    noStroke();
    buildPieChart();
    extendNames();
    showLegend();
  }
  
}
