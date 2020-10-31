part of 'char_sheet_pages.dart';

class CharSheetPageStory extends CharSheetPage {
  @override
  String pageTag = "story";
  CharSheetBloc bloc;
  CharSheetPageStory(this.bloc);

  @override
  _CharSheetPageStoryState createState() {
    return _CharSheetPageStoryState(bloc, pageTag);
  }
}

class _CharSheetPageStoryState extends State<CharSheetPageStory> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageStoryState(this.bloc, this.pageTag);

  StoryData data;
  List<TextEditingController> storyCtrls = [];

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }

  @override
  void initState(){
    super.initState();
    data = bloc.state.charData[pageTag];

    // 根据 StoryData 中的 stories 数量来初始化 TextEditingController
    for (int i = 0; i < data.stories.length; i++){
      TextEditingController ctrl = TextEditingController();
      ctrl.text = data.stories[i];
      ctrl.addListener((){
        data.stories[i] = ctrl.text;
        _updateData();
      });
      storyCtrls.add(ctrl);
    }
  }

  @override dispose() {
    for (int i = 0; i < storyCtrls.length; i++){ storyCtrls[i].dispose(); }
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: GestureDetector(
        child: Column (
          children: <Widget>[
            SizedBox(height: 40,),
            _buildTitle(),
            _buildStoryPage()
          ],
        ),
        // 点击空白处收起键盘
        onTap: (){ FocusScope.of(context).requestFocus(FocusNode()); },
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Back Story", style: _getTextStyle(40)),
    );
  }

  Widget _buildStoryPage() {
    Widget _buildSingleStoryItem(int index) {
      return Column(
        children: <Widget>[
          Text(data.storyTitles[index], style: _getTextStyle(20),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              style: _getTextStyle(20),
              controller: storyCtrls[index],
            ),
          )
        ],
      );
    }
    List<Widget> _buildAllStories(){
      List<Widget> allStories = [];
      for (int index = 0; index < data.stories.length; index++){
        allStories.add(_buildSingleStoryItem(index));
      }
      return allStories;
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: _buildAllStories(),
        ),
      ),
    );
  }

  void _updateData() { bloc.add(UpdateData(pageTag, data)); }
}