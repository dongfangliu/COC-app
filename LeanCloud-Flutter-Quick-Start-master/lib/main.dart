import 'package:flutter/material.dart';
import 'ui/login_page.dart';
import 'LeanCloud/leancloud_test.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LeanCloudTest leanCloudTest = new LeanCloudTest();
    leanCloudTest.signUpTest();

    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoginPage(),
    );
  }
}