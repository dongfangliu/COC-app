import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:trpgcocapp/bloc/login/login_events.dart';
import 'package:trpgcocapp/bloc/login/login_result.dart';
import 'package:trpgcocapp/bloc/login/login_states.dart';
import 'package:trpgcocapp/controller/Bmob/user_connector.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  @override
  LoginState get initialState => LoginUnenabled();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UpdateLoginInfo) {
      yield* mapUpdateLoginInfoToState(event);
    }
    if (event is LoginPressed) {
      yield* mapLoginPressedToState(event);
    }
  }

  Stream<LoginState> mapUpdateLoginInfoToState(UpdateLoginInfo event) async* {
    if (event.info1 != "" && event.info2 != "") {
      yield LoginEnabled();
    } else {
      yield LoginUnenabled();
    }
  }

  Stream<LoginState> mapLoginPressedToState(LoginPressed event) async* {
    Stream<LoginState> _processError(LoginResultMsgs msg) async* {
      if (msg == LoginResultMsgs.UnknownFailure) {
        yield (LoginFail("Unknown Failure"));
      }
      if (msg == LoginResultMsgs.NetworkFailure) {
        yield (LoginFail("Please check your network"));
      }
      if (msg == LoginResultMsgs.InfoIncorrect) {
        yield (LoginFail("Wrong username or password"));
      }
      if (msg == LoginResultMsgs.VerifyCodeWrong) {
        yield (LoginFail("Wrong verify code"));
      }
    }

    yield ProcessLogin();
    if (event.onPhonePage) {
      LoginResult loginResult = await UserConnector.loginBySMS(event.info1, event.info2);
      if (loginResult.loginResultMsgs == LoginResultMsgs.LoginSuccess){
        yield LoginSuccess(loginResult.currentUser);
      } else {
        yield* _processError(loginResult.loginResultMsgs);
      }
      yield LoginEnabled();
    } else {
      LoginResult loginResult = await UserConnector.loginByPWD(event.info1, event.info2);
      if (loginResult.loginResultMsgs == LoginResultMsgs.LoginSuccess) {
        yield LoginSuccess(loginResult.currentUser);
      } else {
        yield* _processError(loginResult.loginResultMsgs);
      }
    }
    yield LoginEnabled();
  }

}