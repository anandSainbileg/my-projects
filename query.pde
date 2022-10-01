class query{                                                                // Tanuj Sood, 30/03/22, created the query class

  int queryNum;
  int[] mass;
  int[] diameters;
  String[] name;
  int[] apogees;
  int[] perigees;
  query(int queryNum){

    this.queryNum=queryNum;
  }
  
  int dateToInt (SpaceObject object){                            // TANUJ SOOD, 12TH APRIL, implementing dateToInt method from PieChart class to query class to allow to use dates in queries
    //println("LDAT"+object.LDate);
    try{  
            
            String date = "";
            for ( int i =0; i<4;i++){
              date +=str(object.LDate.charAt(i));
            }
            int number = Integer.parseInt(date);
            //System.out.println("NUMBERS"+number); 
            return number;
        }
   catch (NumberFormatException e){
            println(e);
        }
        return FALSE_VALUE ;
  }
  int numOfOrbitalLaunches(ArrayList<SpaceObject> mySpaceObject){  // TANUJ SOOD, 13/04/22, CREATING METHOD/QUERY TO RETURN  TOTAL NUMBER OF ORBITAL LAUNCHES.
    
      int numOLaunches = 0;
     ArrayList<String> status = new ArrayList();
     for (int i = 0; i < mySpaceObject.size(); i++){
       if(mySpaceObject.get(i).status.length()>0){
       status.add(mySpaceObject.get(i).status);
     }
     }
     for (int i = 0; i < status.size(); i++){
       if (status.get(i).equalsIgnoreCase("O")){
         numOLaunches+=1;
       }
     }
    return numOLaunches;
  }
  int launchFreqInDecade(ArrayList<SpaceObject> mySpaceObject, int year){    // TANUJ SOOD, CREATED METHOD TO FIND LAUNCH IN GIVEN 10 YEAR SPAN
    
    int numLaunches=0;
    ArrayList<SpaceObject> dateList = new ArrayList();
    ArrayList<Integer> intDateList = new ArrayList();
     for (int i = 0; i < mySpaceObject.size(); i++)
    {
      if (mySpaceObject.get(i).LDate.length()>=4){
      dateList.add(mySpaceObject.get(i));
       }
    }
    for (int i = 0; i < dateList.size(); i++){
      int year1= dateToInt(dateList.get(i));
      intDateList.add(year1);
    }
     for (int i = 0; i < intDateList.size(); i++){
       if (intDateList.get(i)>=year && intDateList.get(i)<(year+10)){
         numLaunches+=1;
       }
     }
     return numLaunches;
  }
 // Tanuj Sood, 30/03/22, changed the query(method) to return num of launches per year by the us and su before and after the space race in a arrayList
 ArrayList<String> USlaunchesNum(ArrayList<SpaceObject> mySpaceObject){           
  
   
   ArrayList<String> countryList = new ArrayList();
   ArrayList<SpaceObject> dateList = new ArrayList();
   ArrayList<Integer> intDateList = new ArrayList();
   ArrayList<String> beforeAfterNum = new ArrayList();
    for (int i = 0; i < mySpaceObject.size(); i++)
    {
      if (mySpaceObject.get(i).LDate.length()>=4){
      dateList.add(mySpaceObject.get(i));
      countryList.add(mySpaceObject.get(i).state);
      }
    }
    for (int i = 0; i < dateList.size(); i++){
      int year= dateToInt(dateList.get(i));
      intDateList.add(year);
    }
    int numLaunchesBefore1975US=0;
    int numLaunchesAfter1975US=0;
    int numLaunchesBefore1975SU=0;
    int numLaunchesAfter1975SU=0;
    for (int i = 0; i <countryList.size(); i++){

      if (countryList.get(i).equalsIgnoreCase("US")){
        
        if (intDateList.get(i)>1975){
        numLaunchesAfter1975US+=1;
        }
        else {
          numLaunchesBefore1975US+=1;
        } //<>//
      }
      if (countryList.get(i).equalsIgnoreCase("SU")){
        
        if (intDateList.get(i)>1975){
        numLaunchesAfter1975SU+=1;
        }
        else {
          numLaunchesBefore1975SU+=1;
        }
      }
    }
    numLaunchesBefore1975US=numLaunchesBefore1975US/18;
    numLaunchesAfter1975US= numLaunchesAfter1975US/47;
    numLaunchesBefore1975SU=numLaunchesBefore1975SU/18;
    numLaunchesAfter1975SU= numLaunchesAfter1975SU/47;
    String n= Integer.toString(numLaunchesBefore1975US); //<>//
    String n2= Integer.toString(numLaunchesAfter1975US);
    String n3= Integer.toString(numLaunchesBefore1975SU);
    String n4= Integer.toString(numLaunchesAfter1975SU);
    beforeAfterNum.add(n);
    beforeAfterNum.add(n2);
    beforeAfterNum.add(n3);
    beforeAfterNum.add(n4);
    return beforeAfterNum;
 }
 
  ArrayList<Float> getLengthArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 24/3/22 Added method which returns an arraylist of the lengths of ships.
  {
    ArrayList<Float> lengths = new ArrayList();
    for (int i = 0; i < mySpaceObject.size(); i++)
    {
      lengths.add(mySpaceObject.get(i).length);
    }
    return lengths;
  }
  float maxLength(ArrayList<SpaceObject> mySpaceObject){                // TANUJ SOOD, CREATED METHOD TO RETURN FLOAT MAX LENGTH IN THE DATASET.
   
    ArrayList<Float> lengthList= new ArrayList();
    lengthList = getLengthArrayList(mySpaceObject);
    float maxLength = 0;
    for (int i = 0; i < lengthList.size(); i++){
      if (lengthList.get(i)>maxLength){
        maxLength = lengthList.get(i);
      }
    }
    
    return maxLength;
  }
  float maxMassdata(ArrayList<SpaceObject> mySpaceObject){          // TANUJ SOOD, CREATED METHOD TO RETURN FLOAT MAX MASS IN THE DATASET.
   
    ArrayList<Float> massList= new ArrayList();
     for (int i = 0; i < mySpaceObject.size(); i++)
    {
      massList.add(mySpaceObject.get(i).mass);
    }
    float maxMassdata = 0;
    for (int i = 0; i < massList.size(); i++){
      if (massList.get(i)>maxMassdata){
        maxMassdata = massList.get(i);
      }
    }
    
    return maxMassdata;
  }

  Float getMaxFloat(ArrayList<Float> floatArrayList)//Gerard Moylan 24/3/22 Added method which finds the max length
  {                                                 //Gerard Moylan 2/4/22 Rewrote the method to find the max 
    Float maxFloat = 0.0;                           //float value of a float arrayList, renders some other methods obsolete
    for (int i = 0; i <floatArrayList.size(); i++)
    {
      if (floatArrayList.get(i) > maxFloat)
      {
       maxFloat = floatArrayList.get(i); 
      }
    }
    return maxFloat;
  }
  Float getMinFloat(ArrayList<Float> floatArrayList)//Gerard Moylan 5/4/22 Added method to find the minimum value in an arrayList of floats.
  {                                                 //Only realising after writing the whole method that I may have no use for
  Float minFloat = 10000.0;
    try 
    {
      minFloat = floatArrayList.get(0);
    }catch (Exception e){println(e);}
    for (int i = 0; i < floatArrayList.size(); i++)
    {
      if (floatArrayList.get(i) < minFloat)
      {
        minFloat = floatArrayList.get(i);
      }
    }
    return minFloat;
  }

  int getMax(int[] SpaceObjectList){  //Anand Sainbileg made a method to get the maximum mass from the data
    int maxMass = (int)SpaceObjectList[0];           // Anand Sainbileg fixed the method 04/01/2022
  for(int i =0; i<SpaceObjectList.length; i++){      // Anand Sainbileg fixed the method 04/12/2022
      if(SpaceObjectList[i] > maxMass){
        maxMass = (int)SpaceObjectList[i];
        }
      }
    return maxMass;
  }
  int getMin(int[] SpaceObjectList){
    int min = (int)SpaceObjectList[0];           
  for(int i =0; i<SpaceObjectList.length; i++){      
      if(SpaceObjectList[i] < min){
        min = (int)SpaceObjectList[i];
        }
      }
    return min;
  }
  int getNextMass(ArrayList<Integer> massList){  // Anand Sainbileg, to get masses starting from the heaviest to lightest 04/07/2022 (undone)
  int nextMass = massList.get(massList.size()-2);
  massList.remove(massList.size()-1);
   return nextMass;
  }
  void getShipsPerState(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 30/3/22
{
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    shipStates.add(mySpaceObject.get(i).state);
  }
}
ArrayList<String> getListOfUniqueStates(ArrayList<String> shipStates)//Gerard Moylan 30/3/22
{
  ArrayList<String> uniqueStates = new ArrayList();
  for (int i = 0; i < shipStates.size(); i++)
  {
      if (!uniqueStates.contains(shipStates.get(i)))
      {
        uniqueStates.add(shipStates.get(i));
      }
  }
  return uniqueStates;
}
ArrayList<Float> getMassArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 30/3/22 Had to make it an arraylist of floats so that it worked with the methods i used
{
  ArrayList<Float> massArrayList = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    if (mySpaceObject.get(i).mass > 0.0)
    {
      massArrayList.add(Float.valueOf(mySpaceObject.get(i).mass));
    }
  }
  return massArrayList;
}
ArrayList<Float> getDiameterArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 30/3/22
{
  ArrayList<Float> diameterArrayList = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  { //<>//
    diameterArrayList.add(mySpaceObject.get(i).diameter);
  }
  return diameterArrayList;
}


