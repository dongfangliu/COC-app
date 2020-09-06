
import 'package:flutter/services.dart';

import '../../../data/gameGroup/gameGroup.dart';
import '../../../data/gameGroup/gameGroupUserData.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../widgets/dialogs/statefulDialog.dart';
import 'gamegroup_card.dart';
import '../../../styles/gamegroups_pages_style.dart';
class groupSearchFilter {
  int _minNum = 0;
  int _maxNum = 100;
  DateTime _startTimeStart = DateTime(2019), _startTimeEnd = DateTime(2020);
  List<bool> _status = [false, false, false, false];
  List<String> statusStrs = ["HIRING", "HIRED_FULL", "ONGOING", "ARCHIVED"];
}

class gameGroupsPage extends StatefulWidget {
  groupSearchFilter _searchFilter = groupSearchFilter();
  List<gameGroup> ggs = [
    new gameGroup(),
    new gameGroup(),
    new gameGroup(),
  ];
  @override
  State<StatefulWidget> createState() {
    for (int i = 0; i < ggs.length; i++) {
      ggs[i].name = "Test group  " + i.toString();
      ggs[i].description = "description  " + i.toString();
      ggs[i].participants = [new gameGroupUserData(), new gameGroupUserData()];
//      ggs[i].module = new ;
    }
    return new gameGroupsPageState();
    ;
  }
}

class gameGroupsPageState extends State<gameGroupsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: buildSearchPage(context),

        appBar: null,
        );
  }

  Widget buildSearchPage(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        getSearchPanel(context),
        getSearchHeader(context),
        buildGroupList(context)
      ],
    );
  }

  Expanded buildGroupList(BuildContext context) {
    return new Expanded(
      child: new ListView.builder(
          itemCount: widget.ggs.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new gameGroupCard(widget.ggs[index]);
          }),
    );
  }

  Widget getSearchPanel(BuildContext context) {
    Widget searchTextField = new Container(
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: new BoxDecoration(
        color: gameGroupPageStyle.searchPanelBgColor,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      padding: EdgeInsets.only(
        left: 10,
      ),
      child: TextField(
        cursorColor: gameGroupPageStyle.searchPanelCursorColor, //设置光标
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(gameGroupPageStyle.searchIcon),
            hintText: gameGroupPageStyle.searchPanelHintText,
            hintStyle: new TextStyle(fontSize: gameGroupPageStyle.searchPanelHintTextFontSize, color: gameGroupPageStyle.searchPanelHintTextColor)),
        style: new TextStyle(fontSize: gameGroupPageStyle.searchPanelInputTextFontSize, color: gameGroupPageStyle.searchPanelInputTextColor),
      ),
    );
    Widget searchButton = new Container(
      decoration: BoxDecoration(
          color: gameGroupPageStyle.searchBtnColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: new FlatButton(
          onPressed: null,
          child: new Text(
            gameGroupPageStyle.searchBtnText,
            style: new TextStyle(fontSize: gameGroupPageStyle.searchBtnFontSize, color: gameGroupPageStyle.seachBtnFontColor),
          )),
    );
    return new Container(
        height: MediaQuery.of(context).size.height * 0.08,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: searchTextField),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: searchButton,
            )
          ],
        ));
  }

  Widget getSearchHeader(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new RaisedButton(
          child: Text(gameGroupPageStyle.headerTextTime),
          onPressed: () =>              showStatefulDialog(context, getDatePicker)
              
        )),
        new Expanded(
            child: new RaisedButton(
          child: Text(gameGroupPageStyle.headerTextNum),
          onPressed: () => showStatefulDialog(context, getManNumSelect)
        )),
        new Expanded(
            child: new RaisedButton(
          child: Text(gameGroupPageStyle.headerTextGroupStatus),
          onPressed: () => 
              showStatefulDialog(context, getStatusFilterCB)
        )),
      ],
    );
  }

  Widget getDatePicker(BuildContext context, StateSetter setState) {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          color: gameGroupPageStyle.searchFilterDialogBgColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(15),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Expanded(
              child: FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime.now()
                          .subtract(new Duration(days: 30)), // 减 30 天
                      lastDate: new DateTime.now()
                          .add(new Duration(days: 30)), // 加 30 天
                    ).then((DateTime val) {
                      if (val != null) {
                        widget._searchFilter._startTimeStart = val;
                      }
                      setState(() {}); // 2018-07-12 00:00:00.000
                    }).catchError((err) {
                      print(err);
                    });
                  },
                  child: new Text(
                      widget._searchFilter._startTimeStart.toString()))),
          new Container(
              height: MediaQuery.of(context).size.height * 0.025,
              child: VerticalDivider(
                thickness: 1,
              )),
          new Expanded(
              child: new FlatButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime.now()
                          .subtract(new Duration(days: 30)), // 减 30 天
                      lastDate: new DateTime.now()
                          .add(new Duration(days: 30)), // 加 30 天
                    ).then((DateTime val) {
                      if (val != null) {
                        widget._searchFilter._startTimeEnd = val;
                        print(val.toString());
                      }
                      setState(() {}); // 2018-07-12 00:00:00.000
                    }).catchError((err) {
                      print(err);
                    });
                  },
                  child:
                      new Text(widget._searchFilter._startTimeEnd.toString()))),
          new RaisedButton(
              child: Text(gameGroupPageStyle.confirmFilterSetText),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }

  Widget getManNumSelect(BuildContext context, StateSetter setState) {

    return new Container(
        decoration: BoxDecoration(
            color: gameGroupPageStyle.searchFilterDialogBgColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.all(15),
        child: new Column(mainAxisSize: MainAxisSize.min, children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                  child: new Container(
                      margin: EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: new TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: gameGroupPageStyle.numSelectHintTextMin),
//                  autofocus: true,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ], //允许的输入格式
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        onChanged: (text) {
                          //内容改变的回调
                          widget._searchFilter._minNum = int.parse(text);
                        },
                      ))),
              new Flexible(
                child: new Container(
                    margin: EdgeInsets.all(2),
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: new TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: gameGroupPageStyle.numSelectHintTextMax),
//                  autofocus: true,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ], //允许的输入格式
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onChanged: (text) {
                        widget._searchFilter._maxNum = int.parse(text);
                      },
                    )),
              )
            ],
          ),
          new RaisedButton(
              child: Text(gameGroupPageStyle.confirmFilterSetText),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ]));
  }

  Widget getStatusFilterCB(BuildContext context, StateSetter setState) {
    return new Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
          color: gameGroupPageStyle.searchFilterDialogBgColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[0]),
                value: widget._searchFilter._status[0],
                onChanged: (val) {
                  widget._searchFilter._status[0] = val;
                  setState(() {});
                }),
            new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[1]),
                value: widget._searchFilter._status[1],
                onChanged: (val) {
                  widget._searchFilter._status[1] = val;
                  setState(() {});
                }),
            new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[2]),
                value: widget._searchFilter._status[2],
                onChanged: (val) {
                  widget._searchFilter._status[2] = val;
                  setState(() {});
                }),
            new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[3]),
                value: widget._searchFilter._status[3],
                onChanged: (val) {
                  widget._searchFilter._status[3] = val;
                  setState(() {});
                }),
            new RaisedButton(
                child: Text(gameGroupPageStyle.confirmFilterSetText),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]),
    );
  }
}

