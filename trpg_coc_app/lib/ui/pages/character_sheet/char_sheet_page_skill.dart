part of 'char_sheet_pages.dart';

// 说明
/* 技能表页制作了两个部分：
 * 1、quickFill - 用于按照规定快速填写
 * 2、skillTable - 用于查看（以及选择兴趣技能）或者全自由填写
 *
 * 填写技能表设计有两种模式，根据 KP 要求决定
 * 1、quickFill + skillTable：
 *    此时以 quickFill 为主
 *    skillTable 功能为选择兴趣技能以及技能表查看（一览）
 * 2、仅 skillTable（未完成）：
 *    当 KP 允许以较大的自由度填写技能表时使用
 *    skillTable 全自由开放
 *
 * // TODO 暂时未完成自定义技能的功能
 */

class CharSheetPageSkill extends CharSheetPage {
  @override
  String pageTag = "skill";
  CharSheetBloc bloc;
  CharSheetPageSkill(this.bloc);

  @override
  _CharSheetPageSkillState createState() {
    return _CharSheetPageSkillState(bloc, pageTag);
  }
}

class _CharSheetPageSkillState extends State<CharSheetPageSkill> {
  CharSheetBloc bloc;
  String pageTag;
  _CharSheetPageSkillState(this.bloc, this.pageTag);

  SkillData skillData;  // 存储最终的技能表

  AttrData attrData;    // 根据属性设置技能点数
  OccuData occuData;    // 根据职业数据来设置 UI
  int occuSkillPoints = 226;      // 职业技能点数
  int interestSkillPoints = 140;  // 兴趣技能点数

  List<TextEditingController> _quickFillCtrls = [];

  TextStyle _getTextStyle({double size = 14}) {
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
    occuData = bloc.state.charData["occu"];
    skillData = bloc.state.charData["skill"];
  }

