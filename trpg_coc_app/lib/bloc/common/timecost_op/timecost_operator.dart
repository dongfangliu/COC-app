
import 'timecost_operation_event.dart';

class OperateResult{

  String msg = "default empty operation";
  bool isSuccess = true;
  dynamic result = Null;
  OperateResult();
  OperateResult.custom(this.msg, this.isSuccess, this.result);

}
typedef Future<OperateResult>  OperateFunc();

class TimecostOperator{
  Map<TimecostOperationEvent,OperateFunc> _eventToAction =Map<TimecostOperationEvent,OperateFunc>();
  OperateResult lastResult =OperateResult();
  void addEventActionPair(TimecostOperationEvent event,OperateFunc operateFunc){
    if(_eventToAction.containsKey(event)) {
      print("Warning, $event is already has a mapped func");
    }
      _eventToAction[event] = operateFunc;

  }
  Future<OperateResult> takeAction(TimecostOperationEvent event) async {
    if(!_eventToAction.containsKey(event)){
      lastResult=OperateResult();
    }else{
      lastResult = await _eventToAction[event]();
    }
    return lastResult;
  }
}