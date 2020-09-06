import 'package:meta/meta.dart';

abstract class LoginEvent{
  const LoginEvent();
}

class UpdateLoginInfo extends LoginEvent {
  bool onPhonePage;
  String info1; // Phone Number or Username
  String info2; // Verify Code or Password

  UpdateLoginInfo(this.onPhonePage, this.info1, this.info2);
}

class LoginPressed extends LoginEvent {
  bool onPhonePage;
  String info1; // Phone Number or Username
  String info2; // Verify Code or Password

  LoginPressed(this.onPhonePage, this.info1, this.info2);
}