  @override
  void dispose() {
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
            _buildOccuPage()
          ],
        ),
        // 点击空白处收起键盘
        onTap: (){ FocusScope.of(context).requestFocus(FocusNode()); },
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text("Skills", style: _getTextStyle(size: 40)),
    );
  }

  Widget _buildOccuPage() {
    if (occuData.isFinished()) {
      return _pageAfterOccuSelected();
    } else {
      return _pageBeforeOccuSelected();
    }
  }
  Widget _pageBeforeOccuSelected(){
    return Expanded(
      child: Center(
        child: Text(
          "Please choose your occupation first.",
          style: _getTextStyle(size: 20),
        ),
      ),
    );
  }
  Widget _pageAfterOccuSelected(){
    return Expanded(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _buildQuickFill(),
                  Divider(
                    height: 30,
                    indent: 20,
                    endIndent: 20,
                    color: AppTheme.textColor,
                    thickness: 1,
                  ),
                  _buildSkillTable()
                ],
              ),
            ),
          ),
          _buildFixedPart()
        ],
      ),
    );
  }
  
  Widget _buildQuickFill() {
    List<Widget> _buildChildren(SkillData skillData) {
      Widget _buildChild(int index) {
        List<SingleSkill> currentSkillGroup = skillData.qfOccuSkills[index];
        int currentChoice = skillData.qfChoices[index];

        Widget child;

        if (currentSkillGroup.length == 1){
          // 不可选技能
          SingleSkill skill = currentSkillGroup[0];
          // region 分配 TextEditingController
          TextEditingController currentCtrl = TextEditingController();
          currentCtrl.text = skill.occuVal.toString();
          currentCtrl.addListener((){
            if (currentCtrl.text == "") { skill.occuVal = 0; }
            else { skill.occuVal = int.parse(currentCtrl.text); }
            _updateData();
          });
          _quickFillCtrls.add(currentCtrl);
          // endregion

          // region 确定技能名字
          String skillName;
          if (skill.groupIndex != -1) {
            String groupName = skillData.skillManager.skillList[skill.groupIndex].name;
            skillName = groupName + " - " + skill.name;
          } else { skillName = skill.name; }
          // endregion

          child = Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  leading: Text(
                    skill.initialVal.toString() + "%",
                    style: _getTextStyle(),
                  ),
                  title: Text(skillName, style: _getTextStyle(),),
                ),
              ),
              Container(
                width: 30,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: currentCtrl,
                  style: _getTextStyle(),
                ),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.textColor))
                ),
              )
            ],
          );
        } else {
          // 可选技能
          // region 分配 TextEditingController
          TextEditingController currentCtrl = TextEditingController();
          if (currentChoice != -1) {
            currentCtrl.text = currentSkillGroup[currentChoice].occuVal.toString();
          }
          currentCtrl.addListener((){
            if (currentCtrl.text == "") {
              currentSkillGroup[currentChoice].occuVal = 0;
            } else {
              currentSkillGroup[currentChoice].occuVal = int.parse(currentCtrl.text);
            }
            _updateData();
          });
          _quickFillCtrls.add(currentCtrl);
          // endregion

          // region Build 所有可选项 (children: _choices)
          List<Widget> _choices = [];
          for (int i = 0; i < currentSkillGroup.length; i++){
            SingleSkill current = currentSkillGroup[i];
            Widget _choice = RadioListTile(
              groupValue: skillData.qfChoices[index],
              value: i,
              selected: skillData.qfChoices[index] == i,
              activeColor: AppTheme.textColor,
              onChanged: (newVal){
                skillData.qfChoices[index] = newVal;
                skillData.qfOccuSkills[index][skillData.qfChoices[index]].occuVal = 0;
                _updateData();
              },
              title: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    child: Text(
                      current.initialVal.toString(),
                      style: _getTextStyle(),
                    ),
                  ),
                  Text(current.name, style: _getTextStyle(),),
                ],
              ),
            );

            _choices.add(_choice);
          }
          // endregion

          child = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Theme(
                  data: ThemeData(
                    accentColor: AppTheme.textColor,
                    unselectedWidgetColor: AppTheme.textColor,
                  ),
                  child: ExpansionTile(
                    leading: Text(
                      currentChoice == -1 ? "" :
                      currentSkillGroup[currentChoice].initialVal.toString() + "%",
                      style: _getTextStyle(),
                    ),
                    title: Text(
                      currentChoice == -1 ?
                      "请选择" : currentSkillGroup[currentChoice].name.toString(),
                      style: _getTextStyle(),
                    ),
                    children: _choices,
                  ),
                ),
              ),
              Container(
                width: 30,
                child: currentChoice == -1 ?
                null : TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  controller: currentCtrl,
                  style: _getTextStyle(),
                ),
                decoration: currentChoice == -1 ?
                null : BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppTheme.textColor))
                ),
              )
            ],
          );
        }

        return child;
      }

      List<Widget> _children = [];
      for (int i = 0; i < skillData.qfChoices.length; i++){
        _children.add(_buildChild(i));
      }
      return _children;
    }
    
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(right: 10),
          child: Column(children: _buildChildren(state.charData[pageTag]),),
        );
      }
    );
  }

  Widget _buildSkillTable() {
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state){
        SkillData skillData = state.charData[pageTag];
        return SkillTable(skillData.skillManager,
                (data) => _skillTableUpdate(data));
      },
    );
  }

  Widget _buildFixedPart(){
    return BlocBuilder<CharSheetBloc, CharSheetState>(
      builder: (context, state){
        SkillData skillData = state.charData[pageTag];
        int occuValLeft = skillData.occuSkillPoints -
            skillData.skillManager.usedOccuVal;
        int interestValLeft = skillData.interestSkillPoints -
            skillData.skillManager.usedInterestVal;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            color: AppTheme.backgroundColor,
            elevation: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "剩余职业点：" + occuValLeft.toString(),
                  style: _getTextStyle(),
                ),
                Text(
                  "剩余兴趣点：" + interestValLeft.toString(),
                  style: _getTextStyle(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  void _skillTableUpdate(SkillManager updated){
    skillData.skillManager = updated;
    _updateData();
  }
  void _updateData() { bloc.add(UpdateData(pageTag, skillData)); }
}

// region SkillTable
class SkillTable extends StatefulWidget {
  SkillManager skillManager;
  Function updateData;

  SkillTable(this.skillManager, this.updateData);

  @override
  SkillTableState createState() => SkillTableState();
}
class SkillTableState extends State<SkillTable> {

  TextStyle _getTextStyle({double size = 14}) {
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
  }

  @override
  Widget build(BuildContext context){
    List<Widget> columnOne = [];
    List<Widget> columnTwo = [];

    for (int i = 0; i < 27; i++){
      columnOne.add(_buildOneSkill(widget.skillManager.skillList[i]));
    }
    for (int i = 27; i < widget.skillManager.skillList.length; i++){
      columnTwo.add(_buildOneSkill(widget.skillManager.skillList[i]));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: Column(children: columnOne,),),
        Expanded(child: Column(children: columnTwo,),),
      ],
    );
  }
  Widget _buildOneSkill(Skill skill) {
    if (skill is SingleSkill) { return _buildOneSingleSkill(skill); }
    else { return _buildOneGroupSkill(skill); }
  }
  Widget _buildOneGroupSkill(GroupSkill skill) {
    List<Widget> _children = [];
    // Add an add button first
    _children.add(
      ListTile(
        dense: true,
        title: FlatButton(
          shape: StadiumBorder(side: BorderSide(color: AppTheme.textColor)),
          child: Text("+", style: _getTextStyle(),),
          onPressed: () { _groupSkillAddTapped(skill, context); },
        ),
      )
    );
    // Add child occupation skills
    for (int i = 0; i < skill.occuSkills.length; i++){
      _children.add(_buildOneSingleSkill(skill.occuSkills[i]));
    }
    // Add child interest skills
    for (int i = 0; i < skill.interestSkills.length; i++){
      _children.add(_buildOneSingleSkill(skill.interestSkills[i]));
    }

    return Theme(
      data: ThemeData(
        accentColor: AppTheme.textColor,
        unselectedWidgetColor: AppTheme.textColor,
      ),
      child: ListTileTheme(
        dense: true,
        child: ExpansionTile(
          title: Text(skill.name, style: _getTextStyle(),),
          children: _children,
        ),
      ),
    );
  }
  Widget _buildOneSingleSkill(SingleSkill skill) {
    return GestureDetector(
      child: ListTile(
        dense: true,
        title: Text(skill.name, style: _getTextStyle(),),
        trailing: Text(skill.finalVal.toString(), style: _getTextStyle()),
      ),
      onTap: (){ _singleSkillTapped(skill, context); },
    );
  }

  void _groupSkillAddTapped(GroupSkill skill, BuildContext context){
    // region Build 所有该 GroupSkill 的子技能选择项
    List<Widget> _buildChildSkills(BuildContext context){
      List<Widget> childSkills = [];

      skill.childSkills.forEach((SingleSkill childSkill){
        if (childSkill.occuVal == 0 && childSkill.interestVal == 0){
          childSkills.add(FlatButton(
            child: Row(
              children: <Widget>[
                Container(
                  width: 30,
                  child: Text(
                    childSkill.initialVal.toString(),
                    style: _getTextStyle(),
                  ),
                ),
                Text(childSkill.name, style: _getTextStyle(),)
              ],
            ),
            onPressed: () {
              //Navigator.of(context).pop();
              _singleSkillTapped(childSkill, context);
            },
          ));
        }
      });

      return childSkills;
    }
    // endregion

    // region showDialog
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          title: Text(skill.name, style: _getTextStyle(),),
          content: Container(
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                children: _buildChildSkills(context),
              ),
            )
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: _getTextStyle(),),
            ), // OK Button
          ],
        );
      }
    );
    // endregion
  }

  void _singleSkillTapped(SingleSkill skill, BuildContext context){
    // region 分配 TextEditingController
    TextEditingController occuValCtrl = TextEditingController();
    occuValCtrl.text = skill.occuVal.toString();
    occuValCtrl.addListener((){
      if (occuValCtrl.text == "") { skill.occuVal = 0; }
      else { skill.occuVal = int.parse(occuValCtrl.text); }
      _updateSkillTable();
    });
    TextEditingController interestValCtrl = TextEditingController();
    interestValCtrl.text = skill.interestVal.toString();
    interestValCtrl.addListener((){
      if (interestValCtrl.text == "") { skill.interestVal = 0; }
      else { skill.interestVal = int.parse(interestValCtrl.text); }
      _updateSkillTable();
    });
    // endregion

    // region showDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.backgroundColor,
          title: Text(skill.name, style: _getTextStyle(),),
          content: Container(
            height: 70,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text("初始", style: _getTextStyle(),),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text("职业", style: _getTextStyle(),),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text("兴趣", style: _getTextStyle(),),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: Text(
                        skill.initialVal.toString(),
                        style: _getTextStyle(),
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: occuValCtrl,
                        style: _getTextStyle(),
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppTheme.textColor))
                      ),
                    ),
                    Container(
                      width: 30,
                      alignment: Alignment.center,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: interestValCtrl,
                        style: _getTextStyle(),
                      ),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppTheme.textColor))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok', style: _getTextStyle(),),
            ), // OK Button
          ],
        );
      }
    );
    // endregion
  }
  
  void _updateSkillTable(){ widget.updateData(widget.skillManager); }
}
// endregion
