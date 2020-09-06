part of 'char_sheet_pages.dart';

class CharSheetPageCombat extends CharSheetPage {
  @override
  String pageTag = "combat";
  CharSheetBloc bloc;
  CharSheetPageCombat(this.bloc);

  @override
  _CharSheetPageCombatState createState() {
    return _CharSheetPageCombatState(bloc, pageTag);
  }
}

class _CharSheetPageCombatState extends State<CharSheetPageCombat> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageCombatState(this.bloc, this.pageTag);

  AttrData attrData;
  CombatData combatData;

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
    attrData = bloc.state.charData["attr"];
    combatData = bloc.state.charData[pageTag];
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
          _buildCombatAttrs(),
          _buildWeaponListTitle(),
          _buildWeaponPage()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Combat", style: _getTextStyle(40)),
    );
  }
  Widget _buildCombatAttrs() {
    Widget _buildText(String text){
      return Container(
        width: 50,
        child: Center(
          child: Text(text, style: _getTextStyle(14),),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildText("Damge Bonus: "),
        _buildText(attrData.damageBonus),
        _buildText("Build: "),
        _buildText(attrData.build),
        _buildText("Dodge: "),
        _buildText(attrData.dodge.toString()),
      ],
    );
  }
  Widget _buildWeaponListTitle() {
    return Center(
      child: Text("Weapon List", style: _getTextStyle(20)),
    );
  }
  Widget _buildWeaponPage() {
    // Build Add Weapon Button
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
                    child: Text("Add a new weapon", style: _getTextStyle(20),),
                  )
              )
            ],
          ),
          onPressed: () { _onAddWeaponButtonPressed(context); },
        ),
      );
    }

    List<Widget> _buildChosenWeaponList(CharSheetState state) {
      Widget _buildWeaponBrief(Weapon weapon) {
        void _showDetail(BuildContext context) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppTheme.backgroundColor,
                content: Column(
                  children: <Widget>[
                    Text("Name: " + weapon.name, style: _getTextStyle(20),),
                    Text("Use Skill: " + weapon.useSkillRow.toString(), style: _getTextStyle(20),),
                    Text("Damage: " + weapon.damage, style: _getTextStyle(20),),
                    Text("Range: " + weapon.range, style: _getTextStyle(20),),
                    Text("Penetrable: " + weapon.penetrable.toString(), style: _getTextStyle(20),),
                  ],
                ),
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

        return GestureDetector(
          onLongPress: () { _showDetail(context); },
          child: Center(
            child: Text(weapon.name, style: _getTextStyle(20),),
          ),
        );
      }

      List<Widget> _chosenWeapons = [];
      _chosenWeapons.add(_buildAddButton());

      CombatData combatData = state.charData[pageTag];
      for (int i = 0; i < combatData.weaponList.length; i++) {
        _chosenWeapons.add(_buildWeaponBrief(combatData.weaponList[i]));
      }

      return _chosenWeapons;
    }

    return SingleChildScrollView(
      child: BlocBuilder<CharSheetBloc, CharSheetState>(
        builder: (context, state){
          return Column(
            children:_buildChosenWeaponList(state),
          );
        },
      ),
    );
  }

  void _onAddWeaponButtonPressed(BuildContext context){
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_){ return _WeaponSelectPage(bloc, pageTag); }
      )
    );
  }

}

class _WeaponSelectPage extends StatelessWidget {
  // TODO 考虑加一个搜索按钮
  CharSheetBloc bloc;
  String pageTag;
  _WeaponSelectPage(this.bloc, this.pageTag);

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
        middle: Text("Choose your weapon", style: _getTextStyle(20),),
      ),
      child: _buildWeaponList(context)
    );
  }

  Widget _buildWeaponList(BuildContext context){
    // Load weapon data
    Future<List<Weapon>> loadWeapons() async {
      try {
        WeaponListManager manager = WeaponListManager();
        return await manager.readWeaponList();
      } catch (e) { print(e); return null; }
    }

    // Build header
    Widget _buildHeader(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            child: Text("Name", style: _getTextStyle(14),),
          ),
          Container(
            width: 100,
            child: Text("Use Skill", style: _getTextStyle(14),),
          ),
          Container(
            width: 120,
            child: Text("damage", style: _getTextStyle(14),),
          )
        ],
      );
    }
    // Build all the weapons
    List<Widget> _buildWeapons(List<Weapon> weaponList) {
      // Build a single weapon
      Widget _buildOneWeapon(Weapon weapon) {
        return GestureDetector(
          // onLongPress: () {_showDialog(weapon.intro, context); },
          onTap: () { _onWeaponTapped(weapon, context); },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                child: Text(weapon.name, style: _getTextStyle(14),),
              ),
              Container(
                width: 100,
                child: Text(
                  weapon.useSkillRow.toString(),
                  style: _getTextStyle(14),
                ),
              ),
              Container(
                width: 120,
                child: Text(weapon.damage, style: _getTextStyle(14),),
              )
            ],
          ),
        );
      }

      List<Widget> _weapons = [];
      for (int index = 0; index < weaponList.length; index++){
        _weapons.add(_buildOneWeapon(weaponList[index]));
      }
      return _weapons;
    }

    return Column(
      children: <Widget>[
        _buildHeader(),
        FutureBuilder<List<Weapon>> (
          future: loadWeapons(),
          builder: (BuildContext context, AsyncSnapshot<List<Weapon>> snapshot){
            if (snapshot.hasData) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildWeapons(snapshot.data),
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

  void _onWeaponTapped(Weapon weapon, BuildContext context){
    CombatData data = bloc.state.charData[pageTag];
    data.weaponList.add(weapon);
    bloc.add(UpdateData(pageTag, data));
    Navigator.of(context).pop();
  }

}