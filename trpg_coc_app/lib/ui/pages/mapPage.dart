import "package:flutter/material.dart";
import 'package:trpgcocapp/data/storyModule/storyModule.dart';
import 'package:trpgcocapp/ui/pages/sceneCreationPage.dart';
import 'package:trpgcocapp/ui/widgets/storyMapWidget.dart';
class mapPage extends StatefulWidget {
  storyModule module;

  mapPage(this.module);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mapPageState();
  }
}

class mapPageState extends State<mapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      appBar: AppBar(
        title: Text("Create Module"),
      ),
    );
  }

  buildBody(BuildContext context) {
    return storyMapWidget(widget.module.map);

  }

}