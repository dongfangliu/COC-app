import 'package:equatable/equatable.dart';
abstract class QueryServerState extends Equatable {
  const QueryServerState();
}

class ReadyToQuery extends QueryServerState {
  @override
  List<Object> get props => [];
}

class Quering  extends QueryServerState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}