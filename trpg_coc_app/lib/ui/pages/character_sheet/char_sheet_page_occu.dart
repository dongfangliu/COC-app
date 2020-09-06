part of 'char_sheet_pages.dart';

class CharSheetPageOccu extends CharSheetPage {
  @override
  String pageTag = "occu";
  CharSheetBloc bloc;
  CharSheetPageOccu(this.bloc);

  @override
  _CharSheetPageOccuState createState() {
    return _CharSheetPageOccuState(bloc, pageTag);
  }
}

class _CharSheetPageOccuState extends State<CharSheetPageOccu>{
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageOccuState(this.bloc, this.pageTag);

  OccuData data;

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }

  @override
  void initState() {
    super.initState();
    data = bloc.state.charData[pageTag];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column (
        children: <Widget>[
          SizedBox(height: 20,),
          _buildTitle(),
          _buildOccuPage()
        ],
      ),
    );
  }
  
  Widget _buildTitle() {
    return Center(
      child: Text("Occupation", style: _getTextStyle(40)),
    );
  }

  Widget _buildOccuPage() {
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state) {
        data = state.charData[pageTag];
        if (data.isFinished()) {
          return _buildOccuPageAfterSelected();
        } else {
          return _buildOccuPageBeforeSelected();
        }
      },
    );
  }

  Widget _buildSearchButton(){
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state){
        OccuData _data = state.charData[pageTag];
        String buttonText;
        if (_data.occu == null) { buttonText = "Select an occupation"; }
        else { buttonText = _data.occu.name; }
        return Container(
          width: 260,
          height: 50,
          decoration: BoxDecoration(border: Border()),
          child: FlatButton(
            shape: StadiumBorder(side: BorderSide(color: AppTheme.textColor)),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.search,
                  color: AppTheme.textColor,
                ),
                Expanded(
                  child: Center(
                    child: Text(buttonText, style: _getTextStyle(20),),
                  )
                )
              ],
            ),
            onPressed: () { _onSearchButtonPressed(context); },
          ),
        );
      },
    );
  }
  Widget _buildOccuPageBeforeSelected() {
    return Expanded(child: Center(child: _buildSearchButton()),);
  }
  Widget _buildOccuPageAfterSelected() {
    Occu occu = data.occu;
    // Section with CR, attributes and staff
    Widget _buildSection1() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: <Widget>[
            Text(
              "信用评级: ",
              style: _getTextStyle(16),
            ),
            Text(
              occu.crLow.toString() + " - " + occu.crHigh.toString(),
              style: _getTextStyle(12),
            ),
            Text(
              "技能: ",
              style: _getTextStyle(16),
            ),
            Text(
              occu.skillIntro,
              style: _getTextStyle(12),
            ),
          ],
        ),
      );
    }
    // Section with occupation introduction
    Widget _buildSection3(){
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(occu.intro, style: _getTextStyle(12),),
      );
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40,),
            _buildSection1(),
            SizedBox(height: 40,),
            _buildSearchButton(),
            SizedBox(height: 40,),
            _buildSection3()
          ],
        ),
      ),
    );
  }

  void _onSearchButtonPressed(BuildContext context){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_){return _OccuSelectPage(bloc, pageTag);})
    );
  }

}

class _OccuSelectPage extends StatelessWidget {
  // TODO 考虑加一个搜索按钮
  /* TODO 应留下一项作为自建职业的按钮
      考虑将自建职业的信息存在 OccuData 中  */
  CharSheetBloc bloc;
  String pageTag;
  _OccuSelectPage(this.bloc, this.pageTag);

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }
  void _showDialog(String content, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          content: Text(content, style: _getTextStyle(20),),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok'),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.backgroundColor,
        actionsForegroundColor: Colors.grey,
        middle: Text("Choose your occupation", style: _getTextStyle(20),),
      ),
      child: _buildOccuList(context)
    );
  }

  Widget _buildOccuList(BuildContext context){
    // Load occupation data
    Future<List<Occu>> loadOccus() async {
      try {
        OccuListManager manager = OccuListManager();
        return await manager.readOccuList();
      } catch (e) { print(e); return null; }
    }

    // Build header
    Widget _buildHeader(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50,
            child: Text("No.", style: _getTextStyle(20),),
          ),
          Container(
            width: 100,
            child: Text("Name", style: _getTextStyle(20),),
          ),
          Container(
            width: 80,
            child: Text("CR", style: _getTextStyle(20),),
          ),
          Container(
            width: 100,
            child: Text("Attributes", style: _getTextStyle(20),),
          )
        ],
      );
    }
    // Build a single occupation row
    Widget _buildOneOccu(Occu occu) {
      return GestureDetector(
        onLongPress: () { _showDialog(occu.intro, context); },
        onTap: () { _onOccuTapped(occu, context); },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50,
              child: Text(occu.index.toString(), style: _getTextStyle(20),),
            ),
            Container(
              width: 100,
              child: Text(occu.name, style: _getTextStyle(20),),
            ),
            Container(
              width: 80,
              child: Text(
                occu.crLow.toString() + " - " + occu.crHigh.toString(),
                style: _getTextStyle(20),
              ),
            ),
            Container(
              width: 100,
              child: Text(occu.attrIntro, style: _getTextStyle(20),),
            )
          ],
        ),
      );
    }
    // Build all the occupations
    List<Widget> _buildOccus(List<Occu> occuList) {
      List<Widget> _occus = [];
      for (int index = 0; index < occuList.length; index++) {
        _occus.add(_buildOneOccu(occuList[index]));
      }
      return _occus;
    }

    return Column(
      children: <Widget>[
        _buildHeader(),
        FutureBuilder<List<Occu>> (
          future: loadOccus(),
          builder: (BuildContext context, AsyncSnapshot<List<Occu>> snapshot){
            if (snapshot.hasData) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildOccus(snapshot.data),
                  ),
                )
              );
            } else {
              return Center (
                child: Text (
                  "Loading",
                  style: _getTextStyle(20),
                ),
              );
            }
          },
        ),

      ],
    );
  }

  void _onOccuTapped(Occu occu, BuildContext context){
    OccuData data = OccuData();
    data.occu = occu;
    bloc.add(UpdateData(pageTag, data));
    Navigator.of(context).pop();
  }

}