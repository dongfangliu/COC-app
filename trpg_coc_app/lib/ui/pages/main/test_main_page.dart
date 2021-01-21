import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'package:trpgcocapp/styles/theme.dart';
import 'package:trpgcocapp/ui/pages/me/me_page.dart';
import 'package:trpgcocapp/ui/pages/module/module_creation_page.dart';
import 'package:trpgcocapp/ui/pages/module/module_demo_page.dart';

class TestMainPage extends StatefulWidget{
  AppUser currentUser;

  TestMainPage(AppUser initUser){
    currentUser = initUser;
  }

  @override
  _TestMainPageState createState() => new _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: AppTheme.backgroundColor,
      tabBar: CupertinoTabBar(
        backgroundColor: AppTheme.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.folder, size: 20,),
            label: "Games",
//            title: Text("Games"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.paperPlane, size: 20,),
            label: "Friends",
//            title: Text("Friends"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.map, size: 20,),
            label: "Modules",
//            title: Text("Modules"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userAlt, size: 20,),
            label: "Me",
//            title: Text("Me"),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return Center(child: Text('Here are your games.'));
                break;
              case 1:
                return Center(child: Text('Here are your friends.'));
                break;
              case 2:
                return moduleCreationPage();
                break;
              case 3:
                return MePage(widget.currentUser);
                break;
              default:
                return Center(child: Text('No one should be here'),);
                break;
            }
          },
        );
      }
    );
  }

}