
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:trpgcocapp/data/storyModule/storyModule.dart';
import 'package:image_picker/image_picker.dart';

class createScenePage extends StatefulWidget {
  storyModule _module;
  storyMap _map;
  storyScene _scene;
  storySubScene _curScene=null;
  String _curTime  = "noon";
  List<String> timeofDay=["Early morning", "morning", "noon", "afternoon", "dusk", "evening", "late night"];
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return createScenPageState();
  }

  createScenePage(this._module, this._map, this._scene);
}
class createScenPageState extends State<createScenePage>{
  File _bgImg;final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(child: buildReplaceableBG(context),left: 0,top: 0,),
        Positioned(child: buildSceneSelectionDropDown(context),left: MediaQuery.of(context).size.width/2,top: 0,),
        Positioned(child: buildTimeDropDown(context),left: 0,top: 0,),
        Positioned(child: buildAddSceneBtn(context),right: MediaQuery.of(context).size.width/10,bottom: MediaQuery.of(context).size.width/10,),
        Positioned(child: buildNPCList(context),left: MediaQuery.of(context).size.width/10,bottom: MediaQuery.of(context).size.width/10,),
      ],

    );
  }
  Widget buildSceneSelectionDropDown(BuildContext context){

    return DropdownButton<storySubScene>(
      value: widget._curScene,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (storySubScene value) {
        setState(() {
          widget._curScene = value;
        });
      },
      items: widget._scene.subScenes
          .map<DropdownMenuItem<storySubScene>>((storySubScene value) {
        return DropdownMenuItem<storySubScene>(
          value: value,
          child: Text(value==null?"undefined":value.name),
        );
      }).toList(),
    );
  }
  Widget buildTimeDropDown(BuildContext context){

    return DropdownButton<String>(
      value: widget._curTime,
      icon: Icon(Icons.access_time),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
          color: Colors.deepPurple
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        setState(() {
          widget._curTime = value;
        });
      },
      items: widget.timeofDay
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Widget buildReplaceableBG(BuildContext context){
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:
          Border.all(color: Colors.black54, width: 2)),
      child: InkWell(
        child: 
        _bgImg==null?
        Image.asset("assets/images/add/png",fit: BoxFit.fill,):
        Image.file(_bgImg,fit: BoxFit.fill,),
        onTap: () async {
          final pickedFile =await ImagePicker.pickImage(source: ImageSource.gallery);
          _bgImg =File(pickedFile.path);

        },
      ),
    );
  }
  Widget buildNPCList(BuildContext context){
    return Card(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.description),
              title: Text("NPCs"),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget._module.npcs.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                      return SelectableContainer(
                        child: Column(
                          children: <Widget>[
                            Container(

                              child: Image(image: AssetImage("assets/images/add.png"),fit: BoxFit.fill,)
                            ),
                            Text(widget._module.npcs[index].name)
                          ],
                        ),
                        selected: widget._scene.npcsId.contains(index),
                        onPressed: (){
                          setState(() {
                            if(widget._scene.npcsId.contains(index)){
                              widget._scene.npcsId.remove(index);
                            }else{widget._scene.npcsId.add(index);};
                          });
                        },padding: 8.0,
                      );
                  },
                ))
          ]),
        )
    );
  }
  Widget buildAddSceneBtn(BuildContext context){
    return FloatingActionButton(child: Icon(Icons.add,color: Colors.white,),tooltip: "Add SubScene",
    onPressed: (){
      showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext cxt) {
            return new AlertDialog(
              title: new Text('Add new subscene ?'),
              content: new SingleChildScrollView(
                child: new TextField(
                  controller: widget._controller,
                  maxLines: 1,
                  maxLength: 20,
                  decoration:
                  InputDecoration(hintText: "name"),
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Confirm'),
                  onPressed: () {
                    setState(() {
                      widget._scene.subScenes.add(new storySubScene( widget._controller.text));
                    });
                    Navigator.of(cxt).pop();
                  },
                ),
              ],
            );
          });
    },
    );
  }

}
