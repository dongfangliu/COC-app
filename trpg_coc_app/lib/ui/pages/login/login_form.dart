import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_events.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_bloc.dart';
import 'package:trpgcocapp/bloc/authentication/authentication_states.dart';
import 'package:trpgcocapp/bloc/login/login_bloc.dart';
import 'package:trpgcocapp/bloc/login/login_events.dart';
import 'package:trpgcocapp/bloc/login/login_states.dart';
import 'package:trpgcocapp/bloc/login/vCode_bloc.dart';
import 'package:trpgcocapp/bloc/login/vCode_events.dart';
import 'package:trpgcocapp/bloc/login/vCode_states.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // region Variables
  PageController _pageController;
  bool _onPhonePage;
  bool _passwordObscure = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc;
  // region TextEditingControllers
  TextEditingController _usernameCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _phoneCtrl = TextEditingController();
  TextEditingController _vCodeCtrl = TextEditingController();
  // endregion
  // endregion

  void showInSnackBar(String value, {bgColor = Colors.transparent}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppTheme.textColor,
            fontSize: 16.0,
            fontFamily: "papyrus"
        ),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _pageController = PageController();
    _onPhonePage = true;
    _usernameCtrl.addListener(_onUsernameChanged);
    _passwordCtrl.addListener(_onPasswordChanged);
    _phoneCtrl.addListener(_onPhoneChanged);
    _vCodeCtrl.addListener(_onVCodeChanged);
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
    _vCodeCtrl.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ProcessLogin) { showInSnackBar("Login Processing"); }
        if (state is LoginFail) { showInSnackBar(state.errorMsg); }
        if (state is LoginSuccess) {
          BlocProvider.of<AUTBloc>(context).add(LoggedIn(state.currentUser));
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: _buildBody(),
      )
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppTheme.backgroundColor,
      title: Text(
        'Call of Cthulhu',
        style: TextStyle(
          color: AppTheme.textColor,
          fontSize: 18,
          fontFamily: 'Papyrus'
        ),
      ),
    );
  }
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column (
        children: <Widget>[
          SizedBox(height: 60), // Divider
          Text(
            'Welcome,',
            style: TextStyle(
              color: AppTheme.textColor,
              fontSize: 35,
              fontFamily: 'Papyrus'
            ),
          ), // Text: Welcome
          Text(
            'Investigator',
            style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 35,
                fontFamily: 'Papyrus'
            ),
          ), // Text: Investigator
          SizedBox(height: 40), // Divider
          Container(
            width: 400,
            height: 200,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index){ _onPageChanged(index); },
              children: <Widget>[
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _buildPhonePage(),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _buildUsernamePage(),
                )
              ],
            ),
          ), // Login pages
          SizedBox(height: 40), // Divider
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildPhonePage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              width: 280,
              height: 160,
              fit: BoxFit.fill,
              image: AssetImage('assets/images/parchment.jpg'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TextField(
                    //focusNode: cellNumberNode,
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                        fontFamily: 'papyrus',
                        fontSize: 20,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          //focusNode: verifyCodeNode,
                          controller: _vCodeCtrl,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: 'papyrus',
                              fontSize: 20,
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Verify Code',
                          ),
                        ),
                      ),
                      BlocProvider(
                        create: (context) => VCodeBloc(),
                        child: BlocListener<VCodeBloc, VCodeState>(
                          listener: (context, state){
                            if (state is SendSMSError) {
                              showInSnackBar(state.errorMsg);
                            }
                          },
                          child: BlocBuilder<VCodeBloc, VCodeState>(
                            builder: (context, state) {
                              return GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      state is VerifyDisabled ?
                                      state.duration.toString() : 'Get',
                                      style: TextStyle(
                                          fontFamily: 'papyrus',
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[700],
                                        width: 1
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onTap: (){
                                  _onVCodeGetPressed(context, state);
                                }
                              );
                            }
                          ),
                        )
                      ),
                    ],
                  )
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          child:  Icon(
            FontAwesomeIcons.arrowRight,
            color: AppTheme.textColor,
          ),
          onTap: (){
            _pageController.animateToPage(
              1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut
            );
          },
        ),
      ],
    );
  }
  Widget _buildUsernamePage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          child:  Icon(
            FontAwesomeIcons.arrowLeft,
            color: AppTheme.textColor,
          ),
          onTap: (){
            _pageController.animateToPage(
              0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut
            );
          },
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              width: 280,
              height: 160,
              fit: BoxFit.fill,
              image: AssetImage('assets/images/parchment.jpg'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: TextField(
                    //focusNode: cellNumberNode,
                    controller: _usernameCtrl,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontFamily: 'papyrus',
                        fontSize: 20,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                    ),
                  ),
                ),
                Container(
                    width: 200,
                    child: TextField(
                      //focusNode: passwordNode,
                      controller: _passwordCtrl,
                      obscureText: _passwordObscure,
                      style: TextStyle(
                          fontFamily: 'papyrus',
                          fontSize: 20,
                          color: Colors.black
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: (){ setState(() {
                            _passwordObscure = !_passwordObscure;
                          }); },
                          child: Icon(
                            _passwordObscure ?
                            FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey,
                          ),
                        )
                      ),
                    ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
  Widget _buildLoginButton() {
    return SizedBox(
      width: 240,
      height: 60,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return FlatButton(
            color: AppTheme.themeColor,
            disabledColor: AppTheme.disabledColor,
            textColor: AppTheme.textColor,
            // padding: EdgeInsets.only(top: 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
            ),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 24, fontFamily: 'papyrus'),
            ),
            onPressed: state is LoginEnabled ? _onLoginButtonPressed : null,
          );
        },
      )
    );
  }

  void _onPageChanged(int index) {
    if (index == 0) {
      _onPhonePage = true;
      String info1 = _phoneCtrl.text;
      String info2 = _vCodeCtrl.text;
      _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
    } else {
      _onPhonePage = false;
      String info1 = _usernameCtrl.text;
      String info2 = _passwordCtrl.text;
      _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
    }
  }
  void _onPhoneChanged() {
    String info1 = _phoneCtrl.text;
    String info2 = _vCodeCtrl.text;
    _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
  }
  void _onVCodeChanged() {
    String info1 = _phoneCtrl.text;
    String info2 = _vCodeCtrl.text;
    _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
  }
  _onVCodeGetPressed(BuildContext context, VCodeState state) {
    if (state is VerifyDisabled) {
      return null;
    } else {
      BlocProvider.of<VCodeBloc>(context).add(
        VerifyButtonPressed(_phoneCtrl.text)
      );
    }
  }
  void _onUsernameChanged() {
    String info1 = _usernameCtrl.text;
    String info2 = _passwordCtrl.text;
    _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
  }
  void _onPasswordChanged() {
    String info1 = _usernameCtrl.text;
    String info2 = _passwordCtrl.text;
    _loginBloc.add(UpdateLoginInfo(_onPhonePage, info1, info2));
  }
  void _onLoginButtonPressed() {
    String info1;
    String info2;
    if (_onPhonePage) {
      info1 = _phoneCtrl.text;
      info2 = _vCodeCtrl.text;
    } else {
      info1 = _usernameCtrl.text;
      info2 = _passwordCtrl.text;
    }
    _loginBloc.add(LoginPressed(_onPhonePage, info1, info2));
  }

}