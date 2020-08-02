import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:trpgcocapp/bloc/query_server/query_server_state.dart';
import 'query_server_event.dart';

class QueryServerBloc extends Bloc<QueryServerEvent,QueryServerState> {
  QueryServerState get initialState => ReadyToQuery();
  dynamic lastQueryResult = null;
  @override
  Stream<QueryServerState> mapEventToState(
      QueryServerEvent event,
      ) async* {
    if (state is ReadyToQuery) {
      yield* _mapForReadyState(event);
    }
  }

  Stream<QueryServerState> _mapForReadyState(QueryServerEvent event) async* {
    if (event is Query){
      yield Quering();
      lastQueryResult = await event.request.execute();
      yield ReadyToQuery();
    }
  }
  @override
  Future<void> close() {
    return super.close();
  }
}
