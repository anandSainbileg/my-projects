// Ignacy Sus, creating the Screen and all the functions which will contain the possibility to search every object contained in the database 29/03
class SearchScreen extends Screen {
  ScrollBar scrollOne;
  ScrollBar scrollTwo;
  SearchBar searchBar;
  ArrayList <SpaceObject> allObjects;
  PFont font;
  int size;
  boolean switchToDetails, switchToQuery;
  String input, year, newYear;
  int screenNumber;
  int isActive, interval;
  boolean buttonClicked = false;
  int a, b, newI;
  PVector center;
  float angle;
  PImage img;
  PieChart pie;
  PImage background;
  ArrayList <PieChart> allPieCharts; 
  float alterPos;
  ArrayList <Highlight> allHighlights;
  ArrayList <Integer> checkSize;
  PImage earth;
  //ArrayList <Widgets> allButtons;
//  ArrayList screenWidgets;    //Anand Sainbileg made changes to have visible widgets 04/01/2022 (if we remove this new screenWidget 
//then we wont have any invisible widgets on the searchScreen, but the only problem is that the input is displaying behind the search bar)
//Ignacy Sus 06/04/2022 Solved the bug
  Widget goBack, numOfSat, sortMass, sortLaunchDate, sortDiameter, sortMassDes, sortLaunchDateDes, sortDiameterDes, sortName, sortNameDes;
  SpaceObject detailedObject;
  ArrayList <Widget> allButtons;
  String listDisplayed; //Can be normal, sortedMass
  SearchScreen(color screenColor,ArrayList <SpaceObject> allObjects, PFont font, PImage img){
    super(screenColor); this.allObjects = allObjects;
    scrollOne = new ScrollBar(0,(0.2*height),(int)(0.015*width),(int)(0.8*height),16);
    searchBar = new SearchBar((int)(0.35*width), (int)(0.05*height), (int)(width*0.30),(int)(height*0.03), "Search", color(255),font2, EVENT_SEARCH,(((int)(height*0.03))/2),14);
    this.font = font;
    this.img = img;
    size = allObjects.size();
    detailedObject = null;
    goBack = new Widget(BOX_X,BOX_Y, BOX_WIDTH_B, BOX_HEIGHT_B, "Back", color(255), font, 14, NORMAL_TEXT_SIZE,false,noImg);
    input = "";
    numOfSat = new Widget((int) (width*0.7),(int)(height*0.83), (int)(0.4*textWidth("Launched satellites per country")), BOX_HEIGHT, "Launched satellites per country", SORT_COLOR, font, 14, 14,false,noImg);
    sortMass = new Widget((int)(0.7*width), (int)(0.30*height), (int)(width*0.08),(int)(height*0.03), "Mass", SORT_COLOR,font2, EVENT_SORT_MASS,(((int)(height*0.03))/2),false,noImg);
    sortLaunchDate = new Widget((int)(0.7*width), (int)(0.35*height), (int)(width*0.08),(int)(height*0.03), "Launch Date", SORT_COLOR,font2, EVENT_SORT_LAUNCH,(((int)(height*0.03))/2),false,noImg);
    sortDiameter = new Widget((int)(0.7*width), (int)(0.40*height), (int)(width*0.08),(int)(height*0.03), "Diameter", SORT_COLOR,font2, EVENT_SORT_DIAMETER,(((int)(height*0.03))/2),false,noImg);
    sortMassDes = new Widget((int)(0.7*width), (int)(0.58*height), (int)(width*0.08),(int)(height*0.03), "Mass", SORT_COLOR,font2, EVENT_SORT_MASS_DESCEND,(((int)(height*0.03))/2),false,noImg);
    sortLaunchDateDes = new Widget((int)(0.7*width), (int)(0.63*height), (int)(width*0.08),(int)(height*0.03), "Launch Date", SORT_COLOR,font2, EVENT_SORT_LAUNCH_DESCEND,(((int)(height*0.03))/2),false,noImg);
    sortDiameterDes = new Widget((int)(0.7*width), (int)(0.68*height), (int)(width*0.08),(int)(height*0.03), "Diameter", SORT_COLOR,font2, EVENT_SORT_DIAMETER_DESCEND,(((int)(height*0.03))/2),false,noImg);
    sortName = new Widget((int)(0.7*width), (int)(0.45*height), (int)(width*0.08),(int)(height*0.03), "Name", SORT_COLOR,font2, EVENT_SORT_NAME,(((int)(height*0.03))/2),false,noImg);
    sortNameDes =new Widget((int)(0.7*width), (int)(0.73*height), (int)(width*0.08),(int)(height*0.03), "Name", SORT_COLOR,font2, EVENT_SORT_NAME_DESCEND,(((int)(height*0.03))/2),false,noImg);
    add(sortMass);
    add(sortLaunchDate);
    add(sortDiameter);
    add(sortName);
    add(sortNameDes);
    add(sortLaunchDateDes);
    add(sortDiameterDes);
    add(sortMassDes);
    add(searchBar);
    add(numOfSat);
    screenNumber = 0;
    allButtons = new ArrayList <Widget> ();
    isActive = 0;
    switchToDetails = false;
    a= 40; b = 40;
    center = new PVector(width*3/4, height/2);
    PVector point = new PVector(width/2, height*3/4);
    float deltaX = center.x - point.x;
    float deltaY = center.y - point.y;
    angle = atan2(deltaX, deltaY);
    allPieCharts= null;
    switchToQuery = false;
    year = "1964";
    newYear = "";
    pie = new PieChart(allObjects,year,"Country",font, "Number of launched satellites per country");
    interval = 0;
    allHighlights = new ArrayList <Highlight> ();
    for (int i=0;i<size;i++){
      allHighlights.add(new Highlight(TEXT_X,(int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+i*SPACE_IN_BETWEEN)), BOX_WIDTH, BOX_HEIGHT, allObjects.get(i).name, color(255), font, 1000, 14,allObjects.get(i).LDate,allObjects.get(i).owner, str(allObjects.get(i).satcat),str(allObjects.get(i).mass),str(allObjects.get(i).diameter)));
    }
  }
  
  // Ignacy Sus this is what is supposed to be displayed until the user choose an option ( so all the items listed, possibility to scroll, possible to type in what you search for)
 // this function displays the visual aspect of it 29/03
  void display(){
  searchBar.changeXY((int)(0.35*width), (int)(0.05*height));
  searchBar.changeWidthHeight((int)(width*0.30),(int)(height*0.03));
  searchBar.updateLabelPos();
  screenNumber = 0;
  background(COLOR_OF_SEARCH_SCREEN);
  textSize(14);
  textFont(font);
  searchBar.draw();
  scrollOne.display();
  scrollOne.update();
  drawTitles();
  numOfSat.draw();
  fill(0);
  
  //1/04 Ignacy Sus, transforming my older code which allowed to scroll through the data but you had to search through the search bar
  // now you can press directly on the name while scrolling ( as each of them is a widget)
  interval = 0;
      for ( int i = 0; i <size; i++){
        alterPos = scrollOne.getPos()-height/DIVIDE_BY_HALF;
        if(updateTable(searchBar.justLabel(), allObjects.get(i))&&allObjects.get(i).satcat!=0){
        Highlight aButton = new Highlight(TEXT_X,(int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+interval*SPACE_IN_BETWEEN)), BOX_WIDTH, BOX_HEIGHT, allObjects.get(i).name, color(255), font, 1000, 14,allObjects.get(i).LDate,allObjects.get(i).owner, str(allObjects.get(i).satcat),str(allObjects.get(i).mass),str(allObjects.get(i).diameter));
        //Ignacy Sus 6/04 optimise the efficience it only draws what fits on the screen ( before it drew everything all the time)
          if ((int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+interval*SPACE_IN_BETWEEN))>0.2*height&&
          (int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+interval*SPACE_IN_BETWEEN))<height){
           aButton = new Highlight(TEXT_X,(int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+interval*SPACE_IN_BETWEEN)), BOX_WIDTH, BOX_HEIGHT, allObjects.get(i).name, color(255), font, 1000, 14,allObjects.get(i).LDate,allObjects.get(i).owner, str(allObjects.get(i).satcat),str(allObjects.get(i).mass),str(allObjects.get(i).diameter));
           aButton.draw();
           if (overAll(aButton.posLabel(1), (int)(height/DIVIDE_BY_HALF-(CORRECT_DISPLAY*displayHeight*size)/DIVIDE_BY_HALF+(alterPos*SCROLL_SPEED+interval*SPACE_IN_BETWEEN)),
           aButton.getLabel(1), aButton.posLabel(2), aButton.getLabel(2), aButton.posLabel(3), aButton.getLabel(3), aButton.posLabel(4), aButton.getLabel(4),aButton.posLabel(5),
           aButton.getLabel(5),aButton.posLabel(6),aButton.getLabel(6))){
              aButton.highlight();
              aButton.draw();
              if (mousePressed&&isActive>=10){
                detailedObject = allObjects.get(i);
                switchToDetails=true;
              }  
             }
           }
        interval++;
        }
          
        
       
        }
  
   if (over((int) (width*0.7),(int)(height*0.83),"Launched satellites per country") && mousePressed){
        switchToQuery = true;
      }
  if (isActive <=10){
    isActive++;
  }
  sortMass.draw();
  sortLaunchDate.draw();
  sortDiameter.draw();
  sortName.draw();
  sortMassDes.draw();
  sortLaunchDateDes.draw();
  sortDiameterDes.draw();
  sortNameDes.draw();
 
  }
  //@Override Ignacy Sus - im overriding the draw method from the superclass screen
  void draw(){
      println(screenNumber);
      textSize(14);
    if (switchToQuery){
      showQueries();
    }
    else if (switchToDetails){
      showDetails();
    }
    else {
      display();
      if (searchBar.returnInput){
        switchToDetails=checkInput();
      }
    }
    //Ignacy Sus 1/04 Added this loop to show the global widgets that interat with other interfaces, for now this works with the home button (only when im on the first page of my searchScreen) else  I want my "go back" button to work that goes one page back
    for(int i = 0; i<screenWidgets.size(); i++){
      Widget aWidget = (Widget)screenWidgets.get(i);
      if (aWidget.label.equalsIgnoreCase("Home")&&screenNumber==0){
        aWidget.draw();
      }
}
    
    
  }
  // Ignacy Sus 6/04 function that visualize the queries the user presesed ( for now it shows the number of satellites launcher per countries)
  void showQueries (){
    searchBar.changeXY((int)(0.05*width),(int)(0.20*height));
    searchBar.changeWidthHeight((int)(width*0.15), (int)(height*0.03));
    searchBar.updateLabelPos();
    screenNumber=2;
    background(SHOW_QUERY_COLOR);
    searchBar.draw();
    text("Input a year between 1957-2022:",(int)(0.054*width),(int)(0.19*height));
    goBack.draw();
    if (searchBar.returnInput){
      newYear = searchBar.store();
      if (isDateValid(newYear)){
        pie = new PieChart(allObjects,newYear,"Country",font, "Number of launched satellites per country");
        year = newYear;
      }
    }
    pie.draw();
    textSize(30);
    text ("Current year: " + year,(int)(0.054*width),(int)(0.45*height));
    textSize(14);
    if (over() && mousePressed){
      switchToQuery = false;
    }
  }
  // Ignacy Sus 6/04 function the check if the date is correct ( first used in Piechart class by me)
  boolean isDateValid(String newDate){
    for (SpaceObject object: allObjects){
            String date = "";
            if (object.LDate.length()>=4){
               for ( int i =0; i<4;i++){
                date +=str(object.LDate.charAt(i));
              }
              if (date.equals(newDate)){
                return true;
              }
            }
    }  
      return false;
    
  }
  // Ignacy Sus - checking if the input in the search bar correspond to an attribute from our data
  boolean checkInput () {
      input = searchBar.store();
      for (SpaceObject object : allObjects){
        if (Integer.toString(object.satcat).equalsIgnoreCase(input)||object.name.equalsIgnoreCase(input)||object.LDate.equalsIgnoreCase(input)){
          detailedObject=object;
          return true;
        }
      }
      return false;
  }
  // Ignacy Sus - function that shows all specific details about the object that was chosen by the user 30/03
  void showDetails (){
    screenNumber=1;
    background(SHOW_DETAILS_COLOR);
    fill(0);
    textSize(40);
    text(detailedObject.name,0.40*width,0.1*height);
    textSize(15);
    text("Name: "+detailedObject.name,0.05*width,0.3*height);
    text("Launch date: "+detailedObject.LDate,0.05*width,0.35*height);
    text("Descent date: "+detailedObject.DDate,0.05*width,0.40*height);
    text("Current status: " + findStatusName(),0.05*width,0.45*height);
    text("Country owner: " + findCountryName(), 0.05*width, 0.50*height);
    text ("Mass: " + (detailedObject.mass==0?"Unkown":detailedObject.mass+" kg"), 0.05*width, 0.55*height);
    text ( "Diameter: " + (detailedObject.diameter==0?"Unkown":detailedObject.diameter+" km"), 0.05*width, 0.60*height);
    text("Apogee: " + detailedObject.apogee + " km", 0.05*width, 0.65*height);
    text("Perigee: " + detailedObject.perigee + " km", 0.05*width, 0.70*height);
    drawOrbits();
    goBack.draw();
    drawSatellite(transformedPerigee(detailedObject.perigee),transformedApogee(detailedObject.apogee));
    if (over() && mousePressed){
      switchToDetails = false;
    }
  }
  //Ignacy Sus method to return the full status of the object ( basing on the shortcut in the file),
  //I don't know if switch is really efficient but i think the code is more clear this way and easier to redo if there is a mistake 30/03
  String findStatusName(){
    switch (detailedObject.status){
      case "O": return "In orbit";
      case "AO": return "Attached in Orbit";
      case  "AO IN": return "Attached in Orbit";
      case "UDK": return "Undocked";
      case "REL": return "Released";
      case "DEP": return "Deployed";
      case "LO": return "Liftoff";
      case "ALO": return "Attached at liftoff";
      case "E": return "Exploded";
      case "N": return "Renamed";
      case "LEASE": return "Lease";
      case "R": return "Reentered";
      case "D": return "Deorbited";
      case "L": return "Landed";
      case "AR": return "Reentered attached";
      case "AR IN": return "Reentered inside";
      case "AL": return "Landed attached";
      case "AL IN": return "Landed inside";
      case "TX": return "Transmission ended";
      case "F": return "Failed";
      case "AF": return "Failed attached";
      case "DSO": return "Deep space";
      case "DSA": return "Deep space attached";
      case "DSA IN": return "Deep space inside";
      case "REFLT": return "Reflight";
      case "DK": return "Docked";
      case "GRP": return "Grappled";
      case "ATT": return "Attached";
      case "TFR": return "Transfer";
      case "TFR E": return "Transfer external";
      case "RET": return "Retrieved";
      case "C": return "Collided";
      case "EVA": return "Spacewalk";
      case "EO": return "Escape";
      case "EAO": return "Escape attached";
      default: return "Unkown";
    }
    
  }
  //Ignacy Sus - analogical method to the one before it, this time i'm returning the full country/state name
  String findCountryName(){
    switch(detailedObject.state){
      case "US": return "United States";
      case "SU": return "Soviet Union";
      case "CA": return "Canada";
      case "I": return "Italy";
      default: return "Unkown";
    }
  }
  //Ignacy Sus 30/03- I wanted to find the difference between dates if it is possible ( so how long was the journey), but for now the dates are saved as strings so I will leave it for later
 // 12/04 Finally I only checked if the date is Valid  with the function somewhere above
  SearchBar getSearchBar(){
     return searchBar;
   }
  // Ignacy Sus 30/03 function to see if the button "go back" is pressed
  boolean over (){
    if (mouseX > BOX_X && mouseX < BOX_X+BOX_WIDTH_B &&
      mouseY > BOX_Y && mouseY < BOX_Y+BOX_HEIGHT_B) {
      return true;
    } else {
      return false;
    }
  }
  
  // Ignacy Sus 1/04 oveloading the function when I need parameters.
  boolean over (int x, int y,String text){
    if (mouseX > x && mouseX < x+textWidth(text) &&
      mouseY > y && mouseY < y+TEXT_SIZE_14*1.2) {
      return true;
    } else {
      return false;
    }
  }
  // Ignacy Sus - fixing a bug when the button was counted as being "pressed" when it shouldnt have been available to be pressed.
  void setIsActive(int number){
    isActive = number;
  }
  // Ignacy Sus function to draw the orbits
  void drawOrbits(){
    noFill();
    stroke(0);
    ellipse(width-width/4, height/2, transformedPerigee(detailedObject.perigee)*2,transformedApogee(detailedObject.apogee)*2);
}
// Ignacy Sus function to draw satellites
  void drawSatellite (float perigee, float apogee){
    fill(0,51,0);
    imageMode(CENTER);
    image(img, center.x,center.y);
    fill(160,160,160);
    imageMode(CORNER);
    float x = center.x + cos(angle)*perigee;
    float y = center.y + sin(angle)*apogee;
    stroke(0);
     ellipse(x, y, 10, 10);
     angle += PI/240;
  }
