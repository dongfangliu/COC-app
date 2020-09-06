import 'package:trpgcocapp/data/app_user.dart';

enum LoginResultMsgs {
  WrongPhoneFormat, // 301
  VerifyCodeWrong, //207
  NetworkFailure, // 9015
  InfoIncorrect, // 101
  SMSSent,
  UnknownFailure,
  LoginSuccess
}

class LoginResult {
  LoginResultMsgs loginResultMsgs;
  AppUser currentUser;

  LoginResult(this.loginResultMsgs, this.currentUser);
}