import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

enum RequestType { SAVE, DELETE, UPDATE, QUERY, QUERIES }

abstract class RequestEvent extends Equatable {
  const RequestEvent();
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Request<T extends BmobObject> extends RequestEvent {
  RequestType _type;
  T _data;
  BmobQuery<T> _query;
  Request.querySingle(this._query) {
    this._type = RequestType.QUERY;
  }
  Request.queryObjects(this._query) {
    this._type = RequestType.QUERIES;
  }
  Request.Object(this._type, this._data);

  Future execute() {
    if (_type == RequestType.SAVE) {
      return _data.save();
    }
    if (_type == RequestType.DELETE) {
      return _data.delete();
    }
    if (_type == RequestType.UPDATE) {
      return _data.update();
    }
    if (_type == RequestType.QUERIES) {
      return _query.queryObjects();
    }
  }
  @override
  List<Object> get props => [_type,_data,_query];
}

class Tick extends RequestEvent {
  final int duration;

  const Tick({@required this.duration});

  @override
  List<Object> get props => [duration];

  @override
  String toString() => "Tick { duration: $duration }";
}

class Done extends RequestEvent {
  final dynamic response;

  Done(this.response);

  @override
  List<Object> get props => [this.response];
}

abstract class RequestState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RequestWaiting extends RequestState {
  final int duration;
  RequestWaiting(this.duration);

  @override
  List<Object> get props => [duration];
}

class RequestDone extends RequestState {
  dynamic response;
  bool timeExpired;
  RequestDone(this.response, this.timeExpired);
  @override
  List<Object> get props => [response,timeExpired];
}

class RequestReady extends RequestState {}

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final Ticker _ticker = Ticker();
  final int _duration = 10;
  StreamSubscription<int> _tickerSubscription;

  RequestBloc() {}
  @override
  // TODO: implement initialState
  RequestState get initialState => RequestReady();
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    if ((event is Request) &&
        ((state is RequestDone) || (state is RequestReady))) {
      (event as Request).execute().then((data) => add(Done(data)));
      yield RequestWaiting(_duration);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
          .tick(ticks: _duration)
          .listen((duration) => add(Tick(duration: duration)));
    }
    if ((event is Tick) && (state is RequestWaiting)) {
      yield event.duration > 0
          ? RequestWaiting(event.duration)
          : RequestDone(null, true);
    }
    if ((event is Done) && (state is RequestWaiting)) {
      yield RequestDone(event.response, false);
    }
  }
}
