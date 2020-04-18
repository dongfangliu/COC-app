import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget{

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // region Variables
  PageController _pageController;
  bool _passwordObscure = true;
  // Color _backgroundColor = Color(0xff2c003e);
  Color _backgroundColor = Colors.grey[900];
  // region FocusNodes
  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final FocusNode cellNumberNode = FocusNode();
  final FocusNode verifyCodeNode = FocusNode();
  // endregion
  // region TextEditingControllers
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController cellNumberCtrl = TextEditingController();
  TextEditingController veirfyCodeCtrl = TextEditingController();
  // endregion
  // region Verify Code
  bool _getVerifyCodeEnabled = true;
  int _timeToGetVerifyCode = 30;
  Timer _verifyCodeTimer;
  // endregion
  // region Login Button
  bool _loginButtonEnabled = false;
  //bool _
  // endregion
  // endregion

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _addTextFieldsListener();
  }

  @override
  void dispose() {
    usernameNode.dispose();
    passwordNode.dispose();
    cellNumberNode.dispose();
    verifyCodeNode.dispose();
    _pageController?.dispose();
    _verifyCodeTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: _backgroundColor
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: _backgroundColor,
        title: Text(
          'Call of Cthulhu',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontFamily: 'Papyrus'
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 80, left: 30),
                    child: Text(
                      'Welcome,\nInvestigator.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 35,
                        fontFamily: 'Papyrus'
                      ),
                    ),
                  ),
                ],
              ), // Text: 'Welcome, Investigator.'
              Container(
                width: 400,
                height: 200,
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildPhoneVerifyPage(),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildPasswordPage(),
                    )
                  ],
                ),
              ), // Login pages
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: _buildLoginButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  // region For Phone Verify Page
  void _switchToPhoneVerifyPage() {
    _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut
    );
  }
  void _startGetVerifyCodeTimer() {
    const oneSec = const Duration(seconds:1);
    _verifyCodeTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_timeToGetVerifyCode < 1) {
          _getVerifyCodeEnabled = true;
          _timeToGetVerifyCode =30;
          timer.cancel();
        } else {
          _getVerifyCodeEnabled = false;
          _timeToGetVerifyCode = _timeToGetVerifyCode - 1;
        }
      },),
    );
  }
  void _onGetVerifyCodeButtonTabbed() {
    if(_getVerifyCodeEnabled ) {
      _startGetVerifyCodeTimer();
    }
  }
  Widget _buildPhoneVerifyPage() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                width: 280,
                height: 160,
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/imgs/parchment.jpg'),
              ),
              Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      focusNode: cellNumberNode,
                      controller: cellNumberCtrl,
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
                            focusNode: verifyCodeNode,
                            controller: veirfyCodeCtrl,
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
                        GestureDetector(
                          child: Container(
                            width: 50,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                _getVerifyCodeEnabled ? 'Get' :
                                ' ' + _timeToGetVerifyCode.toString(),
                                style: TextStyle(
                                  fontFamily: 'papyrus'
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
                          onTap: _onGetVerifyCodeButtonTabbed,
                        )
                      ],
                    )
                  ),
                ],
              ),
            ]
          ),
          GestureDetector(
            child:  Icon(
              FontAwesomeIcons.arrowRight,
              color: Colors.grey,
            ),
            onTap: _switchToPasswordPage,
          ),
        ],
      )
    );
  }
  // endregion

  // region For Password Page
  void _switchToPasswordPage() {
    _pageController.animateToPage(
        1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut
    );
  }
  void _pwdObscureSwitch(){
    setState(() {
      _passwordObscure = !_passwordObscure;
    });
  }
  Widget _buildPasswordPage() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: _switchToPhoneVerifyPage,
            child:  Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.grey,
            )
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image(
                width: 280,
                height: 160,
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/imgs/parchment.jpg'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      focusNode: usernameNode,
                      controller: usernameCtrl,
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
                      focusNode: passwordNode,
                      controller: passwordCtrl,
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
                            onTap: _pwdObscureSwitch,
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
              ),
            ]
          ),
        ],
      )
    );
  }
  // endregion

  // region For Login Button
  void _addTextFieldsListener(){
    cellNumberNode.addListener(_chooseLoginButtonStatus);
    verifyCodeNode.addListener(_chooseLoginButtonStatus);
    usernameNode.addListener(_chooseLoginButtonStatus);
    passwordNode.addListener(_chooseLoginButtonStatus);
  }
  void _chooseLoginButtonStatus() {
    if (_pageController == null) {
      return;
    }
    if (_pageController.offset == 0) {
      String cell = cellNumberCtrl.text;
      String code = veirfyCodeCtrl.text;
      if (cell == "" || code == "") {
        setState(() { _loginButtonEnabled = false; });
      } else {
        setState(() { _loginButtonEnabled = true; });
      }
    } else {
      String username = usernameCtrl.text;
      String password = passwordCtrl.text;
      if (username == "" || password == "") {
        setState(() { _loginButtonEnabled = false; });
      } else {
        setState(() { _loginButtonEnabled = true; });
      }
    }
  }
  void _onLoginPressed() {
    print("Login button pressed");
  }
  Widget _buildLoginButton() {
    return SizedBox(
      width: 240,
      height: 60,
      child: FlatButton(
        color: Color(0xff54439B),
        disabledColor: Color(0xff2D2454),
        textColor: Colors.grey[900],
        //padding: EdgeInsets.only(top: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'papyrus'
          ),
        ),
        onPressed: _loginButtonEnabled ? _onLoginPressed : null,
      ),
    );
  }
  // endregion

}