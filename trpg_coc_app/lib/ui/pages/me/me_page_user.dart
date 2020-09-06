import 'dart:async';

import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/controller/Bmob/user_connector.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';

enum returnMsgs{
  OldPWDIncorrect,
}

class MePageUser extends StatefulWidget{
  AppUser currentUser;

  MePageUser(this.currentUser);

  @override
  _MePageUserState createState() => new _MePageUserState(currentUser);
}

class _MePageUserState extends State<MePageUser> {
  AppUser currentUser;

  _MePageUserState(this.currentUser);


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
      ),
      child: ListView(
        children: <Widget>[
          _buildSafeArea(),
          _infoSection(),
          _divider(),
          _avatarSection(),
          _usernameSection(),
          // TODO Password reset cannot work
          // _passwordSection(),
          _genderSection(),
          _birthdaySection()
          // _phoneSection(),
          // _emailSection()
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(
      height: 30,
      indent: 20,
      endIndent: 20,
      color: Colors.grey[800],
      thickness: 1,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _infoSection() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(
        'Personal Information',
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 30,
          decoration: TextDecoration.none,
          color: AppTheme.textColor
        ),
      ),
    );
  }

  Widget _avatarSection() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 40),
      child: GestureDetector(
        onTap: _onAvatarSectionTabbed,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Avatar',
                style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: AppTheme.textColor
                ),
              ),
            ),  // Avatar text
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
              backgroundColor: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
                size: 30,
              ),
            )
          ],
        ),
      )
    );
  }
  void _onAvatarSectionTabbed(){
    print("Avatar tabbed");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: AppTheme.backgroundColor,
          children: <Widget>[
            FlatButton(
              onPressed: (){ _onGalleryButtonPressed(context); },
              child: Text(
                'Choose from gallary',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 20,
                  color: Colors.grey
                ),
              ),
            ),
            FlatButton(
              onPressed: () {_onPhotoButtonPressed(context); },
              child: Text(
                'Take a photo',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 20,
                  color: Colors.grey
                ),
              ),
            ),
            _divider(),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 16,
                  color: Colors.grey
                ),
              ),
            ),
          ]
        );
      }
    );
  }
  void _onGalleryButtonPressed(BuildContext context){
    ImagePicker.pickImage(source: ImageSource.gallery).then((image){
      UserConnector.updateAvatar(currentUser, image.path);
      Navigator.pop(context);
    });
  }
  void _onPhotoButtonPressed(BuildContext context){
    print("Photo button pressed");
    ImagePicker.pickImage(source: ImageSource.camera).then((image){
      UserConnector.updateAvatar(currentUser, image.path);
      Navigator.pop(context);
    });
  }

  Widget _usernameSection() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 40),
      child: GestureDetector(
        onTap: _onUsernameSectionTabbed,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Username',
                style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 24,
                    decoration: TextDecoration.none,
                    color: AppTheme.textColor
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                currentUser.username,
                style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 16,
                    color: AppTheme.hintTextColor,
                    decoration: TextDecoration.none
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
                size: 30,
              ),
            )
          ],
        ),
      )
    );
  }
  void _onUsernameSectionTabbed() {
    print("Username tabbed");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _SetUsernamePage(currentUser);
        },
      ),
    );
  }

  Widget _passwordSection() {
    return Padding(
        padding: EdgeInsets.only(left: 20, top: 40),
        child: GestureDetector(
          onTap: _onPasswordSectionTabbed,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Password',
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 24,
                      decoration: TextDecoration.none,
                      color: AppTheme.textColor
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 20),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[800],
                  size: 30,
                ),
              )
            ],
          ),
        )
    );
  }
  void _onPasswordSectionTabbed() {
    print("Password tabbed");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _SetPasswordPage(currentUser);
        },
      ),
    );
  }

  Widget _genderSection() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 40),
      child: GestureDetector(
        onTap: _onGenderSectionTabbed,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Gender',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 24,
                  decoration: TextDecoration.none,
                  color: AppTheme.textColor
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                currentUser.gender ? "Female" : "Male",
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 16,
                  color: AppTheme.hintTextColor,
                  decoration: TextDecoration.none
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
  void _onGenderSectionTabbed() {
    print("Gender tabbed");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _SetGenderPage(currentUser);
        },
      ),
    );
  }

  Widget _birthdaySection() {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 40),
      child: GestureDetector(
        onTap: _onBirthdaySectionTabbed,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Age',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 24,
                  decoration: TextDecoration.none,
                  color: AppTheme.textColor
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Text(
                (DateTime.now().year - currentUser.birthday.year).toString(),
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 16,
                  color: AppTheme.hintTextColor,
                  decoration: TextDecoration.none
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[800],
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
  void _onBirthdaySectionTabbed() {
    print("Birthday tabbed");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return _SetBirthdayPage(currentUser);
        },
      ),
    );
  }
}

