import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trpgcocapp/styles/theme.dart';

class SingleChat extends StatefulWidget {

  /* TODO
   * 后端数据库设计仍然不明确
   * 一个聊天应当需要一个唯一标识
   * 考虑两种方案：
   *  - 每个聊天另设一个独立的唯一标识
   *  - 唯一标识由聊天的双方的 uid 组成
   */
  String chatID;

  SingleChat(this.chatID);

  @override
  State<StatefulWidget> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        // fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
          backgroundColor: AppTheme.backgroundColor,
          automaticallyImplyLeading: true,
          actionsForegroundColor: Colors.grey,
          // leading: _buildReturnButton(context),
          middle: _buildTitle(),
          trailing: _buildMenuButton(context),
      ),
      child: _buildChatPage(),
    );
  }

  // region Cupertino Navigation Bar
  // Cupertino Navigation Bar - leading
  Widget _buildReturnButton(BuildContext context) {
    return CupertinoButton(
      child: Icon(CupertinoIcons.back, color: AppTheme.textColor,),
      onPressed: () { _onReturnButtonPressed(context); },
    );
  }

  // Cupertino Navigation Bar - Middle
  Widget _buildTitle() {
    return Text (widget.chatID, style: _getTextStyle(16),);
  }

  // Cupertino Navigation Bar - Trailing
  Widget _buildMenuButton(BuildContext context) {
    return CupertinoButton(
      child: Icon(CupertinoIcons.add, color: AppTheme.textColor,),
      onPressed: () { _onMenuButtonPressed(context); },
    );
  }
  // endregion

  // region Chat Page
  Widget _buildChatPage() {
    return Column(
      children: [
        _buildMessagesArea(),
        _buildInputArea(),
        _buildSafeArea()
      ],
    );
  }

  Widget _buildMessagesArea() {
    return Expanded(
        child: Container(
          width: double.infinity,
          color: Colors.grey[700],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Test"),
              ],
            ),
          ),
        )
    );
  }
  
  Widget _buildInputArea() {
    Widget _buildInputButton() {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: FlatButton(
            height: 40,
            child: Text("Long press to talk", style: _getTextStyle(20),),
            disabledColor: Colors.red,
            color: Colors.grey[800],
            onPressed: _onInputButtonPressed,
            onLongPress: _onInputButtonLongPressed,
          ),
        )
      );
    }
    Widget _buildOtherFunctionButton() {
      return Container(
        width: 50,
        child: FlatButton(
          child: Icon(CupertinoIcons.add, color: AppTheme.textColor,),
          onPressed: _onOtherFunctionButtonPressed,
        ),
      );
    }

    return Container(
      height: 60,
      child: Row(
        children: [
          _buildInputButton(),
          _buildOtherFunctionButton()
        ],
      ),
    );
  }

  Widget _buildSafeArea() {
    return SizedBox(height: 30,);
  }
  // endregion

  void _onReturnButtonPressed(BuildContext context) {
    print("Return button pressed.");
  }

  void _onMenuButtonPressed(BuildContext context) {
    print("Menu button pressed.");
  }

  void _onInputButtonPressed() {
    print("Input Button Pressed.");
  }
  void _onInputButtonLongPressed() {
    print("Input Button Long Pressed.");
  }
  void _onOtherFunctionButtonPressed() {
    print("Other Function Button Pressed.");
  }

}
