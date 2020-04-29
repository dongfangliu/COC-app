import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/gameGroupsPage.dart';
import 'pages/gzx_dropdown_menu_test_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: gameGroupsPage(),
    );
  }
}

