// Ignacy Sus 12/04 I found this way the most efficient to sort live the whole 50k dataset! By creating a custom comparator. (Analogical to other custom comparator i created)
class SortByMass implements Comparator<SpaceObject>{
  @Override
  int compare(SpaceObject firstObject, SpaceObject secondObject){
    return Integer.compare( (int)firstObject.mass,(int)secondObject.mass);
  }
  
}
