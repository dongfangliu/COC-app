import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';

class ModuleSearchHelper{
  static BmobQuery<StoryModUsing> constructQuery(String modName,bool vagueSearch){
    BmobQuery<StoryModUsing> bmobQuery = new BmobQuery();
    if(vagueSearch){
      bmobQuery.addWhereContains("moduleName", modName);
    }else{
      bmobQuery.addWhereEqualTo("moduleName", modName);
    }
    bmobQuery.setLimit(5);
    bmobQuery.setOrder("likes");
    return bmobQuery;
  }
  static BmobQuery<StoryModUsing> getRandomModuleSearchQuery(int  maxNum){
    BmobQuery<StoryModUsing> bmobQuery = new BmobQuery();
    bmobQuery.setLimit(maxNum);
    return bmobQuery;
  }

}