ArrayList<Float> getYearArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 6/4/22 gonna be used for graphs and stuff
{
  ArrayList<Float> listOfYears = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    String year = "";
    char[] yearInChars = new char[4];
    for (int j = 0; j < 4; j++)
    {
      try //<>//
      {
      char[] dateInChars = mySpaceObject.get(i).LDate.toCharArray();
      yearInChars[j] = dateInChars[j];
      }catch (Exception e) {}
    }
    year = String.valueOf(yearInChars);
    try
    {
      listOfYears.add(Float.valueOf(year));
    }catch (Exception e) {}
  }
  return listOfYears;
}
ArrayList<Float> getPerigeeArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 6/4/22
{
  ArrayList<Float> perigeeArrayList = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    perigeeArrayList.add(Float.valueOf(mySpaceObject.get(i).perigee));
  }
  return perigeeArrayList;
}
ArrayList<Float> getApogeeArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 6/4/22
{
  ArrayList<Float> apogeeArrayList = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    apogeeArrayList.add(Float.valueOf(mySpaceObject.get(i).apogee));
  }
  return apogeeArrayList;
}
ArrayList<Float> getIncArrayList(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 6/4/22
{
  ArrayList<Float> incArrayList = new ArrayList();
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    incArrayList.add(mySpaceObject.get(i).inc);
  }
  return incArrayList;
}

