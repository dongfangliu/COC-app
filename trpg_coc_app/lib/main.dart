import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/file/file_bloc.dart';
import 'package:trpgcocapp/bloc/file/file_widget.dart';
import 'package:trpgcocapp/ui/pages/module_creation_page.dart';
import 'package:trpgcocapp/ui/pages/module_search_page.dart';
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

