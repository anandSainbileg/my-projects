
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Collections;
import java.util.*;
import java.text.*;
import grafica.*;
PImage spaceImage, roverImg, neil, noImg, chartImg, searchBar, queryImg, sputnik, isc, kalamSat, parker, searchingpic, chartPic, gallerypic, querypic, dataPic;
PImage earth;
PImage greyBackground;
PImage earthBackground;
ArrayList<SpaceObject> mySpaceObject; // Tanuj Sood, creating ArrayList to store all the instances of class SpaceObjects, 11:25am 21/03/2022
ArrayList widgetList;
ArrayList<String> shipStates;
ArrayList<Screen> screenList;        // Anand Sainbileg 04/01/2022 made screenList to save previous or next screen 
ArrayList<Chart> chartList;
ArrayList<Float> launchYearList;
ArrayList<Float> lengthArrayList = new ArrayList();
ArrayList<String> listOfUniqueStates;
ArrayList<Float> massArrayList = new ArrayList();
ArrayList<Float> diameterArrayList = new ArrayList();
ArrayList<Float> perigeeArrayList = new ArrayList();
ArrayList<Float> apogeeArrayList = new ArrayList();
ArrayList<Float> incArrayList = new ArrayList();
ArrayList<Float> emptyList = new ArrayList(0);
ArrayList<Float> selectedParameter;
ArrayList<Float> selectedParameter2;
ArrayList<Float> tmpAL;
float selectedParameterMaxValue;
float selectedParameterMaxValue2;

ArrayList<Widget> scatterPlotWidgets = new ArrayList();
ArrayList<Widget> scatterPlotWidgets2 = new ArrayList();
StringHistogram statesHist; 
FloatHistogram massHist;
FloatHistogram lengthHist;
FloatHistogram diameterHist;
FloatLineGraph lengthLineGraph;
FloatHistogram launchYearHist;
FloatHistogram apogeeHist;
FloatHistogram perigeeHist;
FloatHistogram incHist;
ScatterPlot scatterPlot;
int currentGraphBeingDrawn = 0;
Widget statesWidget, massWidget, lengthWidget, diameterWidget, launchYearWidget, apogeeWidget, perigeeWidget, incWidget, queryWidget7, overallData, queryWidgetApogee, queryWidgetPerigee, queryWidget22;
Widget swapWidget;
Widget massSelect, lengthSelect, diameterSelect, launchYearSelect, apogeeSelect, perigeeSelect, incSelect;
Widget scatterPlotSelect;
Widget massSelect2, lengthSelect2, diameterSelect2, launchYearSelect2, apogeeSelect2, perigeeSelect2, incSelect2;
Widget scatterPlotConfirm;
Widget widget1, widget2, queryScreenWidget,queryWidget1,queryWidget2,queryWidget3, backButton, details,enterWidget,queryWidget5,queryWidget6,queryWidget4,queryWidget8, queryWidget9, queryWidget10, queryWidget11,queryWidget12,gallery, gal1, gal2, gal3, gal4;
//boolean chartScreen = false;
Screen currentScreen, screen1, screen2, queryScreen, queryResultScreen, homeScreen,galScreen, galResult;       //Tanuj Sood, 30/03/22, added two screen, one to display queries and one to display results
Screen chartScreen;
Screen scatterPlotScreen;
String [] data;
PFont font, font2, font3;

ProgrammingProject main = this;
SearchBar focus;
ScrollBar scrollOne;  
SearchScreen searchScreen;
//Ignacy Sus 30/03 created an array with all the correct character, it was to fix a bug where it is impossible for the user to get a sattellite when typing the name, because the capslock button or shift would be an unkown character for processing
char []checkKeys = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
,'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' ',ENTER,BACKSPACE,'-','_','"','1','2','3','4','5','6','7','8','9','0'};//,"h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y"}; 
query queries; 
Widget searchWidget;


ScrollBar queryScroll;
int queryNum=0;
int[] someMass,someMassAsc;
int[] massArray;
int[] diaArray;
int[] apogeeArray;
int[] perigeeArray;
int[] tmpArray;
int textX = 510;
float median;
int sum;
int mean;
double sd;
String  massy="";
String namy= "";
Images image1;
ArrayList<String> sortMass;
ArrayList<String> sortName;
String category;
String words;


void settings()
{

  fullScreen();  
  // Tanuj changed size back to 1280x960 as background images have to be the same size as the picture and to make testing easier.
  //§size(1920,1080); // Ignacy Sus changed from size() to fullscreen()

}

