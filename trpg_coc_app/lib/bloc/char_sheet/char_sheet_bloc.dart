import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_events.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_states.dart';

class CharSheetBloc extends Bloc<CharSheetEvent, CharSheetState>{
  bool isNPC;
  CharSheetBloc(this.isNPC);

  @override
  CharSheetState get initialState => CharSheetState.empty(isNPC);

  @override
  Stream<CharSheetState> mapEventToState(CharSheetEvent event) async* {
    if (event is PageChanged) {
      yield* mapPageChangedToState(event);
    }
    if (event is UpdateData) {
      yield* mapUpdateDataToState(event);
    }
  }

  Stream<CharSheetState> mapPageChangedToState(PageChanged event) async* {
    yield state.updatePage(event.newPage);
  }

  Stream<CharSheetState> mapUpdateDataToState(UpdateData event) async* {
    yield state.updateData(event.pageTag, event.newData);
  }

}