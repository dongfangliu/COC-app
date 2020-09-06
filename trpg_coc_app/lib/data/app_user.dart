import 'package:data_plugin/bmob/type/bmob_date.dart';
import 'package:data_plugin/bmob/type/bmob_file.dart';

class AppUser{
  String bmobObjectID;
  String username;
  String phone;
  //String email;
  bool gender;
  bool genderShow;
  DateTime birthday;
  bool birthdayShow;
  BmobFile avatar;
  String sessionToken;

  AppUser({
    this.username,
    this.phone,
    this.gender,
    this.genderShow,
    this.birthday,
    this.birthdayShow,
    this.bmobObjectID,
    this.avatar,
    this.sessionToken
  });

  static AppUser fromJSON(Map data) {
    return AppUser(
      username: data['username'],
      phone: data['mobilePhoneNumber'],
      gender: data['gender'],
      genderShow: data['genderShow'],
      birthday: DateTime.parse(BmobDate.fromJson(data['birthday']).iso),
      birthdayShow: data['birthdayShow'],
      bmobObjectID: data['objectId'],
      avatar: BmobFile.fromJson(data['avatar']),
      sessionToken: data['sessionToken']
    );
  }

  @override
  String toString(){
    String msg = "ObjectID: " + bmobObjectID;
    msg += ", username: " + username;
    if (phone != null) {
      msg += ", phone: " + phone;
    }
    if (gender == false) {
      msg += ", gender: " + "male";
    }
    if (gender == true) {
      msg += ", gender: " + "femail";
    }
    if (genderShow != null) {
      msg += ", gender show: " + genderShow.toString();
    }
    if (birthday != null) {
      msg += ", birthday: " + birthday.toIso8601String();
    }
    if (birthdayShow != null) {
      msg += ", birthday show: " + birthdayShow.toString();
    }
    if (avatar != null) {
      msg += ", avatar: " + avatar.toString();
    }
    if (sessionToken != null) {
      msg += ", sessionToken: " + sessionToken;
    }
    return msg;
  }

  Map<String, dynamic> toMap(){
    BmobDate bmobDate = BmobDate();
    bmobDate.setDate(birthday);
    Map<String, dynamic> data = {
      'username' : username,
      'mobilePhoneNumber' : phone,
      'birthday' : bmobDate,
      'birthdayShow' : birthdayShow,
      'gender' : gender,
      'genderShow' : genderShow,
      'avatar' : avatar
    };
    return data;
  }
}