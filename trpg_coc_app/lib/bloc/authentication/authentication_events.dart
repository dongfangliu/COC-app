import 'package:trpgcocapp/data/app_user.dart';

abstract class AUTEvent {}

class AppStarted extends AUTEvent {}

class LoggedIn extends AUTEvent {
  AppUser currentUser;

  LoggedIn(this.currentUser);
}

class LoggedOut extends AUTEvent {}