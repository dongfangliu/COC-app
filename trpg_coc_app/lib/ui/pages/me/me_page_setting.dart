import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';

class MePageSetting extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
      ),
      child: Center(
        child: Text(
          "Setting Content"
        ),
      ),
    );
  }

}