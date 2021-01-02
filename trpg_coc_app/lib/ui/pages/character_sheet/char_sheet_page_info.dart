part of 'char_sheet_pages.dart';

class CharSheetPageInfo extends CharSheetPage {
  @override
  String pageTag = "info";
  CharSheetBloc bloc;
  CharSheetPageInfo(this.bloc);

  @override
  _CharSheetPageInfoState createState() {
    return _CharSheetPageInfoState(bloc, pageTag);
  }
}

class _CharSheetPageInfoState extends State<CharSheetPageInfo> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageInfoState(this.bloc, this.pageTag);

  InfoData data;
  TextEditingController _nameCtrl = TextEditingController();
  final List<String> _eras = ["", "1890s", "1920s", "Modern Time"];
  final List<String> _sexes = ["", "Male", "Female", "Lesbian", "Gay", 
    "Bisexual", "Transgender", "Queer", "Intersex", "Asexual", "+"];
  TextEditingController _residenceCtrl = TextEditingController();
  TextEditingController _birthplaceCtrl = TextEditingController();

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

    _nameCtrl.text = data.name;
    _residenceCtrl.text = data.residence;
    _birthplaceCtrl.text = data.birthplace;

    _nameCtrl.addListener((){
      data.name = _nameCtrl.text;
      _updateData();
    });
    _residenceCtrl.addListener((){
      data.residence = _residenceCtrl.text;
      _updateData();
    });
    _birthplaceCtrl.addListener((){
      data.birthplace = _birthplaceCtrl.text;
      _updateData();
    });
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
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
          _buildInfoPage()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Basic Info", style: _getTextStyle(40)),
    );
  }

  Widget _buildInfoPage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAvatar(),
            _buildName(),
            _buildEra(),
            _buildAge(),
            _buildSex(),
            _buildResidence(),
            _buildBirthPlace()
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    // TODO 人物卡的头像暂时只作占位
    return CircleAvatar(
      radius: 45,
      backgroundImage:
//      buildCOCEditableImg(bloc),


      AssetImage('assets/images/user_avatar.png'),
      backgroundColor: Colors.grey,
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Name: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _nameCtrl,
              keyboardType: TextInputType.text,
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

  Widget _buildEra() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Era: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: FlatButton(
            child: BlocBuilder<CharSheetBloc, CharSheetState>(
              builder: (context, state){
                return Text(
                  data.era == "" ? "Not Selected" : data.era,
                  style: _getTextStyle(20),
                );
              },
            ),
            onPressed: _showEraPicker,
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.textColor))
          ),
        )
      ],
    );
  }
  void _showEraPicker() {
    // Build the picker items
    List<Widget> _getEraWidgets() {
      List<Widget> _eraWidgets = [];
      for (int itemNo = 0; itemNo < _eras.length; itemNo++) {
        _eraWidgets.add(Text(_eras[itemNo], style: _getTextStyle(20),));
      }
      return _eraWidgets;
    }
    // Build the picker
    final picker = CupertinoPicker(
      backgroundColor: AppTheme.backgroundColor,
      itemExtent: 40,
      onSelectedItemChanged: (position){
        data.era = _eras[position];
        _updateData();
      },
      children: _getEraWidgets()
    );

    showCupertinoModalPopup(context: context, builder: (context) {
      return Container(
        height: 200,
        child: picker,
      );
    });
  }

  Widget _buildAge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Age: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: FlatButton(
            child: BlocBuilder<CharSheetBloc, CharSheetState>(
              builder: (context, state){
                return Text(
                  data.age == 0 ? "Not Selected" : data.age.toString(),
                  style: _getTextStyle(20),
                );
              },
            ),
            onPressed: _showAgePicker,
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.textColor))
          ),
        )
      ],
    );
  }
  void _showAgePicker() {
    // Build the picker items
    List<Widget> _getEraWidgets() {
      List<Widget> _ageWidgets = [Text("", style: _getTextStyle(20),)];
      for (int age = 1; age < 150; age++) {
        _ageWidgets.add(Text(age.toString(), style: _getTextStyle(20),));
      }
      return _ageWidgets;
    }
    // Build the picker
    final picker = CupertinoPicker(
      backgroundColor: AppTheme.backgroundColor,
      itemExtent: 40,
      onSelectedItemChanged: (position){
        data.age = position;
        _updateData();
      },
      children: _getEraWidgets()
    );

    showCupertinoModalPopup(context: context, builder: (context) {
      return Container(
        height: 200,
        child: picker,
      );
    });
  }

  Widget _buildSex() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Sex: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: FlatButton(
            child: BlocBuilder<CharSheetBloc, CharSheetState>(
              builder: (context, state){
                return Text(
                  data.sex == "" ? "Not Selected" : data.sex.toString(),
                  style: _getTextStyle(20),
                );
              },
            ),
            onPressed: _showSexPicker,
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.textColor))
          ),
        )
      ],
    );
  }
  void _showSexPicker() {
    // Build the picker items
    List<Widget> _getEraWidgets() {
      List<Widget> _eraWidgets = [];
      for (int itemNo = 0; itemNo < _sexes.length; itemNo++) {
        _eraWidgets.add(Text(_sexes[itemNo], style: _getTextStyle(20),));
      }
      return _eraWidgets;
    }
    // Build the picker
    final picker = CupertinoPicker(
      backgroundColor: AppTheme.backgroundColor,
      itemExtent: 40,
      onSelectedItemChanged: (position){
        data.sex = _sexes[position];
        _updateData();
      },
      children: _getEraWidgets()
    );

    showCupertinoModalPopup(context: context, builder: (context) {
      return Container(
        height: 200,
        child: picker,
      );
    });
  }

  Widget _buildResidence() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Residence: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _residenceCtrl,
              keyboardType: TextInputType.text,
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

  Widget _buildBirthPlace() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Text("Birthplace: ", style: _getTextStyle(20),),
        ),
        Container(
          width: 180,
          height: 40,
          child: Center(
            child: TextField(
              textAlign: TextAlign.center,
              controller: _birthplaceCtrl,
              keyboardType: TextInputType.text,
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

  void _updateData() { bloc.add(UpdateData(pageTag, data)); }
}