import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';

class MePageMods extends StatefulWidget{
  AppUser currentUser;

  MePageMods(this.currentUser);

  @override
  _MePageModsState createState() => _MePageModsState(currentUser);

}

class _MePageModsState extends State<MePageMods> {
  AppUser currentUser;

  PageController _pageController;
  static Color _focusedColor = Colors.grey[500];
  static Color _notFocusedColor = Colors.grey[800];
  Color leftTextColor = _focusedColor;
  Color rightTextColor = _notFocusedColor;

  _MePageModsState(this.currentUser);

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        middle: Text(
          'Mods',
          style: TextStyle(
            fontFamily: 'papyrus',
            fontSize: 22,
            decoration: TextDecoration.none,
            color: Colors.grey
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          _buildSafeArea(),
          _buildMenuBar(),
          _buildPages()
        ],
      ),
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(
      height: 20,
      child: Text(""),
    );
  }

  Widget _buildMenuBar() {
    return Container(
      width: 350,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: _onMyModsPressed,
              child: Text(
                'My Mods',
                style: TextStyle(
                    color: leftTextColor,
                    fontSize: 22.0,
                    fontFamily: 'papyrus'
                ),
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: _onStarredPressed,
              child: Text(
                'Starred',
                style: TextStyle(
                    color: rightTextColor,
                    fontSize: 22.0,
                    fontFamily: 'papyrus'
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPages() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (i) {
          if (i == 0) {
            _onMyModsPressed();
          } else {
            _onStarredPressed();
          }
        },
        children: <Widget>[
          _buildPageMyMods(),
          _buildPageStarred()
        ],
      ),
    );
  }

  Widget _buildPageMyMods(){
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: ListView(
        children: <Widget>[
          Text('MyMod1'),
          Text('MyMod2'),
          Text('MyMod3'),
          Text('MyMod4'),
          Text('MyMod5'),
          Text('MyMod6'),
          Text('MyMod7'),
          Text('MyMod8'),
          Text('MyMod9'),
          Text('MyMod10'),
        ],
      )
    );
  }

  Widget _buildPageStarred() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: ListView(
        children: <Widget>[
          Text('StarredMod1'),
          Text('StarredMod2'),
          Text('StarredMod3'),
          Text('StarredMod4'),
          Text('StarredMod5'),
          Text('StarredMod6'),
          Text('StarredMod7'),
          Text('StarredMod8'),
          Text('StarredMod9'),
          Text('StarredMod10'),
        ],
      ),
    );
  }

  void _onMyModsPressed() {
    _pageController?.animateToPage(
      0,
      duration: Duration(milliseconds: 200),
      curve: Curves.decelerate
    );
    setState(() {
      leftTextColor = _focusedColor;
      rightTextColor = _notFocusedColor;
    });
  }

  void _onStarredPressed() {
    _pageController?.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.decelerate
    );
    setState(() {
      leftTextColor = _notFocusedColor;
      rightTextColor = _focusedColor;
    });
  }
}