int[] sortMassAsc(){                                              //  TANUJ SOOD, CREATED QUERY TO SORT THE DATA IN TERMS OF MASS ASCENDINGLY
  
    name = new String[mySpaceObject.size()];
    mass = new int[mySpaceObject.size()];
  for (int i=0;i<mySpaceObject.size();i++){
    mass[i]=(int)(mySpaceObject.get(i).mass);
    name[i]=(mySpaceObject.get(i).name);
  }
  //mass=sort(mass);
  for (int i = 0; i < mass.length; i++)   
    {  
      for (int j = i + 1; j < mass.length; j++)    //<>//
      {  
        String tempS ="";
        int tmp = 0;  
        if (mass[i] > mass[j])   
        {  
          tmp = mass[i];  
          mass[i] = mass[j];  
          mass[j] = tmp;  
          
          tempS = name[i];
          name[i] = name[j];
          name[j] = tempS;
        }
        if(mass[i] == 0){
         i = i + 1;
         }
       }  
    }
  return mass; //<>//
}
int[] sortDiameterAsc(){                                                //  Anand Sainbileg 04/12/2022
    diameters = new int[mySpaceObject.size()];
  for (int i=0;i<mySpaceObject.size();i++){
    diameters[i]=(int)(mySpaceObject.get(i).diameter);
  }
  //mass=sort(mass);
  for (int i = 0; i < diameters.length; i++)   
    {  
      for (int j = i + 1; j < diameters.length; j++)   {
        int tmp = 0;  
        if (diameters[i] > diameters[j])   
        {  
          tmp = diameters[i];  
          diameters[i] = diameters[j];  
          diameters[j] = tmp;  
         }
       }  
    }
  return diameters;
}
String[] returnName(){
  return name;
}


