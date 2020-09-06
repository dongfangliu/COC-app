import 'package:bloc/bloc.dart';
import 'package:data_plugin/bmob/bmob_dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_events.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_states.dart';
import 'package:trpgcocapp/controller/current_user.dart';

class AUTBloc extends Bloc<AUTEvent, AUTState> {
  @override
  AUTState get initialState => Uninitialized();

  @override
  Stream<AUTState> mapEventToState(AUTEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AUTState> _mapAppStartedToState() async* {
    yield Uninitialized();
  }

  Stream<AUTState> _mapLoggedInToState(LoggedIn event) async* {
    CurrentUser.getInstance().setUser(
      newObjectID: event.currentUser.bmobObjectID,
      newSessionToken: event.currentUser.sessionToken,
      newUsername: event.currentUser.username
    );
    BmobDio.getInstance().setSessionToken(event.currentUser.sessionToken);
    yield Authenticated(event.currentUser);
  }

  Stream<AUTState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }

}