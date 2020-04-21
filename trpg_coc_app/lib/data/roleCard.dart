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
  String name;
  int baseValue;
  int intrestPoint;
  int occupationPoint;
  int get value{return baseValue+intrestPoint+occupationPoint;}
}
class buff{
  String description;
}
class packable{
  String name;
  String description;
  int num;
  String loc;
}
class roleCard {
  int hp, mp,san,luck;
  int strength,constitution,size,appearance,intelligence,willpower,education,agility;
  bool alive;
  String name;
  String hometown;
  int age;
  int gender;
  String occupation;
  String residence;
  String era;
  String description;
  List<packable>  backpack;
  List<skill> skills;
  String additionInfo;
  bool isNPC;
}
