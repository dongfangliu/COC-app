import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class TimecostOperationEvent extends Equatable {}
class TakeOperation extends TimecostOperationEvent{

  @override
  // TODO: implement props
  List<Object> get props => null;

  TakeOperation();
}

class OperationResultGot extends TimecostOperationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
