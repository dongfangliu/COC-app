import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data/gameGroup.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class groupSearchFilter {
  int _minNum = 0;
  int _maxNum = 100;
  DateTime _startTimeStart = DateTime(2019),
      _startTimeEnd = DateTime(2020);
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
      ggs[i].participants = [new gameGroup_UserData()];
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
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            getSearchPanel(context),
            getSearchHeader(context),
              new Expanded(
                child: new ListView.builder(
                    itemCount: widget.ggs.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new gameGroupCard(widget.ggs[index]);
                    }),
              )
          ],
        ),
//          getSearchMenuItem(context)

        appBar: AppBar(
          leading: Text(""),
        ));
  }

  Widget getSearchPanel(BuildContext context) {
    Widget searchTextField = new Container(
      decoration: new BoxDecoration(
        color: Colors.grey,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      child: TextField(
        cursorColor: Colors.white, //设置光标
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.search),
            hintText: "Group name",
            hintStyle: new TextStyle(fontSize: 14, color: Colors.white)),
        style: new TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
    Widget searchButton = new Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: new FlatButton(
          onPressed: null,
          child: new Text(
            "Search",
            style: new TextStyle(fontSize: 14, color: Colors.white),
          )),
    );
    return new Container(
        height: 50,
        padding: EdgeInsets.all(5),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: searchTextField,
              flex: 1,
            ),
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
          child: Text("开团时间"),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return Dialog(
                    child: getDatePicker(context, setState),
                    backgroundColor: Colors.transparent,
                  );
                });
              }),
        )),
        new Expanded(
            child: new RaisedButton(
          child: Text("人数"),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return Dialog(
                    child: getManNumSelect(context, setState),
                    backgroundColor: Colors.transparent,
                  );
                });
              }),
        )),
        new Expanded(
            child: new RaisedButton(
          child: Text("状态"),
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, setState) {
                  return Dialog(
                    child: getStatusFilterCB(context, setState),
                    backgroundColor: Colors.transparent,
                  );
                });
              }),
        )),
      ],
    );
  }

  Widget getDatePicker(BuildContext context, StateSetter setState) {
    return new Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
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
              height: 15,
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
                  child: new Text(
                      widget._searchFilter._startTimeEnd.toString()))),
          new RaisedButton(child:Text("Confirm"),onPressed: (){Navigator.of(context).pop();})
        ],
      ),
    );
  }

  Widget getManNumSelect(BuildContext context, StateSetter setState) {
    return new Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(15),
      child:
      new Column(
        mainAxisSize: MainAxisSize.min,
          children:[
      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Flexible(
              child: new Container(
                  margin: EdgeInsets.all(2),
                  width: 60,
                  height: 40,
                  child: new TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "min"),
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
                width: 60,
                height: 40,
                child: new TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "max"),
//                  autofocus: true,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ], //允许的输入格式
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onChanged: (text) {
                    //内容改变的回调
                    widget._searchFilter._maxNum = int.parse(text);
                  },
                )),
          )
        ],
      ), new RaisedButton(child:Text("Confirm"),onPressed: (){Navigator.of(context).pop();})])
    );
  }

  Widget getStatusFilterCB(BuildContext context, StateSetter setState) {
    return new Container(
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(5),
      child: new Column(children: <Widget>[
        new Expanded(
            child: new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[0]),
                value: widget._searchFilter._status[0],
                onChanged: (val) {
                  widget._searchFilter._status[0] = val;
                  setState(() {});
                })),
        new Expanded(
            child: new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[1]),
                value: widget._searchFilter._status[1],
                onChanged: (val) {
                  widget._searchFilter._status[1] = val;
                  setState(() {});
                })),
        new Expanded(
            child: new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[2]),
                value: widget._searchFilter._status[2],
                onChanged: (val) {
                  widget._searchFilter._status[2] = val;
                  setState(() {});
                })),
        new Expanded(
            child: new CheckboxListTile(
                title: Text(widget._searchFilter.statusStrs[3]),
                value: widget._searchFilter._status[3],
                onChanged: (val) {
                  widget._searchFilter._status[3] = val;
                  setState(() {});
                })),
        new RaisedButton(child:Text("Confirm"),onPressed: (){Navigator.of(context).pop();})
      ]),
    );
  }
}

