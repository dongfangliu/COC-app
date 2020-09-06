import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'query.dart';
@immutable
abstract class QueryServerEvent extends Equatable {
  const QueryServerEvent();
}
class Query extends QueryServerEvent{
  Request request;
  @override
  // TODO: implement props
  List<Object> get props => [request];

  Query(this.request);

}