void setup()
{
  earthBackground = loadImage("background3.png");
  greyBackground = loadImage("1920x1080-light-gray-solid-color-background.jpg");
  queries = new query(5); // add coment
  data = loadStrings("gcat.tsv");
  mySpaceObject = new ArrayList(); // Tanuj Sood, initalizing the ArrayList, 11:25am 21/03/2022
for (int i =1; i<data.length;i++) //Ignacy Sus, loop to create instances and add them to the array 21/03/2022
{
  mySpaceObject.add(new SpaceObject(data[i]));  
}
sortMass = new ArrayList <String>();
sortName = new ArrayList <String>();
screenList = new ArrayList();
shipStates = new ArrayList();
massArray = queries.sortMassAsc();
diaArray = queries.sortDiameterAsc();          // Anand Sainbileg changed the way to get arrays for queries 04/12/2022
apogeeArray = queries.sortApogeeAsc();
perigeeArray = queries.sortPerigeeAsc();
perigeeArrayList = queries.getPerigeeArrayList(mySpaceObject);
apogeeArrayList = queries.getApogeeArrayList(mySpaceObject);
perigeeArrayList = queries.getPerigeeArrayList(mySpaceObject);
apogeeArrayList = queries.getApogeeArrayList(mySpaceObject);
//incArrayList = queries.getIncArrayList(mySpaceObject);
launchYearList = queries.getYearArrayList(mySpaceObject);
//lengthArrayList = queries.getLengthArrayList(mySpaceObject);
massArrayList = queries.getMassArrayList(mySpaceObject);
diameterArrayList = queries.getDiameterArrayList(mySpaceObject);
queries.getArrayLists(mySpaceObject);
queries.getShipsPerState(mySpaceObject);
listOfUniqueStates = queries.getListOfUniqueStates(shipStates);
lengthHist = new FloatHistogram("Amount", "Length in cm", -0.5, LENGTH_UPPER_LIMIT, -0.5, 5500.0, "Distribution of lengths", lengthArrayList);
statesHist = new StringHistogram("Amount", "State", -0.5, Float.valueOf(listOfUniqueStates.size()), 0.0, 17000.0, "Number of Satellites by state", 
shipStates, listOfUniqueStates);
massHist = new FloatHistogram("Amount", "Mass in KG", -2.0, MASS_UPPER_LIMIT, -0.5, 4300.0, "Distribution of masses", massArrayList);
diameterHist = new FloatHistogram("Amount", "Diameter in meters", -0.5, DIAMETER_UPPER_LIMIT, -0.5, 40000.0, "Distribution of diameters", diameterArrayList);
launchYearHist = new FloatHistogram("Amount", "Launch Year", LAUNCH_YEAR_LOWER_LIMIT, LAUNCH_YEAR_UPPER_LIMIT, -0.5, 4500.0, "Distribution of launch years", launchYearList);
apogeeHist = new FloatHistogram("Amount", "Apogee", -0.5, APOGEE_UPPER_LIMIT, -0.5, 500.0, "Distribution of Apogees", apogeeArrayList);
perigeeHist = new FloatHistogram("Amount", "Perigee", -0.5, PERIGEE_UPPER_LIMIT, -0.5, 500.0, "Distribution of Perigees", perigeeArrayList);
incHist = new FloatHistogram("Amount", "Inclination", -0.5, INCLINATION_UPPER_LIMIT, -0.5, 6000.0, "Distribution of Inclinations", incArrayList);

scatterPlot = new ScatterPlot(" ", " ", -0.5, 0.0, -0.5, 0.0, " ", 
emptyList, emptyList);
chartList = new ArrayList();
chartList.add(lengthHist);
chartList.add(statesHist);
chartList.add(massHist);
chartList.add(diameterHist);
chartList.add(launchYearHist);
chartList.add(apogeeHist);
chartList.add(perigeeHist);
chartList.add(incHist);
   // Tanuj Sood, 30/03/22, added widgets to implement queries

focus = null;
earth = loadImage("earthpng.png");
font =loadFont("Avenir-Light-40.vlw");// loadFont("AcademyEngravedLetPlain-30.vlw");  // Ignacy Sus, creating and loading the font to print the instances 11:51 20/03/2022
font2 = font;
font3 = font;
sputnik = loadImage("sputnik.jpeg");
isc = loadImage("ics2.jpeg");
kalamSat = loadImage("kalamsat.jpeg");
parker = loadImage("parker.jpeg");
searchingpic = loadImage("srb.jpeg");
chartPic = loadImage("chartPic.jpeg");
gallerypic = loadImage("gallery1.jpeg");
querypic = loadImage("querypic.jpeg");
dataPic = loadImage("dataAnalysis.jpeg");
screen1 = new Screen(color(#03379B));
screenList.add(screen1);
screen2 = new Screen(color(0));
queryScreen = new Screen(color(255));  // add comment
queryResultScreen = new Screen(color(255));
image1 = new Images(0, 0, 2000, 1100);   
homeScreen = new Screen(color(0));
chartScreen = new Screen(color(#03379B));
galScreen = new Screen(color(255));        // Anand Sainbileg implemented gallery query 04/07/2022
galResult = new Screen(color(255));
//screenList.add(homeScreen);
scatterPlotScreen = new Screen(color(#03379B));
enterWidget = new Widget(655, 145 , 150, 50,"     ENTER", color(255), font3, EVENT_ENTER,NORMAL_TEXT_SIZE,false, noImg);
widget1 = new Widget(0, 0 , 150, 50,"Home", color(255), font, EVENT_BUTTON1,NORMAL_TEXT_SIZE,false,noImg);    //Anand Sainbileg made updates on the screens and widgets and added image constructor 3/30/2022


widget2 = new Widget(Math.round(displayWidth/9.6), Math.round(displayHeight/10.8), 235, 209, "", color(#00F50E), font, EVENT_BUTTON2,Math.round(NORMAL_TEXT_SIZE+10),true,chartPic); 
overallData =  new Widget(Math.round(displayWidth/1.26315789), Math.round(displayHeight/1.35), 187, 210, " ", color(#00F50E), font3, EVENT_QUERY12,NORMAL_TEXT_SIZE,true,dataPic);
queryScreenWidget = new Widget(Math.round(displayWidth/1.26315789), Math.round(displayHeight/10.8), 213, 213,"", color(#00F50E), font, EVENT_BUTTON4,Math.round(NORMAL_TEXT_SIZE+10),true,querypic);
gallery = new Widget (Math.round(displayWidth/9.6), Math.round(displayHeight/1.35), 213, 213, "", color(#00F50E), font, EVENT_GAL,NORMAL_TEXT_SIZE,true,gallerypic);
searchWidget = new Widget(Math.round(displayWidth/2.49350649), Math.round(displayHeight/1.2), 358, 47, "", color(#00F50E), font,  EVENT_SEARCH_SCREEN,Math.round(NORMAL_TEXT_SIZE+10),true,searchingpic); 
widget2.textXPos += Math.round(displayWidth/42.66667);
queryScreenWidget.textXPos += Math.round(displayWidth/42.66667);
searchWidget.textXPos+= Math.round(displayWidth/42.66667);
widget2.textYPos -= Math.round(displayHeight/14.4);
queryScreenWidget.textYPos -= Math.round(displayHeight/14.4);
searchWidget.textYPos -= Math.round(displayHeight/14.4);


queryWidget1 =  new Widget(300, 60, 1200, 70,  "1. Difference in Number Of Launches by United States and Soviet Union before and after the end of \"The Space Race\" (July 1975). ", color(255), font, EVENT_QUERY1,NORMAL_TEXT_SIZE,false,noImg); //Tanuj Sood, 30/03/22, created query widgets
queryWidget2 =  new Widget(665, 10, 150, 40, "Diameter", color(255), font3, EVENT_QUERY2,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidget22 = new Widget(300, 150, 1200, 70, "2. Number of Orbital Launches and its impact.", color(255), font, EVENT_QUERY22,NORMAL_TEXT_SIZE,false,noImg);
queryWidget4 =  new Widget(300, 240, 1200, 70,  "3. The longest space object.", color(255), font, EVENT_QUERY44,NORMAL_TEXT_SIZE,false,noImg);
queryWidget12 = new Widget(300, 420, 1200, 70,  "5. The heaviest space object.", color(255), font, EVENT_QUERY112,NORMAL_TEXT_SIZE,false,noImg);
queryWidget11 = new Widget(300, 330, 1200, 70,  "4. Difference in Launch Frequency between the first decade of space launches and the last decade.", color(255), font, EVENT_QUERY111,NORMAL_TEXT_SIZE,false,noImg);
queryWidget3 =  new Widget(200, 150, 300, 60, "Max / Min", color(255), font3, EVENT_QUERY3,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidget5 =  new Widget(510, 10, 150, 40, "Mass", color(255), font3, EVENT_QUERY5,NORMAL_TEXT_SIZE + 10,false,noImg);      // Anand Sainbileg added extra queryWidgets 04/11/2022
queryWidget6 =  new Widget(300, 50, 200, 40, "Descending order", color(255), font, EVENT_QUERY6,NORMAL_TEXT_SIZE,false,noImg);
queryWidget7 =  new Widget(200, 250, 300, 60, "Median", color(255), font3, EVENT_QUERY7,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidget8 =  new Widget(200, 350, 300, 60, "Sum", color(255), font3, EVENT_QUERY8,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidget9 =  new Widget(200, 450, 300, 60, "Mean", color(255), font3, EVENT_QUERY9,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidget10 = new Widget(200, 550, 300, 60, "Standard Deviation", color(255), font3, EVENT_QUERY10,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidgetApogee =  new Widget(820, 10, 150, 40, "Apogee", color(255), font3, EVENT_QUERY13,NORMAL_TEXT_SIZE + 10,false,noImg);
queryWidgetPerigee =  new Widget(975, 10, 150, 40, "Perigee", color(255), font3, EVENT_QUERY14,NORMAL_TEXT_SIZE + 10,false,noImg);
statesWidget = new Widget(200, 50, 300, 70, "Satellites per state", color(255), font, EVENT_BUTTON11, NORMAL_TEXT_SIZE, false, noImg);
massWidget = new Widget(200, 150, 300, 70, "Distribution of masses", color(255), font, EVENT_BUTTON12, NORMAL_TEXT_SIZE, false, noImg);
lengthWidget = new Widget(200, 250, 300, 70, "Distribution of lengths", color(255), font, EVENT_BUTTON13, NORMAL_TEXT_SIZE, false, noImg);
diameterWidget = new Widget(200, 350, 300, 70, "Distribution of diameters", color(255), font, EVENT_BUTTON14, NORMAL_TEXT_SIZE, false, noImg);
launchYearWidget = new Widget(200, 450, 300, 70, "Distribution of launch years", color(255), font, EVENT_BUTTON34, NORMAL_TEXT_SIZE, false, noImg);
apogeeWidget = new Widget(200, 550, 300, 70, "Distribution of Apogees", color(255), font, EVENT_BUTTON35, NORMAL_TEXT_SIZE, false, noImg);
perigeeWidget = new Widget(200, 650, 300, 70, "Distribution of Perigees", color(255), font, EVENT_BUTTON36, NORMAL_TEXT_SIZE, false, noImg);
incWidget = new Widget(200, 750, 300, 70, "Distribution of incs", color(255), font, EVENT_BUTTON37, NORMAL_TEXT_SIZE, false, noImg);

swapWidget = new Widget(Math.round(displayWidth/1.06666667), Math.round(displayHeight/2.7), Math.round(displayWidth/16), Math.round(displayHeight/15.43), "Swap view", color(255), font, EVENT_BUTTON16, NORMAL_TEXT_SIZE, false, noImg);
gal1 = new Widget (300, 60, 800, 70, "First ever launched satellite", color(255), font, EVENT_GAL1,NORMAL_TEXT_SIZE,false,noImg);
gal2 = new Widget (300, 150, 800, 70, "Heaviest satellite ever", color(255), font, EVENT_GAL2,NORMAL_TEXT_SIZE,false,noImg);
gal3 = new Widget (300, 240, 800, 70, "Lightest and the smallest satellite ever", color(255), font, EVENT_GAL3,NORMAL_TEXT_SIZE,false,noImg);
gal4 = new Widget (300, 330, 800, 70, "The fastest satellite ever", color(255), font, EVENT_GAL4,NORMAL_TEXT_SIZE,false,noImg);
//launchYearWidget = new Widget(200, )
scatterPlotSelect = new Widget(0, 110, 150, 50, "Scatter plots", color(255), font, EVENT_BUTTON17, NORMAL_TEXT_SIZE, false, noImg);
massSelect = new Widget(Math.round(displayWidth/95), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Mass", color(255), font, EVENT_BUTTON18, NORMAL_TEXT_SIZE, false, noImg);
lengthSelect = new Widget(Math.round(displayWidth/95) + Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Length", color(255), font, EVENT_BUTTON19, NORMAL_TEXT_SIZE, false, noImg);
diameterSelect = new Widget(Math.round(displayWidth/95) + 2*Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Diameter", color(255), font, EVENT_BUTTON20, NORMAL_TEXT_SIZE, false, noImg);
launchYearSelect = new Widget(Math.round(displayWidth/95) + 3*Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Launch year", color(255), font, EVENT_BUTTON21, NORMAL_TEXT_SIZE-2, false, noImg);
apogeeSelect = new Widget(Math.round(displayWidth/95) + 4*Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Apogee", color(255), font, EVENT_BUTTON22, NORMAL_TEXT_SIZE, false, noImg);
perigeeSelect = new Widget(Math.round(displayWidth/95) + 5*Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Perigee", color(255), font, EVENT_BUTTON23, NORMAL_TEXT_SIZE, false, noImg);
incSelect = new Widget(Math.round(displayWidth/95) + 6*Math.round(displayWidth/16), Math.round(displayHeight/7), Math.round(displayWidth/18), Math.round(displayHeight/20), "Inc", color(255), font, EVENT_BUTTON24, NORMAL_TEXT_SIZE, false, noImg);

massSelect2 = new Widget(Math.round(displayWidth/95), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Mass", color(255), font, EVENT_BUTTON25, NORMAL_TEXT_SIZE, false, noImg);
lengthSelect2 = new Widget(Math.round(displayWidth/95) + Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Length", color(255), font, EVENT_BUTTON26, NORMAL_TEXT_SIZE, false, noImg);
diameterSelect2 = new Widget(Math.round(displayWidth/95) + 2*Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Diameter", color(255), font, EVENT_BUTTON27, NORMAL_TEXT_SIZE, false, noImg);
launchYearSelect2 = new Widget(Math.round(displayWidth/95) + 3*Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Launch year", color(255), font, EVENT_BUTTON28, NORMAL_TEXT_SIZE-2, false, noImg);
apogeeSelect2 = new Widget(Math.round(displayWidth/95) + 4*Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Apogee", color(255), font, EVENT_BUTTON29, NORMAL_TEXT_SIZE, false, noImg);
perigeeSelect2 = new Widget(Math.round(displayWidth/95) + 5*Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Perigee", color(255), font, EVENT_BUTTON30, NORMAL_TEXT_SIZE, false, noImg);
incSelect2 = new Widget(Math.round(displayWidth/95) + 6*Math.round(displayWidth/16), Math.round(displayHeight/2.25), Math.round(displayWidth/18), Math.round(displayHeight/20), "Inc", color(255), font, EVENT_BUTTON31, NORMAL_TEXT_SIZE, false, noImg);
scatterPlotConfirm = new Widget(Math.round(displayWidth/38), Math.round(displayHeight/1.2), Math.round(displayWidth/6), Math.round(displayHeight/10), "Confirm selection", color(255), font, EVENT_BUTTON38, NORMAL_TEXT_SIZE+18, false, noImg);

backButton = new Widget(0, 50, 150, 50,"Back", color(255), font, EVENT_BUTTON10,NORMAL_TEXT_SIZE,false,noImg);          //Anand Sainbileg 04/01/2022 added a widget called "back", this widget can appear on screens which that screen
// leads to multiple screens and would be useful to just go back to previous screen instead of going to home screen.
details = new Widget(0, 0, 150, 50,"Welcome", color(255), font, 69,NORMAL_TEXT_SIZE,false,noImg);
queryScreen.add(backButton);
//screen1.add(details);          
screen2.add(backButton);
screen1.add(widget2); 
screen1.add(searchWidget);    //Anand Sainbileg fixed the bugs, displayed the queries widget back on the screen and added search widget to screen1
screen1.add(queryScreenWidget);
queryScreen.addScreenText(700, 50, "QUERIES", color(255),font);
queryScreen.add(widget1); 
screen1.add(overallData);
queryScreen.add(queryWidget1);
queryScreen.add(queryWidget22);
queryScreen.add(queryWidget4);
queryScreen.add(queryWidget11);
queryScreen.add(queryWidget12);
//queryResultScreen.add(queryWidget3);    // Anand Sainbileg updated the widget locations
//queryResultScreen.add(queryWidget6);
//queryResultScreen.add(queryWidget8);
chartScreen.add(statesWidget);
chartScreen.add(massWidget);
chartScreen.add(lengthWidget);
chartScreen.add(diameterWidget);
chartScreen.add(backButton);
chartScreen.add(swapWidget);
chartScreen.add(scatterPlotSelect);
chartScreen.add(launchYearWidget);
chartScreen.add(apogeeWidget);
chartScreen.add(perigeeWidget);
chartScreen.add(incWidget);

scatterPlotWidgets.add(massSelect);
scatterPlotWidgets.add(lengthSelect);
scatterPlotWidgets.add(diameterSelect);
scatterPlotWidgets.add(launchYearSelect);
scatterPlotWidgets.add(apogeeSelect);
scatterPlotWidgets.add(perigeeSelect);
scatterPlotWidgets.add(incSelect);
scatterPlotWidgets2.add(massSelect2);
scatterPlotWidgets2.add(lengthSelect2);
scatterPlotWidgets2.add(diameterSelect2);
scatterPlotWidgets2.add(launchYearSelect2);
scatterPlotWidgets2.add(apogeeSelect2);
scatterPlotWidgets2.add(perigeeSelect2);
scatterPlotWidgets2.add(incSelect2);

scatterPlotScreen.add(backButton);
scatterPlotScreen.add(massSelect);
scatterPlotScreen.add(lengthSelect);
scatterPlotScreen.add(diameterSelect);
scatterPlotScreen.add(launchYearSelect);
scatterPlotScreen.add(apogeeSelect);
scatterPlotScreen.add(perigeeSelect);
scatterPlotScreen.add(incSelect);

scatterPlotScreen.add(massSelect2);
scatterPlotScreen.add(lengthSelect2);
scatterPlotScreen.add(diameterSelect2);
scatterPlotScreen.add(launchYearSelect2);
scatterPlotScreen.add(apogeeSelect2);
scatterPlotScreen.add(perigeeSelect2);
scatterPlotScreen.add(incSelect2);
scatterPlotScreen.add(scatterPlotConfirm);
screen1.add(gallery);
galScreen.add(widget1);          // Anand Sainbileg implemented gallery query 04/07/2022
galScreen.add(backButton);
galResult.add(widget1);
galResult.add(backButton);
galScreen.add(gal1);
galScreen.add(gal2);
galScreen.add(gal3);
galScreen.add(gal4);

homeScreen.addScreenText(20,30, "WELCOME TO A PROGRAMMING PROJECT,", color(0), font3);        // TANUJ SOOD figure out a better way to type multiple texts line in a scree
homeScreen.addScreenText2(20,60, "BY:", color(0), font3); 

homeScreen.addScreenText3(20,90, "ANAND S", color(0), font3); 
homeScreen.addScreenText4(20,120, "GERARD M", color(0), font3); 
homeScreen.addScreenText5(20,150, "IGNACY S", color(0), font3); 
homeScreen.addScreenText6(20,180, "TANUJ S", color(0), font3); 

queryResultScreen.add(widget1);
queryResultScreen.add(backButton);
homeScreen.add(enterWidget);
//screen1.addImage(image1);
currentScreen = homeScreen;
textFont(font);
searchScreen = new SearchScreen(color(20,20,30), mySpaceObject,font2, earth);
searchScreen.add(widget1);
roverImg = loadImage("roverImg.jpeg");   
homeScreen.changeBackground(roverImg);      // Tanuj Sood, changing home screen image
//earth.resize(1920,1080);
//queryScreen.changeBackground(earth);
neil = loadImage("neil.jpeg");
neil.resize(1920,1080);
queryScreen.changeBackground(neil);
queryScroll=new ScrollBar(0,(0.2*height),(int)(0.015*width),(int)(0.8*height),12);

someMass=queries.sortMassDesc();
someMassAsc=queries.sortMassAsc();
chartScreen.changeBackground(greyBackground);
scatterPlotScreen.changeBackground(greyBackground);
screen1.changeBackground(earthBackground);
}

void draw()
{
 
  background(BLACK);
  currentScreen.draw();// Anand Sainbileg added screen to the setup and added widget to the current screen 
  if (currentScreen == scatterPlotScreen)
  {
    scatterPlot.draw();
    fill(0);
    textFont(font2);
    textSize(25);
    text("Choose the parameter for the X axis. ", Math.round(displayWidth/9.14), Math.round(displayHeight/7.2));
    text("Choose the parameter for Y axis. ", Math.round(displayWidth/9.14), Math.round(displayHeight/2.322));
  }

    
  if (currentScreen==chartScreen){
  lengthWidget.draw();
  massWidget.draw();
  statesWidget.draw();
  diameterWidget.draw();
  switch (currentGraphBeingDrawn)
  {
    case EVENT_BUTTON11:
    statesHist.draw();
    return;
    case EVENT_BUTTON12:
    massHist.draw();
    return;
    case EVENT_BUTTON13:
    lengthHist.draw();
    return;
    case EVENT_BUTTON14:
    diameterHist.draw();
    return;
    case EVENT_BUTTON34:
    launchYearHist.draw();
    return;
    case EVENT_BUTTON35:
    apogeeHist.draw();
    return;
    case EVENT_BUTTON36:
    perigeeHist.draw();
    return;
    case EVENT_BUTTON37:
    incHist.draw();
    return;
  }
  }
  
  
    
  if (currentScreen!=queryResultScreen){
      queryNum=0;;
    }
}


void mousePressed(){  //Anand Sainbileg made mousePressed to get event
int event;
for(int i = 0; i<currentScreen.screenWidgets.size(); i++){ 
  Widget aWidget = (Widget) currentScreen.screenWidgets.get(i); //Anand Sainbileg fixed bugs on this method 
event = aWidget.getEvent(mouseX,mouseY); 
//chartScreen = false;
//println(event);
switch(event) 
{
   // Tanuj Sood, 30/03/22, implemented a new  query screen and the subsequent displaying of all the queries using switch statement.
   // TANUJ SOOD, 12/04/22, changed the query to display an informative slide on diff launches between us and su before and after space race.
  case EVENT_QUERY1:
  String query1="1. Difference in Number Of Launches by United States and Soviet Union before and after the end of\n \" The Space Race\" (July 1975). \n\n\n" 
                  + " At the height of the Cold War between the United States and the Soviet Union, another competition \n was born between the warring countries." +
                  "The heigth of the Space Race saw both countries dumping massive \n amount of money into their space program with the US investing $482 billion dolloars(adjusted for inflation) \n into" +
                  " thier space program resuting in a total launches of "+queries.USlaunchesNum(mySpaceObject).get(0)+ " per year over this period."+
                  " While the Soviet \n Union estimately spent over $310 billion dollors resulting in a total launches of  "+queries.USlaunchesNum(mySpaceObject).get(2)+ " per year over this period.\n\n"+
                  "The Apollo–Soyuz Test Project(on July 15, 1975) a planned joint mission between the two states is\n considered by most historians the end of the space race. " +
                  " The following years saw massive drops in spending \n by both countries, with the US decreasing their spending from 4.4% of their GDP to just 1% which saw the\n US reducing their"+
                  " average number of launches per year to "+queries.USlaunchesNum(mySpaceObject).get(1)+ " after 1975. While the Soviet Union saw their\n spending dropped from a 3.9% of their GDP to 0.7% which resulted in a reduced "+
                  " number of launches per\n year by the Soviet Union to "+queries.USlaunchesNum(mySpaceObject).get(3)+"." ;
           
  aWidget.eventNumber(EVENT_BUTTON2);
  currentScreen = queryResultScreen;
  queryResultScreen.addScreenText(80,170,query1,color(255),font);
  screenList.add(queryResultScreen);
  return;
case EVENT_QUERY2:
 tmpArray = diaArray;
  tmpAL = diameterArrayList;
  textX = 510;
  queryResultScreen.remove(queryWidget3);
  queryResultScreen.remove(queryWidget7);
  queryResultScreen.remove(queryWidget8);
  queryResultScreen.add(queryWidget3);
  queryResultScreen.add(queryWidget7);
  queryResultScreen.add(queryWidget8);
  queryResultScreen.addScreenText(610,190, "", color(255),font);
  queryResultScreen.addScreenText2(300,700, "Current category: Diameter (m)", color(255),font);
  queryResultScreen.remove(queryWidget9);
  queryResultScreen.remove(queryWidget10);
  category = "m (Diameter)";
  words = " Diameter list";
  queryWidget2.eventNumber(EVENT_QUERY2);
return;
case EVENT_QUERY22:                 
// TANUJ SOOD, 13/04/22, created the query to display an informative slide on number of orbital launches and its imapct.
  String query2 = "2. Number of Orbital Launches and its impact. \n\n\n" +"Since  1957, The world cumlatively has launched " + queries.numOfOrbitalLaunches(mySpaceObject) +
                    " objects into orbit. Although this astonishingly large\nnumber can be heralded as the coming of age of Humanity as a space faring civilization"+
                    " but that also means \nwe've left our mark on space in the form of trash. Space junk or debris has matured into a huge problem for \nall space agencies"+
                    " in recent decades. The junk includes the stages from rockets that jettison satellites into \norbit and the satellites themselves " +
                    "once they die. But it also includes smaller bits and pieces lost to space by \ncollisons or jerk/decay separation. Even this smaller pieces " +
                    " of juck in orbit can travel up to speeds of \n22,300 mph. Collisons can result in massive damage and loss well into millions and maybe even" +
                    " human lives. \nThis forces space agencies to constantly track this junk and manuevere their satellites and space station \nout of the way." +
                    " While some of the junk will lose altitude over time and burn up in Earth's atmosphere,\nthere's a lot of stuff up there. \n" +
                    "For now we need to make sure all future launches has procedures in place to deorbit any space object \nafter its use cycle is over."+
                    " Further there has to be an international effort to clean up the existing debris, \nsome ideas to do so include magnets, harpoons, and nets to " +
                    "safely whittle down the growing debris cloud.";
 
  aWidget.eventNumber(EVENT_BUTTON2);
  currentScreen = queryResultScreen;
  queryResultScreen.addScreenText(80,170, query2, color(255),font);
  //queryResultScreen.addScreenText(300,110, String.valueOf(queries.getMaxFloat(queries.getLengthArrayList(mySpaceObject))), color(0),font);
  screenList.add(queryResultScreen);
  return;
 case EVENT_QUERY44:                 
// TANUJ SOOD, 13/04/22, created the query to display an informative slide on number of largest space object
  float maxLength = queries.maxLength(mySpaceObject);
  String query3 = "3. The longest space object\n\n\n" +"Within the Dataset, Coming at " + maxLength+"m the Echo 2 is the longest satellite launched. \n"+
  "Echo 2 was a diameter balloon satellite, the last launched by Project Echo. A revised \ninflation system was used for the balloon, to improve its smoothness and "+
  "sphericity.\n Echo 2's skin was rigidizable, unlike that of Echo 1. Therefore, the balloon was capable \nof maintaining its shape without a constant internal"+ 
  "pressure; a long-term supply of \ninflation gas was not needed, and it could easily survive strikes from micrometeoroids.\n"+
  "The system consisted of two beacon assemblies powered by solar cell panels and had a \nminimum power output of 45 mW at 136.02 MHz and 136.17 MHz.";
 
  aWidget.eventNumber(EVENT_BUTTON2);
  currentScreen = queryResultScreen;
  queryResultScreen.addScreenText(80,170, query3, color(255),font);
  screenList.add(queryResultScreen);
  return;
  case EVENT_QUERY111:
    int firstdecade = queries.launchFreqInDecade(mySpaceObject,1957);
    int seconddecade = queries.launchFreqInDecade(mySpaceObject,2011);
    String query4 ="4. Difference in Launch Frequency between the first decade and the last deacade.\n\n" +
                    "When scientists first started launching rockets in the 1950s, it would have been hard for \nthem to imagine that soon they would be launching"+
                     " 100s of such rockets every the year.\n Following the cold war both United States and Soviet Union invested heavily in their \nspace programs respectfully "+
                     "resulting in a massive rise in launches in early years as the\n total number of launches between 1957 and 1967 tallied to about " + firstdecade+
                     " launches but\n as the tension simmered down between the World Powers, So did the launches " +
                     " with \nboth sides cutting down massively on funding. But Even then the overall number of \nlaunches kept increasing, this signalled the end of the space"+
                     "monopoly by the US and \nSoviet Union as new players such as china and India emerged. It also showed how \nmuch more economical space flight was" +
                     " slowly becoming as the technology evolved.\n"+" In the past decade the world cumulatievly launched "+seconddecade +" space missions."+
                     "Further more \nin recent years as space is becoming increasingly privatised the number of launches is \n"+
                     "expected to increase exponentially with projections of over 300 launches per year.";
    aWidget.eventNumber(EVENT_BUTTON2);
    currentScreen = queryResultScreen;
    queryResultScreen.addScreenText(80,170, query4, color(255),font);
    screenList.add(queryResultScreen);
    return;
case EVENT_QUERY112:
    float maxMassdata= queries.maxMassdata(mySpaceObject); //<>//
    String query5 = "5. The heaviest space object.\n\n\n"+
                  "Coming in at " +maxMassdata+ " Kg, Discovery (STS-102) is the heaviest mission in the entire dataset.\nSTS-102 was a Space Shuttle mission to the"+ 
                  "International Space Station (ISS) flown \nby Space Shuttle Discovery and launched from Kennedy Space Center, Florida. STS-102 \nflew in March 2001;"+
                  "its primary objectives were resupplying the ISS and rotating \nthe Expedition 1 and Expedition 2 crews. At eight hours 56 minutes, the first EVA \n"+
                  "performed on the mission remains the longest spacewalk ever undertaken.";
    aWidget.eventNumber(EVENT_BUTTON2);
    currentScreen = queryResultScreen;
    queryResultScreen.addScreenText(80,170, query5, color(255),font);
    screenList.add(queryResultScreen);
    return;
case EVENT_QUERY3:                                  
  queryWidget3.eventNumber(EVENT_QUERY3);
  currentScreen = queryResultScreen;
  queryResultScreen.addScreenText(textX,190, " Maximum and Minimum of Overall" + words + "\n "+ String.valueOf(queries.getMax(tmpArray)) + " / " + String.valueOf(queries.getMin(tmpArray)) + " " + category, color(255),font);
  return;
case EVENT_QUERY5:             


  tmpArray = massArray;
tmpAL = massArrayList;
textX = 510;
queryResultScreen.addScreenText(610,190, "", color(255),font);
queryResultScreen.addScreenText2(300,700, "Current category: Mass (kg)", color(255),font);
queryResultScreen.remove(queryWidget9);
queryResultScreen.remove(queryWidget10);

  queryResultScreen.remove(queryWidget3);
  queryResultScreen.remove(queryWidget7);
  queryResultScreen.remove(queryWidget8);
  queryResultScreen.add(queryWidget3);
  queryResultScreen.add(queryWidget7);
  queryResultScreen.add(queryWidget8);
  queryWidget5.eventNumber(EVENT_QUERY5);
  category = "kg (mass)";
  words = "Mass list";
  return;

case EVENT_QUERY7:

//median = queries.getMedian(massArray);
//queryResultScreen.addScreenText(200,50,"Median of the data set: \n" + median, color(255),font);
median = queries.getMedian(tmpAL);
queryWidget7.eventNumber(EVENT_QUERY7);
queryResultScreen.addScreenText(textX,285," Median of overall "+ words + ":\n "+ median + category, color(255),font);

return;
case EVENT_QUERY8:
sum = queries.getSum(tmpArray);
sum = Math.abs(sum);
queryResultScreen.addScreenText(textX,385," Sum of overall "+ words + ":\n " + sum + category, color(255),font);
queryWidget8.eventNumber(EVENT_QUERY8);
queryResultScreen.remove(queryWidget9);
queryResultScreen.remove(queryWidget10);
queryResultScreen.add(queryWidget9);
queryResultScreen.add(queryWidget10);
return;
case EVENT_QUERY9:
mean = queries.getMean(tmpArray, sum);
queryWidget9.eventNumber(EVENT_QUERY9);
queryResultScreen.addScreenText(textX,485," Mean of overall "+ words + ":\n " + mean + category, color(255),font);
return;
case EVENT_QUERY10:
sd = queries.getSd(tmpArray, mean);
queryWidget10.eventNumber(EVENT_QUERY10);
queryResultScreen.addScreenText(textX,585," Standard Deviation of overall "+ words + ":\n " + sd, color(255),font);
return;
case EVENT_QUERY12:
currentScreen = queryResultScreen;
queryResultScreen.addScreenText(580,400, "Please choose a category", color(255),font);
overallData.eventNumber(EVENT_QUERY12);
queryResultScreen.add(queryWidget2);
queryResultScreen.add(queryWidget5);
queryResultScreen.add(queryWidgetApogee);
queryResultScreen.add(queryWidgetPerigee);
screenList.add(queryResultScreen);
return;
case EVENT_QUERY13:
tmpArray = apogeeArray;
tmpAL = apogeeArrayList;
textX = 510;
  queryResultScreen.remove(queryWidget3);
  queryResultScreen.remove(queryWidget7);
  queryResultScreen.remove(queryWidget8);
  queryResultScreen.add(queryWidget3);
  queryResultScreen.add(queryWidget7);
  queryResultScreen.add(queryWidget8);
  queryResultScreen.addScreenText(610,190, "", color(255),font);
  queryResultScreen.addScreenText2(300,700, "Current category: Apogee (km)", color(255),font);
  queryResultScreen.remove(queryWidget9);
  queryResultScreen.remove(queryWidget10);
  category = "km (Apogee)";
  words = " Apogee list";
  queryWidgetApogee.eventNumber(EVENT_QUERY13);
return;
case EVENT_QUERY14:
  tmpArray = perigeeArray;
  tmpAL = perigeeArrayList;
  textX = 510;
  queryResultScreen.remove(queryWidget3);
  queryResultScreen.remove(queryWidget7);
  queryResultScreen.remove(queryWidget8);
  queryResultScreen.add(queryWidget3);
  queryResultScreen.add(queryWidget7);
  queryResultScreen.add(queryWidget8);
  queryResultScreen.addScreenText(610,190, "", color(255),font);
  queryResultScreen.addScreenText2(300,700, "Current category: Perigee (km)", color(255),font);
  queryResultScreen.remove(queryWidget9);
  queryResultScreen.remove(queryWidget10);
  category = "km (Perigee)";
  words = " Perigee list";
  queryWidgetPerigee.eventNumber(EVENT_QUERY14);
return;
case EVENT_BUTTON1:
  if (currentScreen == searchScreen && searchScreen.screenNumber!=0) return;
  aWidget.eventNumber(EVENT_BUTTON1);
  currentScreen = screen1;
  screenList.add(screen1);
  return;
case EVENT_BUTTON2:
  aWidget.eventNumber(EVENT_BUTTON2);
  //chartScreen= true;
  currentScreen = chartScreen;
  screenList.add(chartScreen);
  return;
case EVENT_BUTTON3:
  aWidget.eventNumber(EVENT_BUTTON3);
  return;
//Ignacy Sus 1/04 Added the option that when the search bar is pressed the "Search" message disappear ( so the user doesn't need to delete it manually)
// Ignacy Sus 12/04 Able to update the position of scorll bar when pressing the searchBar
case EVENT_SEARCH:
  focus = (SearchBar) searchScreen.searchBar;
  focus.label = "";
  searchScreen.scrollOne.newspos = 0.965*height;
  return;

case EVENT_SEARCH_SCREEN:
  searchScreen.setIsActive(0);
  currentScreen = searchScreen;
  screenList.add(searchScreen);
  return;
case EVENT_BUTTON4:                                  
  aWidget.eventNumber(EVENT_BUTTON2);
  currentScreen = queryScreen;
  screenList.add(queryScreen);
  return;

// Ignacy Sus 12/04 Sorting the whole data set with a custom comparator ( tried recursion with quicksort and insertion sort but they were too slow) and also reinitalize the position of the data to the now first element of the set
case EVENT_SORT_MASS: 
   Collections.sort(mySpaceObject, new SortByMass());
   searchScreen.scrollOne.newspos = 0.965*height;
   return;
 //Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_LAUNCH:
  Collections.sort(mySpaceObject, new SortByLaunch());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
 //Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_DIAMETER:
  Collections.sort(mySpaceObject, new SortByDiameter());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
//Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_NAME:
  Collections.sort(mySpaceObject, new SortByName());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
 //Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_MASS_DESCEND: 
   Collections.sort(mySpaceObject, new SortByMassDescending());
   searchScreen.scrollOne.newspos = 0.965*height;
   return;
 //Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_LAUNCH_DESCEND:
  Collections.sort(mySpaceObject, new SortByLaunchDescending());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
 //Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_DIAMETER_DESCEND:
  Collections.sort(mySpaceObject, new SortByDiameterDescending());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
//Ignacy Sus 12/04 Analogical sorting tfor the data set with a custom comparator and different sorting attributes
case EVENT_SORT_NAME_DESCEND:
  Collections.sort(mySpaceObject, new SortByNameDescending());
  searchScreen.scrollOne.newspos = 0.965*height;
  return;
case EVENT_BUTTON10:            //Anand Sainbileg 04/01/2022 implemented the back button function
currentGraphBeingDrawn = 0;
int index = screenList.size()-1;
screenList.remove(index);
currentScreen = screenList.get(screenList.size() - 1);
aWidget.eventNumber(EVENT_BUTTON10); 
queryResultScreen.remove(queryWidget9);
queryResultScreen.remove(queryWidget10);
queryResultScreen.remove(queryWidget2);
queryResultScreen.remove(queryWidget5);
queryResultScreen.remove(queryWidgetApogee);
queryResultScreen.remove(queryWidgetPerigee);
queryResultScreen.remove(queryWidget3);
queryResultScreen.remove(queryWidget7);
queryResultScreen.remove(queryWidget8);
queryResultScreen.addScreenText2(610,580,"", color(255),font);
queryResultScreen.addScreenText(200,50,"", color(255),font);
return;
case EVENT_ENTER:
  currentScreen = screen1;
  screenList.add(screen1);
  return;
case EVENT_BUTTON11:
  currentGraphBeingDrawn = EVENT_BUTTON11;
  if (!chartScreen.contains(swapWidget))
  {
    chartScreen.add(swapWidget);
  }
  return;
case EVENT_BUTTON12:
  currentGraphBeingDrawn = EVENT_BUTTON12;
  if (!chartScreen.contains(swapWidget))
  {
    chartScreen.add(swapWidget);
  }
  return;
case EVENT_BUTTON13:
  currentGraphBeingDrawn = EVENT_BUTTON13;
  if (!chartScreen.contains(swapWidget))
  {
    chartScreen.add(swapWidget);
  }
  return;
case EVENT_BUTTON14:
  currentGraphBeingDrawn = EVENT_BUTTON14;
  if (!chartScreen.contains(swapWidget))
  {
    chartScreen.add(swapWidget);
  }
  return;
case EVENT_BUTTON15:
  currentGraphBeingDrawn = EVENT_BUTTON15;
  chartScreen.remove(swapWidget);
  return;
case EVENT_BUTTON16:
  swapCharts(chartList);
  return;
case EVENT_BUTTON17:
  currentScreen = scatterPlotScreen;
  screenList.add(scatterPlotScreen);
  currentGraphBeingDrawn = 0;
  return;

case EVENT_BUTTON18://Gerard Moylan 6/4/22 below is for controlling the scatter plot's x and y axis.
if (selectedParameter2 != massArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  massSelect.widgetColor = color(100);
  selectedParameter = massArrayList;
  scatterPlot.horizontalText = "Mass";
  scatterPlot.xUpperLim = MASS_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON19:
if (selectedParameter2 != lengthArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  lengthSelect.widgetColor = color(100);
  selectedParameter = lengthArrayList;
  scatterPlot.horizontalText = "Length";
  scatterPlot.xUpperLim = LENGTH_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON20:
if (selectedParameter2 != diameterArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  diameterSelect.widgetColor = color(100);
  selectedParameter = diameterArrayList;
  scatterPlot.horizontalText = "Diameter";
  scatterPlot.xUpperLim = DIAMETER_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON21:
if (selectedParameter2 != launchYearList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  launchYearSelect.widgetColor = color(100);
  selectedParameter = launchYearList;
  scatterPlot.horizontalText = "Launch year";
  scatterPlot.xLowerLim = LAUNCH_YEAR_LOWER_LIMIT;
  scatterPlot.xUpperLim = LAUNCH_YEAR_UPPER_LIMIT;

}
  return;
case EVENT_BUTTON22:
if (selectedParameter2 != apogeeArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  apogeeSelect.widgetColor = color(100);
  selectedParameter = apogeeArrayList;
  scatterPlot.horizontalText = "Apogee";
  scatterPlot.xUpperLim = APOGEE_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON23:
if (selectedParameter2 != perigeeArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  perigeeSelect.widgetColor = color(100);
  selectedParameter = perigeeArrayList;
  scatterPlot.horizontalText = "Perigee";
  scatterPlot.xUpperLim = PERIGEE_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON24:
if (selectedParameter2 != incArrayList)
{
  scatterPlotWidgets = setWidgetsWhite(scatterPlotWidgets);
  incSelect.widgetColor = color(100);
  selectedParameter = incArrayList;
  scatterPlot.horizontalText = "Inclination";
  scatterPlot.xUpperLim = INCLINATION_UPPER_LIMIT;
  scatterPlot.xLowerLim = -0.5;
}
  return;
case EVENT_BUTTON25:
if (selectedParameter != massArrayList)
{
scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
massSelect2.widgetColor = color(100);
selectedParameter2 = massArrayList;
scatterPlot.verticalText = "Mass";
scatterPlot.yUpperLim = MASS_UPPER_LIMIT;
scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON26:
if (selectedParameter != lengthArrayList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  lengthSelect2.widgetColor = color(100);
  selectedParameter2 = lengthArrayList;
  scatterPlot.verticalText = "Length";
  scatterPlot.yUpperLim = LENGTH_UPPER_LIMIT;
  scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON27:
if (selectedParameter != diameterArrayList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  diameterSelect2.widgetColor = color(100);
  selectedParameter2 = diameterArrayList;
  scatterPlot.verticalText = "Diameter";
  scatterPlot.yUpperLim = DIAMETER_UPPER_LIMIT;
  scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON28:
if (selectedParameter != launchYearList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  launchYearSelect2.widgetColor = color(100);
  selectedParameter2 = launchYearList;
  scatterPlot.verticalText = "Launch Year";
  scatterPlot.yLowerLim = LAUNCH_YEAR_LOWER_LIMIT;
  scatterPlot.yUpperLim = LAUNCH_YEAR_UPPER_LIMIT;
}
  return;
case EVENT_BUTTON29:
if (selectedParameter != apogeeArrayList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  apogeeSelect2.widgetColor = color(100);
  selectedParameter2 = apogeeArrayList;
  scatterPlot.verticalText = "Apogee";
  scatterPlot.yUpperLim = APOGEE_UPPER_LIMIT;
  scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON30:
if (selectedParameter != perigeeArrayList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  perigeeSelect2.widgetColor = color(100);
  selectedParameter2 = perigeeArrayList;
  scatterPlot.verticalText = "Perigee";
  scatterPlot.yUpperLim = PERIGEE_UPPER_LIMIT;
  scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON31:
if (selectedParameter != incArrayList)
{
  scatterPlotWidgets2 = setWidgetsWhite(scatterPlotWidgets2);
  incSelect2.widgetColor = color(100);
  selectedParameter2 = incArrayList;
  scatterPlot.verticalText = "Inclination";
  scatterPlot.yUpperLim = INCLINATION_UPPER_LIMIT;
  scatterPlot.yLowerLim = -0.5;
}
  return;
case EVENT_BUTTON34:
  currentGraphBeingDrawn = EVENT_BUTTON34;
  return;
case EVENT_BUTTON35:
  currentGraphBeingDrawn = EVENT_BUTTON35;
  return;
case EVENT_BUTTON36:
  currentGraphBeingDrawn = EVENT_BUTTON36;
  return;
case EVENT_BUTTON37:
  currentGraphBeingDrawn = EVENT_BUTTON37;
  return;
case EVENT_BUTTON38:
if (scatterPlot.xUpperLim != 0.0 && scatterPlot.yUpperLim != 0.0)
{
    scatterPlot.xAxisVariable = selectedParameter;
    scatterPlot.yAxisVariable = selectedParameter2;
    scatterPlot.removePoints();
    scatterPlot.addScatterPoints();
    scatterPlot.updateParameters();
    currentGraphBeingDrawn = EVENT_BUTTON38;
}
  return;
  case EVENT_GAL:
  currentScreen = galScreen;
  screenList.add(galScreen);
  return;
case EVENT_GAL1:
  currentScreen = galResult;            // Anand Sainbileg implemented gallery query 04/07/2022
  galResult.addScreenText(800,70, "Sputnik 1 was the first artificial Earth satellite. \nIt was launched into an elliptical low Earth \norbit by the Soviet Union on 4 October 1957.", color(255),font);
  galResult.addScreenText2(200,500, "Launch mass: 83.6kg", color(255),font);
  galResult.addScreenText3(200,560, "Apogee altitude: 939km", color(255),font);
  galResult.addScreenText4(800,500, "Mission duration: 22 days", color(255),font);
  galResult.addScreenText5(800,560, "Decay date: 4th January 1958", color(255),font);
  galResult.changeBackground(sputnik);
  screenList.add(galResult);
  return;
case EVENT_GAL2:         // Anand Sainbileg implemented gallery query 04/11/2022
  currentScreen = galResult;
  galResult.addScreenText(900,110, "International Space Station \nis a modular space station \n(habitable artificial satellite) \nin low Earth orbit.", color(255),font);
  galResult.addScreenText2(50,500, "Launch mass: 440,725kg", color(255),font);
  galResult.addScreenText3(50,560, "Owned by: NASA, Roscosmos,\n JAXA, ESA, CSA", color(255),font);
  galResult.addScreenText4(50,650, "State: ", color(255),font);
  galResult.addScreenText5(50,690, "In service since 1998 to present", color(255),font);
  galResult.changeBackground(isc); 
  screenList.add(galResult);
  return;
case EVENT_GAL3:
  currentScreen = galResult;
  galResult.addScreenText(800,70, "KalamSat, the lightest and smallest satellite\n is a femtosatellite.", color(255),font);
  galResult.addScreenText2(200,500, "", color(255),font);
  galResult.addScreenText3(200,560, "", color(255),font);
  galResult.addScreenText4(0,450, " Weight: 64 grams \n Size: 3.8cm cube.", color(255),font);
  galResult.addScreenText5(0,560, " The structure is fully 3D-printed with \nreinforced carbon fiber polymer.\n It is equipped with a nano Geiger Muller counter \nwhich will measure radiation in space.", color(255),font);
  galResult.changeBackground(kalamSat);
  screenList.add(galResult);
  return;
case EVENT_GAL4:
  currentScreen = galResult;
  galResult.addScreenText2(50,500, "The Parker Solar Probe", color(255),font);
  galResult.addScreenText3(50,560, "Owned by: NASA", color(255),font);
  galResult.addScreenText4(50,650, "Top speed: 586,000 kph ", color(255),font);
  galResult.addScreenText5(50,690, "Parker holds the closest-distance record,\n getting a mere 8.5 million km \nfrom the sun's surface, which is \nknown as the photosphere.", color(255),font);
  galResult.changeBackground(parker);
  screenList.add(galResult);
  return;
  
    }
    

  }
  
}
//Ignacy Sus 29/03 adding keyboard input for the searchBar class and the search screen, 
// Ignacy Sus 30/03 adding the checkKeys[i] with an if statement to fix the shift and capslock bug which made a search impossible ( except for numbers), as it was also labelled as a key when typing
  void keyPressed(){
    
    if(focus !=null){
      for (int i = 0; i<checkKeys.length;i++){
        if (checkKeys[i]==key ){
          focus.append(key);
        }
      }
    }
  }
 void mouseReleased(){  //Anand Sainbileg made mouseReleased to make the widget's color change back to normal after releasing the mouse off of it
  int g = 0;
  for (int i = 0; i < currentScreen.screenWidgets.size(); i++){      //Anand Sainbileg fixed bugs on this method
      Widget aWidget = (Widget) currentScreen.screenWidgets.get(i);
      if (aWidget.event < 406 || aWidget.event > 419)
      {
        aWidget.eventNumber(g);
      }
      }
  }

void displayAll(){
  for (int i=0; i<mySpaceObject.size(); i++){ // Tanuj Sood, creating a for loop to print all the instances, 11:25am 21/03/2022
    if (VARIATION*i<displayHeight)
    {
      text(mySpaceObject.get(i).getString(),TEXT_X,TEXT_Y+i*VARIATION); 
    }
    
  }
  
}