class _SetUsernamePage extends StatefulWidget{
  AppUser currentUser;

  _SetUsernamePage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetUsernamePageState createState() => _SetUsernamePageState(currentUser);
}
class _SetUsernamePageState extends State<_SetUsernamePage>{
  AppUser currentUser;
  TextEditingController _editController = TextEditingController();

  _SetUsernamePageState(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        trailing: _buildFinishButton(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSafeArea(),
            _infoSection(),
            _editSection()
          ],
        ),
      )
    );
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 16,
          color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _infoSection() {
    return Text(
      'Change your username',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }

  Widget _editSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _editController,
        placeholder: currentUser.username,
        placeholderStyle: TextStyle(
          fontFamily: 'papyrus',
          color: Colors.grey
        ),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: Colors.grey
            )
          )
        ),
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: Colors.grey
        ),
      ),
    );
  }

  void _onFinishButtonPressed(){
    currentUser.username = _editController.text;
    UserConnector.updateUser(currentUser).then((_){
      print("Change username finished");
      Navigator.pop(context);
    }).catchError((e){print(BmobError.convert(e));});
  }

}

class _SetPasswordPage extends StatefulWidget{
  AppUser currentUser;

  _SetPasswordPage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetPasswordPageState createState() => _SetPasswordPageState(currentUser);
}
class _SetPasswordPageState extends State<_SetPasswordPage>{
  AppUser currentUser;
  TextEditingController _oldPWDController = TextEditingController();
  TextEditingController _newPWDController = TextEditingController();
  TextEditingController _confirmNewPWDController = TextEditingController();

  _SetPasswordPageState(AppUser appUser){
    currentUser = appUser;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        trailing: _buildFinishButton(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSafeArea(),
            _infoSection(),
            _oldPWDSection(),
            _newPWDSection(),
            _confirmNewPWDSection()
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    _newPWDController.dispose();
    _confirmNewPWDController.dispose();
    super.dispose();
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 16,
            color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _infoSection() {
    return Text(
      'Change your password',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }

  Widget _oldPWDSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _oldPWDController,
        placeholder: 'Old password',
        placeholderStyle: TextStyle(
            fontFamily: 'papyrus',
            color: Colors.grey[800]
        ),
        decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Colors.grey
                )
            )
        ),
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 24,
            color: Colors.grey
        ),
      ),
    );
  }
  
  Widget _newPWDSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _newPWDController,
        placeholder: 'New password',
        placeholderStyle: TextStyle(
          fontFamily: 'papyrus',
          color: Colors.grey[800]
        ),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: Colors.grey
            )
          )
        ),
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: Colors.grey
        ),
      ),
    );
  }

  Widget _confirmNewPWDSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _confirmNewPWDController,
        placeholder: 'Confirm password',
        placeholderStyle: TextStyle(
          fontFamily: 'papyrus',
          color: Colors.grey[800]
        ),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: 2.0,
              color: Colors.grey
            )
          )
        ),
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: Colors.grey
        ),
      ),
    );
  }

  void _showInDialog(String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          content: Text(
            content,
            style: TextStyle(
              fontFamily: 'papyrus',
              fontSize: 24,
              color: Colors.grey
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      }
    );
  }

  void _onFinishButtonPressed(){
    String oldPWD = _oldPWDController.text;
    String newPWD = _newPWDController.text;
    String confirmNewPWD = _confirmNewPWDController.text;

    if (oldPWD == "") {
      _showInDialog("Please enter your old password");
      return;
    }
    if (newPWD == "") {
      _showInDialog("Please enter your new password");
      return;
    }
    if(confirmNewPWD == "") {
      _showInDialog("Please confirm your new password");
      return;
    }
    if (newPWD != confirmNewPWD) {
      _showInDialog("The new passwords do not match");
      return;
    }

    //BmobUserOperation bmobUserOperation = BmobUserOperation();
    //bmobUserOperation.updatePWD(currentUser, oldPWD, newPWD).then((_){
      //print("Change password finished");
      //Navigator.pop(context);
    //}).catchError((e){print(BmobError.convert(e));});
  }
}

class _SetGenderPage extends StatefulWidget{
  AppUser currentUser;

