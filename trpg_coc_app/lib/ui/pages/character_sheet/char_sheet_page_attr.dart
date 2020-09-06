part of 'char_sheet_pages.dart';

class CharSheetPageAttr extends CharSheetPage {
  @override
  String pageTag = "attr";
  CharSheetBloc bloc;
  CharSheetPageAttr(this.bloc);

  @override
  _CharSheetPageAttrState createState() {
    return _CharSheetPageAttrState(bloc, pageTag);
  }
}

class _CharSheetPageAttrState extends State<CharSheetPageAttr> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageAttrState(this.bloc, this.pageTag);

  AttrData data;
  TextEditingController _strCtrl = TextEditingController();
  TextEditingController _conCtrl = TextEditingController();
  TextEditingController _sizCtrl = TextEditingController();
  TextEditingController _dexCtrl = TextEditingController();
  TextEditingController _appCtrl = TextEditingController();
  TextEditingController _intCtrl = TextEditingController();
  TextEditingController _powCtrl = TextEditingController();
  TextEditingController _eduCtrl = TextEditingController();
  TextEditingController _lucCtrl = TextEditingController();

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

    if (data.str != 0) {_strCtrl.text = data.str.toString();}
    if (data.con != 0) {_conCtrl.text = data.con.toString();}
    if (data.siz != 0) {_sizCtrl.text = data.siz.toString();}
    if (data.dex != 0) {_dexCtrl.text = data.dex.toString();}
    if (data.app != 0) {_appCtrl.text = data.app.toString();}
    if (data.int != 0) {_intCtrl.text = data.int.toString();}
    if (data.pow != 0) {_powCtrl.text = data.pow.toString();}
    if (data.edu != 0) {_eduCtrl.text = data.edu.toString();}
    if (data.luc != 0) {_lucCtrl.text = data.luc.toString();}

    _strCtrl.addListener((){
      if (_strCtrl.text == "") { data.str = 0; }
      else { data.str = int.parse(_strCtrl.text); }
      _updateData();
    });
    _conCtrl.addListener((){
      if (_conCtrl.text == "") { data.con = 0; }
      else {data.con = int.parse(_conCtrl.text);}
      _updateData();
    });
    _sizCtrl.addListener((){
      if (_sizCtrl.text == "") { data.siz = 0; }
      else {data.siz = int.parse(_sizCtrl.text);}
      _updateData();
    });
    _dexCtrl.addListener((){
      if (_dexCtrl.text == "") { data.dex = 0; }
      else {data.dex = int.parse(_dexCtrl.text);}
      _updateData();
    });
    _appCtrl.addListener((){
      if (_appCtrl.text == "") { data.app = 0; }
      else {data.app = int.parse(_appCtrl.text);}
      _updateData();
    });
    _intCtrl.addListener((){
      if (_intCtrl.text == "") { data.int = 0; }
      else {data.int = int.parse(_intCtrl.text);}
      _updateData();
    });
    _powCtrl.addListener((){
      if (_powCtrl.text == "") { data.pow = 0; }
      else {data.pow = int.parse(_powCtrl.text);}
      _updateData();
    });
    _eduCtrl.addListener((){
      if (_eduCtrl.text == "") { data.edu = 0; }
      else {data.edu = int.parse(_eduCtrl.text);}
      _updateData();
    });
    _lucCtrl.addListener((){
      if (_lucCtrl.text == "") { data.luc = 0; }
      else {data.luc = int.parse(_lucCtrl.text);}
      _updateData();
    });
  }

  @override
  void dispose() {
    _strCtrl.dispose();
    _conCtrl.dispose();
    _sizCtrl.dispose();
    _dexCtrl.dispose();
    _appCtrl.dispose();
    _intCtrl.dispose();
    _powCtrl.dispose();
    _eduCtrl.dispose();
    _lucCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: GestureDetector(
        child: Column (
          children: <Widget>[
            SizedBox(height: 20,),
            _buildTitle(),
            _buildScrollablePart(),
            _buildFixedPart()
          ],
        ),
        // 点击空白处收起键盘
        onTap: (){ FocusScope.of(context).requestFocus(FocusNode()); },
      )
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Attributes", style: _getTextStyle(40)),
    );
  }

  Widget _buildAttrRows(String attrName, TextEditingController attrCtrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 100,
          child: Text(attrName + ": ", style: _getTextStyle(20),),
        ),
        Container(
          width: 100,
          height: 40,
          child: Center(
            child: TextField(
              //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number, // iOS 的键盘无法收回
              textAlign: TextAlign.center,
              controller: attrCtrl,
              style: _getTextStyle(20),
            ),
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTheme.textColor))
          ),
        )
      ],
    );
  }
  Widget _buildScrollablePart() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAttrRows("STR", _strCtrl),
            _buildAttrRows("CON", _conCtrl),
            _buildAttrRows("SIZ", _sizCtrl),
            _buildAttrRows("DEX", _dexCtrl),
            _buildAttrRows("APP", _appCtrl),
            _buildAttrRows("INT", _intCtrl),
            _buildAttrRows("POW", _powCtrl),
            _buildAttrRows("EDU", _eduCtrl),
            _buildAttrRows("LUCK", _lucCtrl)
          ],
        ),
      ),
    );
  }

  Widget _buildFixedPart() {
    Widget _buildText(String textContent){
      return Center(child: Text(textContent, style: _getTextStyle(14),),);
    }
    return Container(
      height: 100,
      child: BlocBuilder<CharSheetBloc, CharSheetState>(
        builder: (context, state) {
          AttrData fixedData = state.charData[pageTag];
          return GridView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, childAspectRatio: 1.4
            ),
            children: <Widget>[
              _buildText("SAN: "),
              _buildText(fixedData.san.toString()),
              _buildText("HP: "),
              _buildText(fixedData.hitPoints.toString()),
              _buildText("MP: "),
              _buildText(fixedData.magicPoints.toString()),
              _buildText("MOV: "),
              _buildText(fixedData.mov.toString()),
              _buildText("Damage Bonus: "),
              _buildText(fixedData.damageBonus),
              _buildText("Build: "),
              _buildText(fixedData.build),
            ],
          );
        },
      )
    );
  }

  void _updateData() { bloc.add(UpdateData(pageTag, data)); }
}