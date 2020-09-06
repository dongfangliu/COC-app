import 'package:trpgcocapp/data/char_sheet/char_data_part.dart';

abstract class CharSheetEvent {}

class PageChanged extends CharSheetEvent {
  int newPage;

  PageChanged(this.newPage);
}

class UpdateData extends CharSheetEvent {
  String pageTag;
  CharDataPart newData;

  UpdateData (this.pageTag, this.newData);
}
