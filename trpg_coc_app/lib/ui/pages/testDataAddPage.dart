import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/response/bmob_error.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trpgcocapp/data/gameGroup/gameGroup.dart';
import 'package:trpgcocapp/data/gameGroup/gameGroupUserData.dart';
import 'package:trpgcocapp/controller/Bmob/bmob_login.dart';
import '../widgets/dialogs/statefulDialog.dart';

class testDataAddPage extends StatefulWidget {
  File _imageFile;
  File _avatorFile;

  final TextEditingController groupNameController = new TextEditingController();

  final TextEditingController numMinController = new TextEditingController();
  final TextEditingController numMaxController = new TextEditingController();
  final TextEditingController groupDescripController =
      new TextEditingController();
  final TextEditingController kpNoteController = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    BmobLogin bmobLogin = BmobLogin();
    // TODO: implement createState
    return new testDataAddPageState();
  }
}

class testDataAddPageState extends State<testDataAddPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Column(
      children: <Widget>[
        new FlatButton(
          onPressed: () => showStatefulDialog(context, addGroupContent),
          child: new Text("Try ADD Group"),
        ),
        new FlatButton(
          onPressed: () => showStatefulDialog(context, addUserDataContent),
          child: new Text("Try ADD User"),
        )
      ],
    ));
  }

  Widget addGroupContent(BuildContext context, StateSetter setState) {
    Widget groupName = new Container(
        height: MediaQuery.of(context).size.height * 50 / 600,
        width: MediaQuery.of(context).size.width * 120 / 400,
        child: new TextField(
            controller: widget.groupNameController,
            decoration: InputDecoration(
                labelText: "Group Name", border: OutlineInputBorder())));

    Widget minNum = new Container(
        width: MediaQuery.of(context).size.width * 70 / 400,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new TextField(
            controller: widget.numMinController,
            decoration: InputDecoration(
                labelText: "min", border: OutlineInputBorder())));

    Widget maxNum = new Container(
        width: MediaQuery.of(context).size.width * 70 / 400,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new TextField(
            controller: widget.numMaxController,
            decoration: InputDecoration(
                labelText: "max", border: OutlineInputBorder())));
    Widget numLimit = new Container(
      height: MediaQuery.of(context).size.height * 40 / 600,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("人数："), minNum, maxNum],
      ),
    );

    DateTime startTime = new DateTime.now();

    Widget startTimeW = new Container(
        child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Text("Start Time"),
      new FlatButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate:
                  new DateTime.now().subtract(new Duration(days: 30)), // 减 30 天
              lastDate:
                  new DateTime.now().add(new Duration(days: 30)), // 加 30 天
            ).then((DateTime val) {
              if (val != null) {
                startTime = val;
                print(val.toString());
              }
              setState(() {}); // 2018-07-12 00:00:00.000
            }).catchError((err) {
              print(err);
            });
          },
          child: new Text(startTime.toString()))
    ]));

    Widget groupDescrip = new TextField(
        controller: widget.groupDescripController,
        decoration: InputDecoration(
            labelText: "Group Descript", border: OutlineInputBorder()),
        maxLength: 30,
        maxLines: 2,
        maxLengthEnforced: true);

    Widget kpNote = new TextField(
        controller: widget.kpNoteController,
        decoration:
            InputDecoration(labelText: "KpNote", border: OutlineInputBorder()),
        maxLength: 140,
        maxLines: 5,
        maxLengthEnforced: true);

    Widget backGroundBTN = new RaisedButton(
      onPressed: () async {
        try {
          widget._imageFile =
              await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {});
        } catch (e) {
          print(e);
        }
      },
      child: Text("选择背景图"),
    );

    Widget content = new Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
                image: widget._imageFile == null
                    ? NetworkImage(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588157187534&di=57cc7cfbfc64d5fe7234760784afd00a&imgtype=0&src=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2014%2F1006%2Fe94e4f70870be76a018dff428306c5a3.jpg')
                    : new FileImage(widget._imageFile),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            children: <Widget>[
              groupName,
              startTimeW,
              numLimit,
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("group Descript"),
                  new Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.white),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    child: groupDescrip,
                  )
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Notes from KP"),
                  new Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height * 120 / 600,
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.white),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    child: kpNote,
                  )
                ],
              ),
              backGroundBTN,
              new RaisedButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text("Confirm"),
              )
            ],
          ),
        ));
    return content;
  }

  Widget addUserDataContent(BuildContext context, StateSetter setState) {
    Widget content = new Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProfileAvatar(
                    widget._avatorFile == null
                        ? 'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4'
                        : widget._avatorFile
                            .path, //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                    radius: 100, // sets radius, default 50.0
                    backgroundColor: Colors
                        .transparent, // sets background color, default Colors.white
                    borderWidth:
                        10, // sets border, default 0.0  // sets initials text, set your own style, default Text('')
                    borderColor:
                        Colors.brown, // sets border color, default Colors.white
                    elevation:
                        5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                    foregroundColor: Colors.brown.withOpacity(
                        0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                    cacheImage:
                        true, // allow widget to cache image against provided url
                    onTap: () async {
                      try {
                        widget._avatorFile = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {});
                      } catch (e) {
                        print(e);
                      }
                    }, // sets on tap
                    showInitialTextAbovePicture:
                        true, // setting it true will show initials text above profile picture, default false
                  ),
                  new RaisedButton(
                    onPressed: () {
                      gameGroupUserData user = gameGroupUserData();
                      ;
                      user.save().then((BmobSaved bmobSaved) {
                        String message =
                            "创建一条数据成功：${bmobSaved.objectId} - ${bmobSaved.createdAt}";
                        var currentObjectId = bmobSaved.objectId;
                        showSuccess(context, message);
                      }).catchError((e) {
                        showError(context, BmobError.convert(e).error);
                      });
                    },
                    child: Text("push a use data"),
                  ),
                ])));
    return content;
  }
}
