

class SpaceObject //Anand Sainbileg addeed class to store data points (I believe that the dataPoints class is useless)
{
  String data;
  String JCAT; int satcat; String piece; String type; String name; String PLName; String LDate; 
  String parent; String SDate; String primary; String DDate; String status; String dest;
  String owner; String state; String manufacturer; String bus; String motor; float mass;
  boolean massFlag; float dryMass; boolean dryFlag; float totMass; boolean totFlag; float length;
  boolean lFlag; float diameter; boolean dFlag; float span; boolean spanFlag; String shape;
  String ODate; int perigee; boolean PF; float apogee; boolean AF; float inc;
  boolean IF; String opOrbit; String OQUAL; String altNames;
  
  SpaceObject(String data)  //Gerard Moylan, Added the data points to the class and set them up in the constructor method 5pm 23/3/2022
  {
    this.data = data;
    String[] spaceData = data.split("\t");
    JCAT = spaceData[0];
    satcat = spaceData[1].equalsIgnoreCase("-") ? 0 : Integer.valueOf(spaceData[1]);;
    piece = spaceData[2];
    type = spaceData[3];
    name = spaceData[4];
    PLName = spaceData[5];
    LDate = spaceData[6];
    parent = spaceData[7];
    SDate = spaceData[8];
    primary = spaceData[9];
    DDate = spaceData[10];
    status = spaceData[11];
    dest = spaceData[12];
    owner = spaceData[13];
    state = spaceData[14];
    manufacturer = spaceData[15];
    bus = spaceData[16];
    motor = spaceData[17];
    mass = spaceData[18].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[18]);
    massFlag = spaceData[19] == "?" ? true : false;
    dryMass = spaceData[20].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[20]);;
    dryFlag = spaceData[21] == "?" ? true : false;
    totMass = spaceData[22].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[22]);
    totFlag = spaceData[23] == "?" ? true : false;
    length = spaceData[24].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[24]);
    lFlag = spaceData[25] == "?" ? true : false;
    diameter = spaceData[26].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[26]);
    dFlag = spaceData[27] == "?" ? true : false;
    span = spaceData[28].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[28]);
    spanFlag = spaceData[29] == "?" ? true : false;
    shape = spaceData[30]; ODate = spaceData[31];
    perigee = spaceData[32].equalsIgnoreCase("-") ? 0 : Integer.valueOf(spaceData[32]);
    PF = spaceData[33] == "?" ? true : false; 
    apogee = spaceData[34].equalsIgnoreCase("     inf") ? Float.POSITIVE_INFINITY : spaceData[34].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[34]); 
    AF = spaceData[35] == "?" ? true : false;
    inc = spaceData[36].equalsIgnoreCase("-") ? Float.NaN : Float.valueOf(spaceData[36]);
    IF = spaceData[37] == "?" ? true : false;
    opOrbit = spaceData[38];
    OQUAL = spaceData[39];;
    altNames = spaceData[40];

  }
  String getString ()   //Ignacy Sus 21/03/2022  Adding the getString() function to easily print the lines to screen (task week 1 )
  {
    return data;
  }
  
}
