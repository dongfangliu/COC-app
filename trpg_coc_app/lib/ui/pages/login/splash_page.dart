import 'package:flutter/material.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Text(
          "Loading",
          style: TextStyle(
            fontFamily: 'papyrus',
            color: AppTheme.textColor,
            fontSize: 30,
            decoration: TextDecoration.none
          ),
        ),
      )
    );
  }
}