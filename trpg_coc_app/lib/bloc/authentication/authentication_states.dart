import 'package:trpgcocapp/data/app_user.dart';

abstract class AUTState {
  AUTState();
}

class Uninitialized extends AUTState {}

class Authenticated extends AUTState {
  AppUser currentUser;

  Authenticated(this.currentUser);
}

class Unauthenticated extends AUTState {}