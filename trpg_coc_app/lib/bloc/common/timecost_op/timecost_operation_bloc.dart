import 'dart:async';
import 'timecost_operator.dart';

import 'timecost_operation_state.dart';
import 'timecost_operation_event.dart';
import 'package:bloc/bloc.dart';

class TimecostOperationBloc extends Bloc<TimecostOperationEvent,TimecostOperationState> {
  @override
  TimecostOperationState get initialState => NotInitialized();
  TimecostOperator operator = TimecostOperator();

  @override
  Stream<TimecostOperationState> mapEventToState(
      TimecostOperationEvent event,
  ) async* {
    if((state is NotInitialized )&&(event is TryInitialize)){
      await operator.takeAction(event);
      yield ReadyToOperate();
    }
    if (state is ReadyToOperate) {
      yield* _mapForReadyState(event);
    }else if(state is OperationFailure){
      if(event is OperationResultGot){
        yield ReadyToOperate();
      }
    }else if(state is OperationSuccess) {
      if(event is OperationResultGot){
        yield ReadyToOperate();
      }
    }
  }

  Stream<TimecostOperationState> _mapForReadyState(TimecostOperationEvent event) async* {
    if (event is TakeOperation){
      OperateResult result;
      yield Operating();
      result = await operator.takeAction(event);
      if (result.isSuccess) {
        yield OperationSuccess();
      } else {
        yield OperationFailure(result.msg);
      }
    }

  }
}