  _SetGenderPage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetGenderPageState createState() => _SetGenderPageState(currentUser);
}
class _SetGenderPageState extends State<_SetGenderPage>{
  AppUser currentUser;
  bool gender;
  bool genderShow;

  _SetGenderPageState(AppUser appUser){
    currentUser = appUser;
    gender = currentUser.gender;
    genderShow = currentUser.genderShow;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        trailing: _buildFinishButton(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSafeArea(),
            _genderInfoSection(),
            _genderSection(),
            _buildSafeArea(),
            _genderShowInfoSection(),
            _genderShowSection()
          ],
        ),
      )
    );
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 16,
            color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _genderInfoSection() {
    return Text(
      'Your gender is...?',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }
  Widget _genderSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Card(
        color: AppTheme.backgroundColor,
        child: Column(
          children: <Widget>[
            RadioListTile(
              value: false,
              title: Text(
                'Male',
                style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 24,
                    color: Colors.grey
                ),
              ),
              groupValue: gender,
              activeColor: AppTheme.themeColor,
              onChanged:(v){ setState(() { gender = false; }); print(gender);},
            ),
            RadioListTile(
              value: true,
              title: Text(
                'Female',
                style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 24,
                  color: Colors.grey
                ),
              ),
              groupValue: gender,
              activeColor: AppTheme.themeColor,
              onChanged:(v){ setState(() { gender = true; }); print(gender);},
            ),
          ],
        ),
      )
    );
  }

  Widget _genderShowInfoSection() {
    return Text(
      'Do you want to keep this a secret?',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }
  Widget _genderShowSection() {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Card(
          color: AppTheme.backgroundColor,
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: false,
                title: Text(
                  'Sure',
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 24,
                      color: Colors.grey
                  ),
                ),
                groupValue: genderShow,
                activeColor: AppTheme.themeColor,
                onChanged:(v){ setState(() { genderShow = false; }); print(genderShow);},
              ),
              RadioListTile(
                value: true,
                title: Text(
                  'No',
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 24,
                      color: Colors.grey
                  ),
                ),
                groupValue: genderShow,
                activeColor: AppTheme.themeColor,
                onChanged:(v){ setState(() { genderShow = true; }); print(genderShow);},
              ),
            ],
          ),
        )
    );
  }

  void _onFinishButtonPressed(){
    currentUser.gender = gender;
    currentUser.genderShow = genderShow;
    UserConnector.updateUser(currentUser).then((_){
      print("Change gender finished");
      Navigator.pop(context);
    }).catchError((e){print(BmobError.convert(e));});
  }
}

class _SetBirthdayPage extends StatefulWidget{
  AppUser currentUser;

  _SetBirthdayPage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetBirthdayPageState createState() => _SetBirthdayPageState(currentUser);
}
class _SetBirthdayPageState extends State<_SetBirthdayPage>{
  AppUser currentUser;
  DateTime birthday;
  bool birthdayShow;

  _SetBirthdayPageState(AppUser appUser){
    currentUser = appUser;
    birthday = currentUser.birthday;
    birthdayShow = currentUser.birthdayShow;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppTheme.backgroundColor,
          actionsForegroundColor: Colors.grey,
          trailing: _buildFinishButton(),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSafeArea(),
              _birthdayInfoSection(),
              _birthdaySection(),
              _buildSafeArea(),
              _birthdayShowInfoSection(),
              _birthdayShowSection()
            ],
          ),
        )
    );
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 16,
            color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _birthdayInfoSection() {
    return Text(
      'Your birthday is...?',
      style: TextStyle(
        fontFamily: 'papyrus',
        fontSize: 24,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
      ),
    );
  }
  Widget _birthdaySection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: _onBirthdayTabbed,
        child: Center(
          child: Text(
            birthday.year.toString() + "/" + birthday.month.toString() + "/" + birthday.day.toString(),
            style: TextStyle(
              fontFamily: 'papyrus',
              fontSize: 24,
              decoration: TextDecoration.none,
              color: Colors.grey
            ),
          ),
        ),
      )
    );
  }

  Widget _birthdayShowInfoSection() {
    return Text(
      'Do you want to keep this a secret?',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }
  Widget _birthdayShowSection() {
    print(birthdayShow);
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Card(
          color: AppTheme.backgroundColor,
          child: Column(
            children: <Widget>[
              RadioListTile(
                value: false,
                title: Text(
                  'Sure',
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 24,
                      color: Colors.grey
                  ),
                ),
                groupValue: birthdayShow,
                activeColor: AppTheme.themeColor,
                onChanged:(v){ setState(() { birthdayShow = false; });},
              ),
              RadioListTile(
                value: true,
                title: Text(
                  'No',
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 24,
                      color: Colors.grey
                  ),
                ),
                groupValue: birthdayShow,
                activeColor: AppTheme.themeColor,
                onChanged:(v){ setState(() { birthdayShow = true; });},
              ),
            ],
          ),
        )
    );
  }

  void _onBirthdayTabbed() {
    print("Birthday tabbed");
    showDatePicker(
      context: context,
      initialDate: birthday,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now()
    ).then((newBirthday){
      setState(() {
        birthday = newBirthday;
      });
    }).catchError((e){print(e);});
  }

  void _onFinishButtonPressed(){
    currentUser.birthday = birthday;
    currentUser.birthdayShow = birthdayShow;
    UserConnector.updateUser(currentUser).then((_){
      print("Change birthday finished");
      Navigator.pop(context);
    }).catchError((e){print(BmobError.convert(e));});
  }
}

