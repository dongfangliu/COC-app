import 'package:equatable/equatable.dart';
abstract class TimecostOperationState extends Equatable {
  const TimecostOperationState();
}
class NotInitialized extends TimecostOperationState {
  @override
  List<Object> get props => [];
}
class ReadyToOperate extends TimecostOperationState {
  @override
  List<Object> get props => [];
}

class Operating  extends TimecostOperationState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class OperationFailure extends TimecostOperationState{
  String msg;
  @override
  // TODO: implement props
  List<Object> get props => [msg];

  OperationFailure(this.msg);

}
class OperationSuccess extends TimecostOperationState{
  String msg="";
  @override
  // TODO: implement props
  List<Object> get props => [msg];

  OperationSuccess();

}