// Ignacy Sus 2/04 Function to find the max apogee to then draw the orbits in a correct ratio ( so the max apogee will have the max value possible on the screen and the other will be transformed with the ratio)
  float findMaxApogee(){
    float maxAp = -1;
    for (SpaceObject sat : allObjects){
      if (sat.apogee > maxAp&&sat.apogee<Float.MAX_VALUE){
        maxAp = sat.apogee;
      }
    }
    return  maxAp;
  }
  // Ignacy Sus 2/04 analogical method to the one before it, in this case its ther perigee
  float findMaxPerigee(){
    float maxPe = -1;
    for (SpaceObject sat : allObjects){
      if (sat.perigee > maxPe&&sat.perigee<Float.MAX_VALUE){
        maxPe = sat.perigee;
      }
    }
    return (int) maxPe;
  }
  //Ignacy Sus 2/04 Function that transform the apogee value to the possible value
  // Ignacy Sus 10/04 scaled down if the orbits would go over the screen !
  float transformedApogee (float apogee){
    //println("AM I HERE");
    if (((EARTH_RADIUS_SCALED*(abs(apogee))/EARTH_RADIUS)+EARTH_RADIUS_SCALED)>height*0.96/2){
      //println("PLS HERE");
      return (height*0.96)/2;
    }
    else return (EARTH_RADIUS_SCALED*(abs(apogee))/EARTH_RADIUS)+EARTH_RADIUS_SCALED;
    
  }
  // Ignacy Sus 2/04 analogical function but with perigee
  // Ignacy Sus 10/04 scaled down if the orbits would go over the screen !
  float transformedPerigee (float perigee){
    if ((EARTH_RADIUS_SCALED*(abs(perigee))/EARTH_RADIUS)+EARTH_RADIUS_SCALED>(displayWidth/4)){
      return (displayWidth/4);
    }
    else return (EARTH_RADIUS_SCALED*(abs(perigee))/EARTH_RADIUS)+EARTH_RADIUS_SCALED;
   
  }
  // Ignacy Sus 6/04 draw the titles of the tables
  void drawTitles(){
    fill(255);
    noStroke();
    textSize(14);
    text("SATCAT",(int)(displayWidth*0.03), 0.18*height);
    text("Name", (int)(displayWidth*0.07), 0.18*height);
    text("Launch Date", (int)(displayWidth*0.23), 0.18*height);
    text("Owner", (int) (displayWidth*0.33), 0.18*height);
    text("Mass [kg]", (int) (displayWidth*0.41), 0.18*height);
    text("Diameter [km]", (int) (displayWidth*0.47), 0.18*height);
    stroke(15);
    textSize(25);
    text ("Sort in Ascending Order", (int) (displayWidth*0.68), 0.250*height);
    text ("Sort in Descending Order", (int) (displayWidth*0.68), 0.550*height);
    text ("Visualisation", (int) (displayWidth*0.68), 0.80*height);
  }
  // Ignacy Sus 6/04 function to see if someone goes over a name/date/owner etc. in the table
  // Ignacy Sus 12/04 updated to have more parameters
  boolean overAll(int x, int y, String a, int x1,  String b, int x2,  String c, int x3,  String d, int x4, String e, int x5, String f){
    if (over (x, y,a)||over (x1,  y,  b)||over ( x2,  y,  c)||over  (x3, y, d)||over(x4,y,e)||over(x5,y,f)){
       return true;
    }
   return false;
  }
  //Ignacy Sus 6/04 update the table LIVE
  // Ignacy Sus 12/04 now it can also handle integers (I change them to string and then compare with the currentText)
  boolean updateTable(String currentText, SpaceObject object){
    if (currentText.equals("")||object.name.contains(currentText)||object.LDate.contains(currentText)||object.owner.contains(currentText)
    ||Integer.toString((int)object.mass).contains(currentText)||Integer.toString((int)object.diameter).contains(currentText)||
    Integer.toString((int)object.satcat).contains(currentText)){
      return true;
    }
    
    return false;
  }
    //Ignacy Sus 11/04 add option to change backgrounds
    void setBackground(PImage background){
      this.background = background;
    }

}
