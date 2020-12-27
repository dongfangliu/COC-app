part of 'char_sheet_pages.dart';

class CharSheetPageInvt extends CharSheetPage {
  @override
  String pageTag = "invt";
  CharSheetBloc bloc;
  CharSheetPageInvt(this.bloc);

  @override
  _CharSheetPageInvtState createState() {
    return _CharSheetPageInvtState(bloc, pageTag);
  }
}

class _CharSheetPageInvtState extends State<CharSheetPageInvt> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageInvtState(this.bloc, this.pageTag);

  String assetDesc;
  List<String> invts;

  TextEditingController assetDestCtrl;
  List<TextEditingController> invtCtrls;
  List<Widget> invtTiles;

  TextStyle _getTextStyle(double size) {
    return TextStyle(
        fontFamily: 'papyrus',
        fontSize: size,
        color: AppTheme.textColor,
        decoration: TextDecoration.none
    );
  }

  InvtData invtData;
  // TODO 需要使用时代、国家来判断生活水平
  int cr; // 从技能表里拉来的信用评级
  // String era;

  @override
  void initState() {
    super.initState();
    invtData = bloc.state.charData["invt"];

    // region 获取数据
    assetDesc = invtData.assetDesc;
    invts = invtData.invts;

    // 获取辅助数据
    // 获取信用评级
    SkillData skillData = bloc.state.charData["skill"];
    try {
      // 防止技能表还没开始填
      SingleSkill crSkill = skillData.skillManager.skillList[8];
      cr = crSkill.finalVal;
    } catch (e) {
      cr = 0;
    }
    // 获取时代
    // InfoData infoData = bloc.state.charData["info"];
    // era = infoData.era;
    // 根据信用评级
    // endregion

    // region 自动生成的数据
    if (cr <= 0) {
      invtData.livingStd = "身无分文";
      invtData.cash = 0.5;
      invtData.otherAsset = 0;
      invtData.consumptionStd = 0.5;
    } else if (1 <= cr && cr <= 9) {
      invtData.livingStd = "拮据";
      invtData.cash = cr.toDouble();
      invtData.otherAsset = cr * 10;
      invtData.consumptionStd = 2;
    } else if (10 <= cr && cr <= 49) {
      invtData.livingStd = "标准";
      invtData.cash = cr.toDouble() * 2;
      invtData.otherAsset = cr * 50;
      invtData.consumptionStd = 10;
    } else if (50 <= cr && cr <= 89) {
      invtData.livingStd = "小康";
      invtData.cash = cr.toDouble() * 5;
      invtData.otherAsset = cr * 500;
      invtData.consumptionStd = 50;
    } else if (90 <= cr && cr <= 98) {
      invtData.livingStd = "富裕";
      invtData.cash = cr.toDouble() * 20;
      invtData.otherAsset = cr * 2000;
      invtData.consumptionStd = 250;
    } else {
      invtData.livingStd = "富豪";
      invtData.cash = 50000;
      invtData.otherAsset = 5000000;
      invtData.consumptionStd = 5000;
    }
    // endregion

    // region 初始化 TextEditingControllers
    assetDestCtrl = TextEditingController();

    invtCtrls = [];
    for (String invt in invts) {
      TextEditingController invtCtrl = TextEditingController();
      // invtCtrl.text = invt;
      invtCtrls.add(invtCtrl);
      //
      // invtCtrl.addListener(() {
      //   List<String> newInvts = [];
      //   for (TextEditingController invtCtrl in invtCtrls) {
      //     newInvts.add(invtCtrl.text);
      //   }
      //   invtData.invts = newInvts;
      //   _updateData();
      // });
    }
    // endregion

    invtTiles = [];
  }

  @override
  void dispose() {
    List<String> newInvts = [];
    for (TextEditingController invtCtrl in invtCtrls) {
      if (invtCtrl.text != "") { newInvts.add(invtCtrl.text); }
    }
    invtData.invts = newInvts;
    bloc.add(UpdateData(pageTag, invtData));
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
            _buildInvtPage()
          ],
        ),
        // 点击空白处收起键盘
        onTap: (){ FocusScope.of(context).requestFocus(FocusNode()); },
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Inventory", style: _getTextStyle(40)),
    );
  }

  Widget _buildInvtPage() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildFixed(),
            _buildInvtDesc(),
            _buildInvts()
          ],
        ),
      ),
    );
  }

  Widget _buildFixed() {
    double textSize = 14;

    Widget _buildRow1() {
      return Center(
        child: IntrinsicWidth(
          child: ListTile(
            dense: true,
            leading: Text(
              "信用评级：",
              style: _getTextStyle(textSize),
            ),
            title: Text(
              cr.toString(),
              style: _getTextStyle(textSize),
            ),
          ),
        )
      );
    }
    Widget _buildRow2() {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              dense: true,
              leading: Text(
                "生活水平",
                style: _getTextStyle(textSize),
              ),
              title: Text(
                invtData.livingStd,
                style: _getTextStyle(textSize),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              dense: true,
              leading: Text(
                "现金",
                style: _getTextStyle(textSize),
              ),
              title: Text(
                invtData.cash.toString(),
                style: _getTextStyle(textSize),
              ),
            ),
          )
        ],
      );
    }
    Widget _buildRow3() {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              dense: true,
              leading: Text(
                "其他资产",
                style: _getTextStyle(textSize),
              ),
              title: Text(
                invtData.otherAsset.toString(),
                style: _getTextStyle(textSize),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              dense: true,
              leading: Text(
                "消费水平",
                style: _getTextStyle(textSize),
              ),
              title: Text(
                invtData.consumptionStd.toString(),
                style: _getTextStyle(textSize),
              ),
            ),
          )
        ],
      );
    }

    return Column(
      children: [
        _buildRow1(),
        _buildRow2(),
        _buildRow3()
      ],
    );
  }

  Widget _buildInvtDesc() {
    double textSize = 18;

    assetDestCtrl.text = invtData.assetDesc;

    assetDestCtrl.addListener(() {
      invtData.assetDesc = assetDestCtrl.text;
      _updateData();
    });

    return Column(
      children: [
        Text("请在此详述您的资产：", style: _getTextStyle(textSize),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            controller: assetDestCtrl,
            style: _getTextStyle(textSize),
          ),
        )
      ],
    );
  }

  Widget _buildInvts() {
    double textSize = 18;

    Widget _buildAllInvts() {
      return BlocBuilder<CharSheetBloc, CharSheetState>(
        builder: (context, state) {
          InvtData invtData = state.charData["invt"];
          List<String> invts = invtData.invts;

          invtCtrls = [];
          invtTiles = [];

          for (int i = 0; i < invts.length; i++) {
            // 添加一个 TextEditingController
            TextEditingController invtCtrl = TextEditingController();
            invtCtrl.text = invts[i];
            invtCtrls.add(invtCtrl);

            invtCtrl.addListener(() {
              invts[i] = invtCtrl.text;
            });

            invtTiles.add(ListTile(
              title: TextField(
                keyboardType: TextInputType.text,
                controller: invtCtrl,
                style: _getTextStyle(textSize),
              ),
            ));
          }

          return Column( children: invtTiles, );
        },
      );
    }

    Widget _buildAddButton(){
      return Container(
        width: 260,
        height: 50,
        decoration: BoxDecoration(
            border: Border()
        ),
        child: FlatButton(
          shape: StadiumBorder(side: BorderSide(color: AppTheme.textColor)),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.plus,
                color: AppTheme.textColor,
              ),
              Expanded(
                  child: Center(
                    child: Text("Add an inventory", style: _getTextStyle(textSize),),
                  )
              )
            ],
          ),
          onPressed: () { _addInvt(); },
        ),
      );
    }

    return Center(
      child: IntrinsicWidth(
        child: Column(
          children: [
            Text("装备和道具：", style: _getTextStyle(textSize),),
            _buildAllInvts(),
            _buildAddButton()
          ],
        ),
      ),
    );
  }

  void _addInvt() {
    invts.add("");
    bloc.add(UpdateData(pageTag, invtData));
    // _updateData();
  }

  void _updateData() {
    bloc.add(UpdateData(pageTag, invtData));
  }
}