import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../styles/addGroup_dialog_style.dart';
class addGroupDialog extends StatefulWidget {
  File _imageFile;

  final TextEditingController groupNameController = new TextEditingController();

  final TextEditingController numMinController = new TextEditingController();
  final TextEditingController numMaxController = new TextEditingController();
  final TextEditingController groupDescripController =
      new TextEditingController();
  final TextEditingController kpNoteController = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addGroupDialogState();
  }
}

class addGroupDialogState extends State<addGroupDialog> {
  @override
  Widget build(BuildContext context) {
    Widget groupName = getGroupNameTextField(context);

    Widget numLimit = getNumLimit(context);

    Widget startTimeW = getStartTimeBtn(context);

    Widget groupDescrip = getGroupDescriptTextField();

    Widget kpNote = getKpNoteTextField();

    Widget backGroundBTN = getSelectBgBtn();

    Widget content = new Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            image:
            DecorationImage(
                image: getBgImge(),
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
                  new Text(addGroupDialogStyle.groupDescriptTextHeader),
                  new Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: addGroupDialogStyle.groupDescriptBorderColor),
                        color: addGroupDialogStyle.groupDescriptBgColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: groupDescrip,
                  )
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(addGroupDialogStyle.kpNoteTextHeader),
                  new Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height * 120 / 600,
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid, color: addGroupDialogStyle.kpNoteBorderColor),
                        color: addGroupDialogStyle.kpNoteBgColor,
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
                child: Text(addGroupDialogStyle.confirmBtnText),
              )
            ],
          ),
        ));
    return content;
  }

  Object getBgImge() {
    return widget._imageFile == null
                  ? NetworkImage(
        addGroupDialogStyle.defaultBgImgUrl)
                  : new FileImage(widget._imageFile);
  }

  Widget getGroupNameTextField(BuildContext context) {
    Widget groupName = new Container(
        height: MediaQuery.of(context).size.height * 50 / 600,
//        width: MediaQuery.of(context).size.width * 120 / 400,
        child: new TextField(
            controller: widget.groupNameController,
            maxLines: addGroupDialogStyle.groupNameMaxLine ,
            maxLength: addGroupDialogStyle.groupNameMaxLength,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                labelText: addGroupDialogStyle.groupNameText, border: OutlineInputBorder())));
    return groupName;
  }

  Widget getNumLimit(BuildContext context) {
    Widget minNum = new Container(
        width: MediaQuery.of(context).size.width * 70 / 400,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new TextField(
            controller: widget.numMinController,
            decoration: InputDecoration(
                labelText: addGroupDialogStyle.labelTextMin, border: OutlineInputBorder())));
    Widget maxNum = new Container(
        width: MediaQuery.of(context).size.width * 70 / 400,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: new TextField(
            controller: widget.numMaxController,
            decoration: InputDecoration(
                labelText: addGroupDialogStyle.labelTextMax, border: OutlineInputBorder())));

    Widget numLimit = new Container(
      height: MediaQuery.of(context).size.height * 40 / 600,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(addGroupDialogStyle.NumText), minNum, maxNum],
      ),
    );
    return numLimit;
  }

  Widget getStartTimeBtn(BuildContext context) {
    DateTime startTime = new DateTime.now();

    Widget startTimeW = new Container(
        child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      new Text(addGroupDialogStyle.startTimeText),
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
    return startTimeW;
  }

  Widget getGroupDescriptTextField() {
    Widget groupDescrip = new TextField(
        controller: widget.groupDescripController,
        decoration: InputDecoration(
            labelText: addGroupDialogStyle.groupDescriptText, border: OutlineInputBorder()),
        maxLength: addGroupDialogStyle.groupDescripmaxLength,
        maxLines: addGroupDialogStyle.groupDescriptMaxLines,
        maxLengthEnforced: true);
    return groupDescrip;
  }

  Widget getSelectBgBtn() {
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
      child: Text(addGroupDialogStyle.selectBgText),
    );
    return backGroundBTN;
  }

  Widget getKpNoteTextField() {
    Widget kpNote = new TextField(
        controller: widget.kpNoteController,
        decoration: InputDecoration(
            labelText: addGroupDialogStyle.kpNoteText, border: OutlineInputBorder()),
        maxLength: addGroupDialogStyle.kpNoteLength,
        maxLines: addGroupDialogStyle.kpNoteMaxLines,
        maxLengthEnforced: true);
    return kpNote;
  }
}
