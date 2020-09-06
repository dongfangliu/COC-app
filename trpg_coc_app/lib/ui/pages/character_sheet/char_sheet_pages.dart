library CharSheetPages;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_bloc.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_events.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_states.dart';
import 'package:trpgcocapp/data/char_sheet/char_data_part.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/weapons.dart';
import 'package:trpgcocapp/styles/theme.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/skills.dart';
import 'package:trpgcocapp/data/char_sheet/data_repository/occupations.dart';
import 'dart:math';

import 'package:trpgcocapp/data/char_sheet/info_data.dart';
import 'package:trpgcocapp/data/char_sheet/attr_data.dart';
import 'package:trpgcocapp/data/char_sheet/occu_data.dart';
import 'package:trpgcocapp/data/char_sheet/skill_data.dart';
import 'package:trpgcocapp/data/char_sheet/combat_data.dart';
import 'package:trpgcocapp/data/char_sheet/invt_data.dart';
import 'package:trpgcocapp/data/char_sheet/story_data.dart';

part 'char_sheet_page_attr.dart';
part 'char_sheet_page_combat.dart';
part 'char_sheet_page_info.dart';
part 'char_sheet_page_invt.dart';
part 'char_sheet_page_occu.dart';
part 'char_sheet_page_skill.dart';
part 'char_sheet_page_story.dart';

abstract class CharSheetPage extends StatefulWidget {
  String pageTag;
}