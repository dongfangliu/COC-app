import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trpgcocapp/bloc/login/login_bloc.dart';
import 'package:trpgcocapp/bloc/login/login_events.dart';
import 'package:trpgcocapp/bloc/login/login_states.dart';
import 'package:trpgcocapp/bloc/login/vCode_bloc.dart';
import 'package:trpgcocapp/bloc/login/vCode_events.dart';
import 'package:trpgcocapp/bloc/login/vCode_states.dart';
import 'package:trpgcocapp/controller/flutter_qq/qq_login.dart';
import 'package:trpgcocapp/data/app_user.dart';
import 'login_form.dart';
import 'package:trpgcocapp/ui/pages/main/test_main_page.dart';
import 'package:trpgcocapp/styles/theme.dart';

enum LoginMsgs {
  WrongPhoneFormat, // 301
  VerifyCodeWrong, // 207
  NetworkFailure, // 9015
  InfoIncorrect, // 101
  SMSSent,
  UnknownFailure,
  LoginSuccess
}

class ReturnVals{
  LoginMsgs loginMsg;
  String objectID;

  ReturnVals(LoginMsgs initLoginMsg, String initObjectID) {
    loginMsg = initLoginMsg;
    objectID = initObjectID;
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: LoginForm(),
    );
  }
}