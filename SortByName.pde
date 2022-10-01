// Ignacy Sus 12/04 I found this way the most efficient to sort live the whole 50k dataset! By creating a custom comparator. (All my custom comparators arae analogical)
class SortByName implements Comparator<SpaceObject>{
  @Override
  int compare(SpaceObject firstObject, SpaceObject secondObject){
    return firstObject.name.compareTo(secondObject.name);
  }
  
}
