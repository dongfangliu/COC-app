import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:trpgcocapp/bloc/query_server/query.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';

import 'module_search_helper.dart';

class ModuleSearchFilter {
  Map<ModRegion, bool> regionFilter = {};
  Map<ModEra, bool> eraFilter = {};
  int peopleMin = 0; //min max
  int peopleMax = 999; //min max
  int hoursMin = 0; //min max
  int hoursMax = 999; //min max

  bool filterFunc(StoryModUsing m){
    Map<ModRegion, bool> regfilter =Map.from( this.regionFilter);
    Map<ModEra, bool> erafilter =Map.from(this.eraFilter) ;

    regfilter.removeWhere((k, v) {
      return v == false;
    });
    List<ModRegion> regionConcerned =regfilter.keys.toList();

    erafilter.removeWhere((k, v) {
      return v == false;
    });
    List<ModEra> eraConcerned =erafilter.keys.toList();

    return (regionConcerned.contains(m.region)||(regionConcerned.length==0)) &&
        (eraConcerned.contains(m.era)||(eraConcerned.length==0)) &&
        (m.people_min >= peopleMin) &&
        (m.people_max <= peopleMax) &&
        (m.hours_min >= hoursMin) &&
        (m.hours_max <= hoursMax);
  }

//  List<StoryModUsing> getFilterResults(List<StoryModUsing> mods) {
//    this.regionFilter.removeWhere((k, v) {
//      return v == false;
//    });
//    List<ModRegion> regionConcerned = this.regionFilter.keys.toList();
//
//    this.eraFilter.removeWhere((k, v) {
//      return v == false;
//    });
//    List<ModEra> eraConcerned = this.eraFilter.keys.toList();
//    return mods
//        .where((m) => (regionConcerned.contains(m.region) &&
//            eraConcerned.contains(m.era) &&
//            (m.people_min >= peopleMin) &&
//            (m.people_max <= peopleMax) &&
//            (m.hours_min >= hoursMin) &&
//            (m.hours_max <= hoursMax)))
//        .toList();
//  }

  void resetAll() {
    for (ModRegion v in ModRegion.values) {
      regionFilter[v] = false;
    }
    for (ModEra v in ModEra.values) {
      eraFilter[v] = false;
    }
    peopleMin = 0; //min max
    peopleMax = 999; //min max
    hoursMin = 0; //min max
    hoursMax = 999; //mi
  }

  ModuleSearchFilter() {
    for (ModRegion v in ModRegion.values) {
      regionFilter[v] = false;
    }
    for (ModEra v in ModEra.values) {
      eraFilter[v] = false;
    }
  }
}

class ModuleSearchRepository {
  ModuleSearchFilter searchFilter = new ModuleSearchFilter();
  List<StoryModUsing> lastSearchResults;
  List<StoryModUsing> searchResults;
  List<StoryModUsing> filteredResults;

  Future<List<StoryModUsing>> searchByName(String name) async {
    this.lastSearchResults = searchResults;
    BmobQuery query = ModuleSearchHelper.constructQuery(name, false);
    Request<StoryModUsing> request = Request.queryObjects(query);
    this.searchResults = await request.execute();
    this.filteredResults.clear();
    this.searchFilter.resetAll();
    return searchResults;
  }

  Future<List<StoryModUsing>> searchAll({int num = 50}) async {
    this.lastSearchResults = searchResults;
    BmobQuery query = ModuleSearchHelper.getRandomModuleSearchQuery(num);
    Request<StoryModUsing> request = Request.queryObjects(query);
    this.searchResults = await request.execute();
    this.filteredResults.clear();
    this.searchFilter.resetAll();
    return searchResults;
  }

  int sortByTimeOld2New(StoryModUsing a, StoryModUsing b){
    return DateTime.parse(a.getUpdatedAt())
        .compareTo(DateTime.parse(b.getUpdatedAt()));
  }
  int sortByTimeNew2Old(StoryModUsing a, StoryModUsing b){
    return DateTime.parse(b.getUpdatedAt())
        .compareTo(DateTime.parse(a.getUpdatedAt()));
  }
  int sortByLikesLeast2Most(StoryModUsing a, StoryModUsing b) {
    return a.likes.compareTo(b.likes);
  }
  int sortByLikesMost2Least(StoryModUsing a, StoryModUsing b) {
    return b.likes.compareTo(a.likes);
  }
}
