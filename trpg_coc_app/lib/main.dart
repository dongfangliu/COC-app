import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/file/file_bloc.dart';
import 'package:trpgcocapp/bloc/file/file_widget.dart';
import 'package:trpgcocapp/ui/pages/module/module_creation_page.dart';
import 'package:trpgcocapp/ui/pages/module/module_demo_page.dart';
import 'package:trpgcocapp/ui/pages/module/module_search_page.dart';
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: moduleDemoPage(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/app_bloc_delegate.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_bloc.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_events.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_states.dart';
import 'package:trpgcocapp/controller/Bmob/user_connector.dart';
import 'package:trpgcocapp/controller/current_user.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'package:trpgcocapp/ui/pages/character_sheet/char_sheet.dart';
import 'package:trpgcocapp/ui/pages/login/login_page.dart';
import 'package:trpgcocapp/ui/pages/login/splash_page.dart';
import 'package:trpgcocapp/ui/pages/main/test_main_page.dart';

// Test main()
// void main() => runApp(MyApp());
// class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: CharSheet(isNPC: false,),
//    );
//  }
// }

void main() {
 BlocSupervisor.delegate = AppBlocDelegate();
 runApp(
   BlocProvider(
     create: (context) => AUTBloc()..add(AppStarted()),
     child: MyApp(),
   )
 );
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   CurrentUser.getInstance().readUser().then((currentUser){
     if (currentUser.objectID != null) {
       UserConnector.getUserByObjectID(currentUser.objectID).then((appUser){
         //BlocProvider.of<AUTBloc>(context).add(LoggedIn(appUser));
         BlocProvider.of<AUTBloc>(context).add(LoggedOut());
       }).catchError((e){
         BlocProvider.of<AUTBloc>(context).add(LoggedOut());
       });
     } else {
       BlocProvider.of<AUTBloc>(context).add(LoggedOut());
     }
   });

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: BlocBuilder<AUTBloc, AUTState>(
       builder: (context, state){
         if (state is Authenticated) {
           return TestMainPage(state.currentUser);
         }
         if (state is Unauthenticated) {
           return LoginPage();
         }
         return SplashPage();
       },
     ),
   );
 }
}



