import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photofilters/photofilters.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as imageLib;

class SceneDemoPage extends StatefulWidget {
  StoryScene _scene;
  StorySubScene _curScene;
  String _curTime = "noon";
  Map<String,String> timeofDay = {
    "Early morning":"AddictiveBlue",
    "morning":"Lo-Fi",
    "noon":"Hudson",
    "afternoon":"Helena",
    "dusk":"Kelvin",
    "evening":"Moon",
    "late night":"Willow"
  };
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    SceneDemoPageState state = SceneDemoPageState();
    state.setImage(_curScene.bgImg);
    return state;
  }
  SceneDemoPage(this._scene){
    _curScene = _scene.subScenes[0];
  }
}

class SceneDemoPageState extends State<SceneDemoPage> {
  imageLib.Image _image=null;
  String _imagefileName;

  var filters_map = Map.fromIterable(presetFiltersList, key: (e) => e.name, value: (e) => e);
  Future<void> setImage(COC_File image) async {
    File f;
    f = await FileGenerator.fromURL(image.url, _imagefileName);
    var img = imageLib.decodeImage(f.readAsBytesSync());
    _imagefileName = f.path;
    img = imageLib.copyResize(img, width:600);
    _image  = img;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._scene.name),
      ),
      body: buildBody(context),
    );

  }

  Stack buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        buildReplaceableBG(context),
        Positioned(
          child: buildSceneSelectionDropDown(context),
          top: 10,
        ),
        Positioned(
          child: buildTimeDropDown(context),
          left: 20,
          top: 10,
        ),
        Positioned(
          child: buildNPCList(context),
          right: 10,
          top: 10,
        ),
      ],
    );
  }

  Widget buildSceneSelectionDropDown(BuildContext context) {
    return DropdownButton<StorySubScene>(
      value: widget._scene.subScenes.length == 0?null: (widget._curScene==null?widget._scene.subScenes[0]:widget._curScene),
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (StorySubScene value) {
        setState(() {
          widget._curScene = value;
        });
      },
      items: widget._scene.subScenes.length == 0
          ? [
              DropdownMenuItem<StorySubScene>(
                value: null,
                child:SizedBox(
                  width: MediaQuery.of(context).size.width/5, // for example
                  child: Text("undefined", textAlign: TextAlign.center),
                ),
              )
            ]
          : widget._scene.subScenes
              .map<DropdownMenuItem<StorySubScene>>(
              (StorySubScene value) {
              return DropdownMenuItem<StorySubScene>(
                value: value,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/5, // for example
                  child: Text(value.name, textAlign: TextAlign.center),
                ),
              );
            }).toList(),
    );
  }

  Widget buildTimeDropDown(BuildContext context) {
    return DropdownButton<String>(
      value: widget._curTime,
      icon: Icon(Icons.access_time),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String value) {
        setState(() {
          widget._curTime = value;
        });
      },
      items: widget.timeofDay.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
            width: MediaQuery.of(context).size.width/5, // for example
            child: Text(value, textAlign: TextAlign.center),
          ),
        );
      }).toList(),
    );
  }

  Widget buildReplaceableBG(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black54, width: 2)),
      child: InkWell(
        child:buildSceneImg(context)
      ),
    );
  }

  String getTimeFilterName() => widget.timeofDay[widget._curTime];
Widget buildSceneImg(BuildContext context){
  if(_image==null){
    return Center(child: CircularProgressIndicator(),);
  }else{
    return PhotoFilter(image: _image, filename: _imagefileName, filter: filters_map[getTimeFilterName()],fit: BoxFit.fill,);
  }
}
  Widget buildNPCList(BuildContext context) {
    return Container(
        width: 120,
        child: ExpandableNotifier(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(children: <Widget>[ExpandablePanel(
                          header: Text("NPCs",textAlign: TextAlign.center,),
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                          expanded: buildNpcColumn(context),
                        ),

                    ])))));
  }

  Widget buildNpcColumn(BuildContext context) {
    return
      SizedBox(
        height: MediaQuery.of(context).size.height*0.5,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return SelectableContainer(
              child: Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.height * 0.08,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Image(
                        image: AssetImage("assets/images/add.png"),
                        fit: BoxFit.fill,
                      )),
//                            Text(widget.getModule().npcs[index].name)
                  Text("aaa")
                ],
              ),
              selected: widget._scene.npcsId.contains(index),
              onPressed: () {
                setState(() {
                  if (widget._scene.npcsId.contains(index)) {
                    widget._scene.npcsId.remove(index);
                  } else {
                    widget._scene.npcsId.add(index);
                  }
                  ;
                });
              },
            );
          },
        ),
      )
      ;
  }

 
}
