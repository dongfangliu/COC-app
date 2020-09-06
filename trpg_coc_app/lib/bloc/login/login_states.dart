import 'package:trpgcocapp/bloc/login/login_events.dart';
import 'package:trpgcocapp/data/app_user.dart';

abstract class LoginState {}

class LoginUnenabled extends LoginState {}

class LoginEnabled extends LoginState {}

class ProcessLogin extends LoginState {}

class LoginSuccess extends LoginState {
  AppUser currentUser;

  LoginSuccess(this.currentUser);
}

class LoginFail extends LoginState {
  String errorMsg;

  LoginFail(this.errorMsg);
}