import "package:flutter/material.dart";
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/ui/pages/module/module_map_create.dart';
class MapCreationPage extends StatefulWidget {
  StoryMap _mapCreate;

  MapCreationPage(this._mapCreate);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MapCreationPageState();
  }
}

class MapCreationPageState extends State<MapCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      appBar: AppBar(
        title: Text("Create Map"),
      ),
    );
  }

  buildBody(BuildContext context) {
    return StoryMapWidget(widget._mapCreate);

  }

}