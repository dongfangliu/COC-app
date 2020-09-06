import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_bloc.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_events.dart';
import 'package:trpgcocapp/bloc/char_sheet/char_sheet_states.dart';
import 'package:trpgcocapp/data/char_sheet/char_data_part.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/styles/theme.dart';
import 'char_sheet_pages.dart';

/*
  20200606 潘一滔
  CharSheet 类就是车卡界面
  初始化时传递参数 bool isNPC 来表示是玩家还是 NPC 的车卡界面
  NPC 的界面现在只包含 info，attr，occu 三页
  如果要增加或减少 NPC 的页数
  需要同时修改当前文件下 _CharSheetFormState 类 initState() 中的 _pages
  以及 package:trpgcocapp/bloc/char_sheet/char_sheet_states.dart 文件里
    factory ChatSheetState.empty(bool isNPC) 中的 data
 */

class CharSheet extends StatelessWidget {
  bool isNPC;

  CharSheet({bool isNPC}){
    isNPC == null ? this.isNPC = false : this.isNPC = isNPC;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        middle: Text(
          "Invesgator Sheet",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: AppTheme.textColor,
            fontFamily: 'papyrus'
          ),
        ),
      ),
      child: BlocProvider<CharSheetBloc>(
        create: (context) => CharSheetBloc(isNPC),
        child: CharSheetForm(isNPC),
      )
    );
  }
  
}

class CharSheetForm extends StatefulWidget {
  bool isNPC;

  CharSheetForm(this.isNPC);

  @override
  _CharSheetFormState createState() => _CharSheetFormState(isNPC);
}

class _CharSheetFormState extends State<CharSheetForm> {
  bool _isNPC;
  CharSheetBloc charSheetBloc;
  PageController _pageController;
  List<CharSheetPage> _pages;

  _CharSheetFormState(this._isNPC);

  @override
  void initState(){
    super.initState();
    charSheetBloc = BlocProvider.of<CharSheetBloc>(context);
    // TODO 觉得把 Occu 放到第二页比较好
    if (_isNPC) {
      _pages = [
        CharSheetPageInfo(charSheetBloc),
        CharSheetPageAttr(charSheetBloc),
        CharSheetPageOccu(charSheetBloc),
      ];
    } else {
      _pages = [
        CharSheetPageInfo(charSheetBloc),
        CharSheetPageAttr(charSheetBloc),
        CharSheetPageOccu(charSheetBloc),
        CharSheetPageSkill(charSheetBloc),
        CharSheetPageCombat(charSheetBloc),
        CharSheetPageInvt(charSheetBloc),
        CharSheetPageStory(charSheetBloc),
      ];
    }
    _pageController = PageController();
  }
  
  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Entering Character Sheet");
    return Theme(
      data: ThemeData(
        primaryColor: AppTheme.textColor,
        backgroundColor: AppTheme.backgroundColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildPages(),
          _buildContent(),
          _buildFinishButton(),
          _buildSafeArea()
        ],
      ),
    );
  }

  Widget _buildPages() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        onPageChanged: (pageNum){ _onPageChanged(pageNum); },
        children: _pages
      ),
    );
  }
  Widget _buildContent() {
    // Build a single button
    Widget _buildContentItem(int pageIndex) {
      return Container(
        width: 40,
        child: BlocBuilder<CharSheetBloc, CharSheetState> (
          builder: (context, state){
            return MaterialButton(
              child: Text(
                (pageIndex + 1).toString(),
                style: TextStyle( fontSize: 16, color: Colors.grey[900] ),
              ),
              minWidth: 10,
              color: state.isPageFinished(_pages[pageIndex].pageTag) ?
              Colors.green : Colors.grey,
              shape: CircleBorder(
                side: BorderSide(
                  width: 3,
                  color: state.currentPage == pageIndex ?
                  AppTheme.themeColor : Colors.transparent
                )
              ),
              onPressed: () {
                _pageController.animateToPage(
                    pageIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut
                );
              },
            );
          },
        )
      );
    }
    // Build all the buttons
    List<Widget> _buildContentItems() {
      List<Widget> contentWidgets = [];
      for (int pageNum = 0; pageNum < _pages.length; pageNum++) {
        contentWidgets.add(_buildContentItem(pageNum));
      }
      return contentWidgets;
    }

    return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: _buildContentItems()
    );
  }
  Widget _buildFinishButton() {
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state) {
        bool allPageFinished = true;
        state.charData.forEach((String key, CharDataPart value) {
          if (!value.isFinished()) { allPageFinished = false; }
        });

        return Container(
          width: 200,
          child: FlatButton(
            color: AppTheme.themeColor,
            disabledColor: AppTheme.disabledColor,
            textColor: AppTheme.textColor,
            // padding: EdgeInsets.only(top: 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
            ),
            child: Text(
              'Finish',
              style: TextStyle(fontSize: 24, fontFamily: 'papyrus'),
            ),
            onPressed: allPageFinished ? _onFinishButtonPressed : null,
          ),
        );
      },
    );
  }
  Widget _buildSafeArea() {
    return SizedBox(height: 20,);
  }

  _onPageChanged(int pageNum) {
    charSheetBloc.add(PageChanged(pageNum));
  }

  _onFinishButtonPressed() {
    print("Finish button pressed");
  }
}
