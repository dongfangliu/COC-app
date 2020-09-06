import 'package:flutter/material.dart';
import 'package:trpgcocapp/styles/theme.dart';

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