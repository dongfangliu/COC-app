import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trpgcocapp/ui/pages/moduleCreationPage.dart';
import 'ui/pages/gameGroupsPage.dart';
import 'ui/pages/testDataAddPage.dart';
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
      home: moduleCreationPage(),
    );
  }
}

