import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'package:trpgcocapp/ui/pages/me/me_page_setting.dart';
import 'package:trpgcocapp/ui/pages/me/me_page_mods.dart';
import 'package:trpgcocapp/ui/pages/me/me_page_user.dart';

class MePage extends StatefulWidget{
  AppUser currentUser;

  MePage(this.currentUser);

  @override
  _MePageState createState() => new _MePageState(currentUser);
}

class _MePageState extends State<MePage> {
  AppUser currentUser;

  _MePageState(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column (
        children: <Widget>[
          SizedBox(height: 20),
          _buildSettingButton(),
          _buildUserInfo(),
          _buildButtons()
        ],
      )
    );
  }
  Widget _buildSettingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Icon(
              FontAwesomeIcons.cog,
              color: Colors.grey[500],
              size: 20,
            ),
          ),
          onTap: () { _onSettingPressed(context); },
        )
      ],
    );
  }
  Widget _buildUserInfo() {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: CircleAvatar(
              // TODO Show avatar
              radius: 45,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
              backgroundColor: Colors.grey,
            ),
          ), // User Avatar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  currentUser.username,
                  style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 28,
                    color: Colors.grey,
                    decoration: TextDecoration.none
                  ),
                ),
                Text(
                  currentUser.phone,
                  style: TextStyle(
                    fontFamily: 'papyrus',
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.none
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[800],
            size: 60,
          )
        ],
      ),
      onTap: (){ _onUserInfoTabbed(context); },
    );
  }
  Widget _buildButtons() {
    return Expanded(
      child: ListView(
        children: <Widget>[
          _buildModsButton(),
          _buildGroupsButton()
        ],
      ),
    );
  }

  Widget _buildModsButton(){
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Container(
        height: 50,
        child: FlatButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Text(
            'Mods',
            style: TextStyle(
                fontFamily: 'papyrus',
                fontSize: 24,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          onPressed: (){ _onMyModsPressed(context); },
        ),
      )
    );
  }
  Widget _buildGroupsButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Container(
        height: 50,
        child: FlatButton(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Text(
            'My Groups',
            style: TextStyle(
                fontFamily: 'papyrus',
                fontSize: 24,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          onPressed: (){ _onMyGroupsPressed(context); },
        ),
      )
    );
  }

  void _onSettingPressed(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_){return MePageSetting();})
    );
  }
  void _onUserInfoTabbed(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_){return MePageUser(currentUser);})
    );
  }
  void _onMyModsPressed(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_){return MePageMods(currentUser);})
    );
  }
  void _onMyGroupsPressed(BuildContext context) {
    print("My Groups Button Pressed");
  }
}

