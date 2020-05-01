
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class testDataAddPage extends StatefulWidget{

  File _imageFile ;

  final TextEditingController groupNameController = new TextEditingController();

  final TextEditingController numMinController = new TextEditingController();
  final TextEditingController numMaxController = new TextEditingController();
  final TextEditingController groupDescripController = new TextEditingController();
  final TextEditingController kpNoteController = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new testDataAddPageState();
  }

}
void showStatefulDialog(BuildContext context,Widget childBuildCallback(BuildContext context,StateSetter setState)){
  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: childBuildCallback(context, setState),
            backgroundColor: Colors.transparent,
          );
        });
      });
}
class testDataAddPageState extends State<testDataAddPage>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Center(child:new FlatButton(onPressed: ()=>showStatefulDialog(context,addGroupContent), child: new Text("Try ADD"),))
    );
  }

  Widget addGroupContent(BuildContext context,StateSetter setState){
    Widget groupName = new Container(height:MediaQuery.of(context).size.height*50/600,width:MediaQuery.of(context).size.width*120/400,child:new TextField(controller: widget.groupNameController,decoration: InputDecoration(labelText: "Group Name",border: OutlineInputBorder())));

    Widget minNum = new Container(width:MediaQuery.of(context).size.width*70/400,padding:EdgeInsets.only(left: 5,right: 5),child:new TextField(controller:  widget.numMinController,decoration: InputDecoration(labelText: "min",border: OutlineInputBorder())));

    Widget maxNum = new Container(width:MediaQuery.of(context).size.width*70/400,padding:EdgeInsets.only(left: 5,right: 5),child:new TextField(controller:  widget.numMaxController,decoration: InputDecoration(labelText: "max",border: OutlineInputBorder())));
    Widget numLimit = new Container(
      height: MediaQuery.of(context).size.height*40/600,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text("人数："),minNum,maxNum],),);

    DateTime startTime =  new DateTime.now();

    Widget startTimeW = new Container(
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[new Text("Start Time"), new FlatButton(
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
              startTime = val;
              print(val.toString());
            }
            setState(() {}); // 2018-07-12 00:00:00.000
          }).catchError((err) {
            print(err);
          });
        },
        child: new Text(startTime.toString()))]));

    Widget groupDescrip = new TextField(controller:  widget.groupDescripController,decoration: InputDecoration(labelText: "Group Descript",border: OutlineInputBorder()), maxLength: 30,
        maxLines: 2,
        maxLengthEnforced:true    );

    Widget kpNote = new TextField(
        controller:  widget.kpNoteController,
        decoration: InputDecoration(labelText: "KpNote",border: OutlineInputBorder()),
      maxLength: 140,
      maxLines: 5,
      maxLengthEnforced:true    );

    Widget backGroundBTN = new RaisedButton(onPressed:() async{
      try {
        widget._imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      }catch (e) {
        print(e);
      }
    },child: Text("选择背景图"),);

    Widget content = new Container(
      height: MediaQuery.of(context).size.height*0.85,
      width: MediaQuery.of(context).size.width*0.85,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
              image: widget._imageFile==null?NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588157187534&di=57cc7cfbfc64d5fe7234760784afd00a&imgtype=0&src=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2014%2F1006%2Fe94e4f70870be76a018dff428306c5a3.jpg'):new FileImage(widget._imageFile),
              fit: BoxFit.cover)
      ),
      child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:  new Column(
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
                        border:Border.all(style: BorderStyle.solid,color:Colors.white),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: groupDescrip,
                  )
                ],),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("Notes from KP"),
                  new Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 5),
                    height: MediaQuery.of(context).size.height*120/600,
                    decoration: BoxDecoration(
                        border:Border.all(style: BorderStyle.solid,color:Colors.white),
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child:kpNote,
                  )
                ],),
            backGroundBTN,
            new RaisedButton(onPressed: (){setState(() {

            });
            Navigator.of(context).pop();

            },child: Text("Confirm"),)
          ],

        ),
      ));
    return content;

  }

}
