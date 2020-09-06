import 'package:meta/meta.dart';

import 'package:trpgcocapp/data/char_sheet/char_data_part.dart';
import 'package:trpgcocapp/data/char_sheet/info_data.dart';
import 'package:trpgcocapp/data/char_sheet/attr_data.dart';
import 'package:trpgcocapp/data/char_sheet/occu_data.dart';
import 'package:trpgcocapp/data/char_sheet/skill_data.dart';
import 'package:trpgcocapp/data/char_sheet/combat_data.dart';
import 'package:trpgcocapp/data/char_sheet/invt_data.dart';
import 'package:trpgcocapp/data/char_sheet/story_data.dart';

import 'package:trpgcocapp/data/char_sheet/data_repository/occupations.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';

class CharSheetState {
  final int currentPage;
  final List<String> finishedPages;
  final Map<String, CharDataPart> charData;

  CharSheetState({
    @required this.currentPage,
    @required this.finishedPages,
    @required this.charData,
  });

  // Initializer (called in CharSheetBloc)
  factory CharSheetState.empty(bool isNPC) {
    Map<String, CharDataPart> data = {};
    if (isNPC) {
      data = {
        "info" : InfoData(),
        "attr" : AttrData(),
        "occu" : OccuData(),
      };
    } else {
      data = {
        "info" : InfoData(),
        "attr" : AttrData(),
        "occu" : OccuData(),
        "skill" : SkillData(occu: null, attrData: AttrData()),
        "combat" : CombatData(),
        "invt" : InvtData(),
        "story" : StoryData(),
      };
    }
    return CharSheetState(
      currentPage: 0,
      finishedPages: [],
      charData: data,
    );
  }

  CharSheetState copyWith ({
    int currentPage,
    List<String> finishedPages,
    Map<String, CharDataPart> data,
  }) {
    return CharSheetState(
      currentPage: currentPage ?? this.currentPage,
      finishedPages: finishedPages ?? this.finishedPages,
      charData: data ?? this.charData,
    );
  }

  CharSheetState updatePage(int newPage) {
    return copyWith(currentPage: newPage);
  }

  CharSheetState updateData(String pageTag, CharDataPart newData) {
    // Initialize SkillData according to occu if needed
    if (pageTag == "occu") {
      // Obtain and compare old and new occupation data
      OccuData oldOccu = charData["occu"];
      OccuData newOccu = newData;
      if (!oldOccu.isFinished() || oldOccu.occu.index != newOccu.occu.index) {
        // Initialize skill data use newOccu.occu
        charData["skill"] = SkillData(occu: newOccu.occu, attrData: charData["attr"]);
      }
    }
    // Update SkillPoints in SkillData
    if (pageTag == "attr" && charData["occu"].isFinished()) {
      OccuData occuData = charData["occu"];
      AttrData attrData = charData['attr'];
      SkillData skillData = charData["skill"];
      skillData.updateSkillPoints(occuData.occu, attrData);
    }

    // Update character data
    charData.update(pageTag, (oldData) => (newData));

    // Update the list of finished pages
    if (newData.isFinished()) {
      if (!finishedPages.contains(pageTag)) {
        finishedPages.add(pageTag);
      }
    } else {
      if(finishedPages.contains(pageTag)) {
        finishedPages.remove(pageTag);
      }
    }

    return copyWith();
  }

  // TODO factory CharSheetState.finished() {}

  bool isPageFinished(String pageTag) {
    if (finishedPages.contains(pageTag)) {
      return true;
    } else {
      return false;
    }
  }
}