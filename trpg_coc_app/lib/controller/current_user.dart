import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  String objectID;
  String username;
  // String password;
  String sessionToken;  // TODO 还不知道 sessionToken 怎么使用

  // region Singleton Pattern
  static CurrentUser _instance;

  factory CurrentUser() => getInstance();

  static CurrentUser getInstance() {
    if (_instance == null) {
      _instance = CurrentUser._();
    }
    return _instance;
  }
  // endregion
  CurrentUser._(){ readUser(); }

  Future<CurrentUser> readUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    objectID = sp.getString("objectID");
    username = sp.getString("username");
    sessionToken = sp.getString("sessionToken");
    return _instance;
  }

  void setUser({String newObjectID, String newUsername,
    String newSessionToken}) {
    if (newObjectID != null) { objectID = newObjectID; }
    if (newUsername != null) { username = newUsername; }
    if (newSessionToken != null) { sessionToken = newSessionToken; }

    SharedPreferences.getInstance().then((SharedPreferences sp){
      sp.setString("objectID", objectID);
      sp.setString("username", username);
      sp.setString("sessionToken", sessionToken);
    });
  }

  void removeUser() {
    SharedPreferences.getInstance().then((sp){
      sp.remove("objectID");
      sp.remove("username");
      sp.remove("password");
      sp.remove("sessionToken");
    });
  }
}