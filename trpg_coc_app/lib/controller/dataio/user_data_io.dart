import 'package:shared_preferences/shared_preferences.dart';
import 'package:trpgcocapp/data/app_user.dart';

class UserDataIO {
  UserDataIO(AppUser initCurrentUser) {}

  static void writeUser(AppUser currentUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);
    prefs.setString('user_username', currentUser.username);
    prefs.setString('user_phone', currentUser.phone);
    //prefs.setString('user_email', currentUser.email);
  }

  static Future<AppUser> readUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.getBool('loggedIn')) {
      return null;
    }
    String username = prefs.getString('user_username');
    String phone = prefs.getString('user_phone');
    String email = prefs.getString('user_email');
    AppUser currentUser = AppUser(
      username: username,
      phone: phone,
      //initEmail: email
    );
    return currentUser;
  }
}