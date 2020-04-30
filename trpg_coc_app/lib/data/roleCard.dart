//Attr define
abstract class attr{
  String name;
  String description;
  String dtype;
}

abstract class valuableAttr<T> extends attr{
  T min;
  T max;
  T initial;
}
abstract class nonValuableAttr<T> extends attr{

}

// Attr evaluate

// Attr change
abstract class  Operator<T1,T2>{
  T2 over(List<T1> input);
}


class numericalOperation<T>{
 List<int> operator;
 List<T> values;

}
class boolOperation<T>{

}



class skill {
  roleCard card;
  String name="undefined";
  int baseValue=0;
  int intrestPoint=0;
  int occupationPoint=0;
  int get value{return baseValue+intrestPoint+occupationPoint;}
}
class buff{
  String description="undefined";
}
class packable{
  String name="undefined";
  String description="undefined";
  int num=-1;
  String loc="undefined";
}
class roleCard {
  int hp=0, mp=0,san=0,luck=0;
  int strength=0,constitution=0,size=0,appearance=0,intelligence=0,willpower=0,education=0,agility=0;
  bool alive=false;
  String name="undefined";
  String hometown="undefined";
  int age=-1;
  int gender=-1;
  String occupation="undefined";
  String residence="undefined";
  String era="undefined";
  String description="undefined";
  List<packable>  backpack=[];
  List<skill> skills=[];
  String additionInfo="undefined";
  bool isNPC=false;
}