class _SetPhonePage extends StatefulWidget{
  AppUser currentUser;

  _SetPhonePage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetPhonePageState createState() => _SetPhonePageState(currentUser);
}
class _SetPhonePageState extends State<_SetPhonePage>{
  AppUser currentUser;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _verifyCodeController = TextEditingController();

  bool _getVerifyCodeEnabled = true;
  int _timeToGetVerifyCode = 30;
  Timer _verifyCodeTimer;

  _SetPhonePageState(AppUser appUser){
    currentUser = appUser;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        trailing: _buildFinishButton(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSafeArea(),
            _infoSection(),
            _phoneSection(),
            _verifyCodeSection()
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _verifyCodeController.dispose();
    _verifyCodeTimer?.cancel();
    super.dispose();
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 16,
          color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _infoSection() {
    return Text(
      'Change your phone',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }

  Widget _phoneSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _phoneController,
        placeholder: 'New Phone Number',
        placeholderStyle: TextStyle(
            fontFamily: 'papyrus',
            color: Colors.grey[800]
        ),
        decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Colors.grey
                )
            )
        ),
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 24,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget _verifyCodeSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              controller: _verifyCodeController,
              placeholder: 'Verify Code',
              placeholderStyle: TextStyle(
                fontFamily: 'papyrus',
                color: Colors.grey[800]
              ),
              decoration: BoxDecoration(
                color: AppTheme.backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    width: 2.0,
                    color: Colors.grey
                  )
                )
              ),
              style: TextStyle(
                fontFamily: 'papyrus',
                fontSize: 24,
                color: Colors.grey
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 60,
              height: 40,
              child: Center(
                //padding: EdgeInsets.all(30),
                child: Text(
                  _getVerifyCodeEnabled ? 'Get' :
                  ' ' + _timeToGetVerifyCode.toString(),
                  style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: Colors.grey
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[500],
                    width: 2
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onTap: _onGetVerifyCodeButtonTabbed,
          )
        ],
      ),
    );
  }
  
  void _startGetVerifyCodeTimer() {
    const oneSec = const Duration(seconds:1);
    _verifyCodeTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_timeToGetVerifyCode < 1) {
          _getVerifyCodeEnabled = true;
          _timeToGetVerifyCode =30;
          timer.cancel();
        } else {
          _getVerifyCodeEnabled = false;
          _timeToGetVerifyCode = _timeToGetVerifyCode - 1;
        }
      },),
    );
  }
  void _onGetVerifyCodeButtonTabbed() async {
    if(!_getVerifyCodeEnabled) { return; }
    _startGetVerifyCodeTimer();
    print("Get Button Pressed");
    /*
    BmobUserOperation bmobLogin = BmobUserOperation();
    loginMsgs result = await bmobLogin.sendSMS(cellNumberCtrl.text);
    if (result == loginMsgs.WrongPhoneFormat) {
      showInSnackBar("Please check your phone number");
    } else if (result == loginMsgs.NetworkFailure) {
      showInSnackBar("Please check your network");
    } else if (result == loginMsgs.UnknownFailure) {
      showInSnackBar("UNKNOWN FAILURE");
    } else if (result == loginMsgs.SMSSent) {
      _startGetVerifyCodeTimer();
    }
    */
  }

  void _onFinishButtonPressed(){
    String password = _phoneController.text;
    String confirmPassword = _verifyCodeController.text;
    print(password);

    if (password == "" || confirmPassword == "") {
      print("Please enter your new password");
      return;
    }
    if (password != confirmPassword) {
      print("The two passwords do not match");
      return;
    }
    print("Change password finished");
  }
}

