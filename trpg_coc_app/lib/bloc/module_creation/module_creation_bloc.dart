import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_repository.dart';
import 'module_creation_event.dart';
class ModuleCreationBloc extends TimecostOperationBloc {
  @override
  TimecostOperationState get initialState => NotInitialized();
  ModuleCreationRepository moduleCreationRepository = new ModuleCreationRepository();
  ModuleCreationBloc(){
    operator.addEventActionPair(TryInitialize(), moduleCreationRepository.init);
    operator.addEventActionPair(SubmmitModule(), moduleCreationRepository.submmit);
  }
  getModule()=>moduleCreationRepository.modCreate;
  @override
  Future<void> close() {
    return super.close();
  }

}