int[] sortMassDesc(){                                           //  TANUJ SOOD, CREATED QUERY TO SORT THE DATA IN TERMS OF MASS DESCENDINGLY
    
   name = new String[mySpaceObject.size()];
    mass = new int[mySpaceObject.size()];
  for (int i=0;i<mySpaceObject.size();i++){
    mass[i]=(int)(mySpaceObject.get(i).mass);
    name[i]=(mySpaceObject.get(i).name);
  }
  //mass=sort(mass);
  for (int i = 0; i < mass.length; i++)   
    {  
      for (int j = i + 1; j < mass.length; j++)   
      {  
        String tempS ="";
        int tmp = 0;  
        if (mass[i] < mass[j])   
        {  
          tmp = mass[i];  
          mass[i] = mass[j];  
          mass[j] = tmp;  
          
          tempS = name[i];
          name[i] = name[j];
          name[j] = tempS;
        }  
       }  
    }
  return mass;
}
float getMedian(ArrayList<Float> massArray){            // Anand Sainbileg implemented method 04/11/2022
float median = 0;
if(massArray.size() % 2 == 0){
float sumMid = massArray.get(massArray.size() / 2) + massArray.get(massArray.size()/2 - 1);
median = sumMid / 2;
}
else{
  median = massArray.get(massArray.size()/2);
}
return median;
}
int getSum(int[] massArray){           // Anand Sainbileg implemented method 04/11/2022
int sum = 0;
for(int v = 0; v<massArray.length; v++){
  int index = massArray[v];
  if(index < 0){
  index = index * (-1);
  sum = sum + index;
  }else{
  sum = sum + index;
  }
}
return sum;
}
int getMean(int[] massArray, int sum){           // Anand Sainbileg implemented method 04/11/2022
  int mean = sum / massArray.length;
  return mean;
}
double getSd(int[] massArray, int mean){           // Anand Sainbileg implemented method 04/11/2022
double sd = 0;
double sum = 0;
for(int i = 0; i<massArray.length; i++){
 sum += (double)Math.pow((double)massArray[i] - (double)mean, 2);
}
double avg = sum / massArray.length;
sd = Math.sqrt(avg);
return sd;
}
int[] sortApogeeAsc(){                                              //  Anand Sainbileg 04/12/2022
    apogees = new int[mySpaceObject.size()];
  for (int i=0;i<mySpaceObject.size();i++){
    apogees[i]=(int)(mySpaceObject.get(i).apogee);
  }
  for (int i = 0; i < apogees.length; i++)   
    {  
      for (int j = i + 1; j < apogees.length; j++)   {
        int tmp = 0;  
        if (apogees[i] > apogees[j])   
        {  
          tmp = apogees[i];  
          apogees[i] = apogees[j];  
          apogees[j] = tmp;  
         }  
       }  
    }
  return apogees;
}
int[] sortPerigeeAsc(){                                                //  Anand Sainbileg 04/12/2022
    perigees = new int[mySpaceObject.size()];
  for (int i=0;i<mySpaceObject.size();i++){
    perigees[i]=(int)(mySpaceObject.get(i).perigee);
  }
  for (int i = 0; i < perigees.length; i++)   
    {  
      for (int j = i + 1; j < perigees.length; j++)   {
        int tmp = 0;  
        if (perigees[i] > perigees[j])   
        {  
          tmp = perigees[i];  
          perigees[i] = perigees[j];  
          perigees[j] = tmp;  
         
        }  
       }  
    }
  return perigees;
}
void getArrayLists(ArrayList<SpaceObject> mySpaceObject)//Gerard Moylan 9/4/22 Wrote this method to cut down on the amount of times we cycle through the mySpaceObjects arraylist.
{
  for (int i = 0; i < mySpaceObject.size(); i++)
  {
    lengthArrayList.add(mySpaceObject.get(i).length);
    if (mySpaceObject.get(i).mass > 0.0)
    {
      massArrayList.add(mySpaceObject.get(i).mass);
    }
    diameterArrayList.add(mySpaceObject.get(i).diameter);
    apogeeArrayList.add(mySpaceObject.get(i).apogee);
    perigeeArrayList.add(Float.valueOf(mySpaceObject.get(i).perigee));
    incArrayList.add(mySpaceObject.get(i).inc);
  }
}
}
