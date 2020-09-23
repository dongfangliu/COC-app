import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/module_demostration/module_demo_repository.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';
import 'module_demo_event.dart';
class ModuleDemoBloc extends TimecostOperationBloc {
  StoryModUsing mod;
  @override
  TimecostOperationState get initialState => NotInitialized();
  ModuleDemoBloc(){
    operator.addEventActionPair(TryInitialize(), ModuleUsingHelper.init);
  }
  @override
  Future<void> close() {
    return super.close();
  }

}