/*class _SetEmailPage extends StatefulWidget{
  AppUser currentUser;

  _SetEmailPage(AppUser appUser){
    currentUser = appUser;
  }

  @override
  _SetEmailPageState createState() => _SetEmailPageState(currentUser);
}
class _SetEmailPageState extends State<_SetEmailPage>{
  AppUser currentUser;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _verifyCodeController = TextEditingController();

  bool _getVerifyCodeEnabled = true;
  int _timeToGetVerifyCode = 30;
  Timer _verifyCodeTimer;

  _SetEmailPageState(AppUser appUser){
    currentUser = appUser;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppTheme.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: AppTheme.backgroundColor,
          actionsForegroundColor: Colors.grey,
          trailing: _buildFinishButton(),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSafeArea(),
              _infoSection(),
              _emailSection(),
              _verifyCodeSection()
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _verifyCodeController.dispose();
    _verifyCodeTimer?.cancel();
    super.dispose();
  }

  Widget _buildFinishButton() {
    return FlatButton(
      color: AppTheme.backgroundColor,
      child: Text(
        'Finish',
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 16,
            color: Colors.grey
        ),
      ),
      onPressed: _onFinishButtonPressed,
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _infoSection() {
    return Text(
      'Set your e-mail',
      style: TextStyle(
          fontFamily: 'papyrus',
          fontSize: 24,
          color: AppTheme.textColor,
          decoration: TextDecoration.none
      ),
    );
  }

  Widget _emailSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: CupertinoTextField(
        controller: _emailController,
        placeholder: 'E-mail Address',
        placeholderStyle: TextStyle(
            fontFamily: 'papyrus',
            color: Colors.grey[800]
        ),
        decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            border: Border(
                bottom: BorderSide(
                    width: 2.0,
                    color: Colors.grey
                )
            )
        ),
        style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 24,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget _verifyCodeSection() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              controller: _verifyCodeController,
              placeholder: 'Verify Code',
              placeholderStyle: TextStyle(
                  fontFamily: 'papyrus',
                  color: Colors.grey[800]
              ),
              decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  border: Border(
                      bottom: BorderSide(
                          width: 2.0,
                          color: Colors.grey
                      )
                  )
              ),
              style: TextStyle(
                  fontFamily: 'papyrus',
                  fontSize: 24,
                  color: Colors.grey
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 60,
              height: 40,
              child: Center(
                //padding: EdgeInsets.all(30),
                child: Text(
                  _getVerifyCodeEnabled ? 'Get' :
                  ' ' + _timeToGetVerifyCode.toString(),
                  style: TextStyle(
                      fontFamily: 'papyrus',
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: Colors.grey
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey[500],
                    width: 2
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onTap: _onGetVerifyCodeButtonTabbed,
          )
        ],
      ),
    );
  }

  void _startGetVerifyCodeTimer() {
    const oneSec = const Duration(seconds:1);
    _verifyCodeTimer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(() {
        if (_timeToGetVerifyCode < 1) {
          _getVerifyCodeEnabled = true;
          _timeToGetVerifyCode =30;
          timer.cancel();
        } else {
          _getVerifyCodeEnabled = false;
          _timeToGetVerifyCode = _timeToGetVerifyCode - 1;
        }
      },),
    );
  }
  void _onGetVerifyCodeButtonTabbed() async {
    if(!_getVerifyCodeEnabled) { return; }
    _startGetVerifyCodeTimer();
    print("Get Button Pressed");
    /*
    BmobUserOperation bmobLogin = BmobUserOperation();
    loginMsgs result = await bmobLogin.sendSMS(cellNumberCtrl.text);
    if (result == loginMsgs.WrongPhoneFormat) {
      showInSnackBar("Please check your phone number");
    } else if (result == loginMsgs.NetworkFailure) {
      showInSnackBar("Please check your network");
    } else if (result == loginMsgs.UnknownFailure) {
      showInSnackBar("UNKNOWN FAILURE");
    } else if (result == loginMsgs.SMSSent) {
      _startGetVerifyCodeTimer();
    }
    */
  }

  void _onFinishButtonPressed(){
    String email = _emailController.text;
    String confirmPassword = _verifyCodeController.text;
    BmobUserOperation.sendEmail(email);
    print(email);

    if (email == "" || confirmPassword == "") {
      print("Please enter your new email");
      return;
    }
    if (email != confirmPassword) {
      print("The two passwords do not match");
      return;
    }
    print("Change email finished");
  }
}*/