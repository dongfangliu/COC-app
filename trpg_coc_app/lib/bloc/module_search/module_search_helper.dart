import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';

class ModuleSearchHelper{
  static BmobQuery<StoryMod> constructQuery(String modName,bool vagueSearch){
    BmobQuery<StoryMod> bmobQuery = new BmobQuery();
    if(vagueSearch){
      bmobQuery.addWhereContains("moduleName", modName);
    }else{
      bmobQuery.addWhereEqualTo("moduleName", modName);
    }
    bmobQuery.setLimit(5);
    bmobQuery.setOrder("likes");
    return bmobQuery;
  }
  static BmobQuery<StoryMod> getRandomModuleSearchQuery(int  maxNum){
    BmobQuery<StoryMod> bmobQuery = new BmobQuery();
    bmobQuery.setLimit(maxNum);
    return bmobQuery;
  }

}