class gameGroupCard extends StatefulWidget {
  gameGroup group;
  @override
  createState() => new gameGroupCardState();

  gameGroupCard(this.group) {}
}

class gameGroupCardState extends State<gameGroupCard> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Dialog(
                  child: getDetailPage(context, setState),
                  backgroundColor: Colors.transparent,
                );
              });
            });
      },
      child: new CachedNetworkImage( // module thumbnail
        imageUrl:'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588157187534&di=57cc7cfbfc64d5fe7234760784afd00a&imgtype=0&src=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2014%2F1006%2Fe94e4f70870be76a018dff428306c5a3.jpg',
        imageBuilder: (context, imageProvider) => new Container(
            height: 150,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0)
              ],
              image:
              DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
            child: new Stack(fit: StackFit.expand, children: <Widget>[
              new Positioned(
                top: 10,
                left: 10,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.group.name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(widget.group.module.moduleName, style: TextStyle(color: Colors.white)),
                    Text(widget.group.participants.length.toString(), style: TextStyle(color: Colors.white)),
                    Text(widget.group.description, style: TextStyle(color: Colors.white)),
                  ],
                ),
              ), //Group name
              new Positioned(
                  bottom: 5, left: 10, child: getGroupMemAvator()), //Avators

              new Positioned(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.group.status.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      new Text(
                        "start by     : "+widget.group.startTime,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      new Text(
                        "last active : "+widget.group.lastActiveTime,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ]),
                bottom: 10,
                right: 10,
              ) //Group Status
            ])
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }



  Widget getGroupMemAvator() {
    return new Container(
        width: 200,
        height: 40,
        child: ListView.builder(
          itemCount: widget.group.participants.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new CachedNetworkImage(
              imageUrl:widget.group.participants[index].avatar.url,
              imageBuilder: (context, imageProvider) => new Container(
                width: 35,
                height: 35,
                margin: EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget getDetailPage(BuildContext context, StateSetter setState) {
    Widget content = new Container(
      height: 500,
      width: 300,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
              image: new NetworkImage(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588157187534&di=57cc7cfbfc64d5fe7234760784afd00a&imgtype=0&src=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2014%2F1006%2Fe94e4f70870be76a018dff428306c5a3.jpg'),
              fit: BoxFit.cover)
      ),
      child: new Column(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(10),child:new Text("OUllalalla",style: new TextStyle(fontSize: 30),) ,),
          new Text("Start : "+widget.group.startTime.toString(),style: new TextStyle(fontStyle: FontStyle.italic,),),

          new Text("active : "+widget.group.lastActiveTime.toString(),style: new TextStyle(fontStyle: FontStyle.italic,),),
          new Text("Module : "+widget.group.module.moduleName),
          new Text("人数 ： " +widget.group.minSize.toString()+" - "+widget.group.maxSize.toString()),
          new Container(padding: EdgeInsets.all(10),
          child:
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Module Descript "),
              new Container(
                width: 250,
                height: 100,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border:Border.all(style: BorderStyle.solid,color:Colors.white),
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: new Text(widget.group.description,),
              )
            ],),),
          new Container(padding: EdgeInsets.all(10),
            child:
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Notes from KP"),
                new Container(
                  width: 250,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      border:Border.all(style: BorderStyle.solid,color:Colors.white),
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: new Text(widget.group.note),
                )
              ],),),
          new RaisedButton(onPressed: (){setState(() {

          });
          Navigator.of(context).pop();

          },child: Text("Apply"),)
        ],

      ),
    );
    return content;
  }
}
