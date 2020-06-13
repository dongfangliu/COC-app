import "package:flutter/material.dart";
import 'package:trpgcocapp/data/storyModule/storyModule.dart';
import 'package:trpgcocapp/ui/pages/mapPage.dart';
import 'package:trpgcocapp/ui/pages/sceneCreationPage.dart';

class moduleCreationPage extends StatefulWidget {
  final storyModule _module = new storyModule();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return moduleCreationState();
  }
}

class moduleCreationState extends State<moduleCreationPage> {
  final TextEditingController moduleNameTextController =
      TextEditingController();
  final TextEditingController introTextController = TextEditingController();
  final TextEditingController gamehoursTextController = TextEditingController();
  final TextEditingController plhoursTextController = TextEditingController();
  final TextEditingController kphoursTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      appBar: AppBar(
        title: Text("Create Module"),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildNameCard(context),
          buildIntroField(context),
          buildSummaryCard(context),
          buildNPCList(context),
          buildSceneList(context),
          MaterialButton(
              color: Colors.blueAccent, onPressed: () {}, child: Text("Submit"))
        ],
      ),
//      width: MediaQuery.of(context).size.width,
    );
  }

  Widget buildSceneList(BuildContext context) {
    return Card(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.description),
              title: Text("Map/Scenes"),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (BuildContext ctxt, int index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.black54, width: 2)),
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.add),
                            ],
                          ),
                          onTap: (){
                            if (widget._module.map==null){
                              widget._module.addMap();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => mapPage(widget._module),
                              ),
                            );
                          },
                        ),
                      );
                  },
                ))
          ]),
        ));
  }

  Widget buildNPCList(BuildContext context) {
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
                  itemCount: widget._module.npcs.length + 1,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if (index == widget._module.npcs.length) {
                      return Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: MediaQuery.of(context).size.height * 0.13,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.black54, width: 2)),
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.add),
                            ],
                          ),
                          onTap: () {


                          },
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ))
          ]),
        ));
  }

  Widget buildSummaryCard(BuildContext context) {
    return Card(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.description),
              title: Text("Summary"),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Estimate game hours : "),
                    Flexible(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: gamehoursTextController,
                      ),
                    )
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: <Widget>[
                  Text("level : "),
                  Text("Kp hours >"),
                  Flexible(
                      child: TextField(
                    controller: kphoursTextController,
                  )),
                  Text("PL hours >"),
                  Flexible(
                      child: TextField(
                    controller: plhoursTextController,
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child:
                  Text("NPCS Num: " + widget._module.npcs.length.toString()),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  "Support Map : " + (widget._module.map == null).toString()),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: widget._module.map != null
                  ? Text("Scene Num : " +
                      (widget._module.map.scenes.length.toString()))
                  : Text("Scene Num : 0"),
            )
          ]),
        ));
  }

  Widget buildIntroField(BuildContext context) {
    return Card(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.description),
                  title: Text("Brief Intro"),
                ),
                TextField(
                    controller: introTextController,
                    maxLength: 140,
                    maxLines: 4,
                    decoration:
                        InputDecoration(hintText: "Introduction Text"))
              ])),
        );
  }

  Widget buildNameCard(BuildContext context) {
    return Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                    controller: moduleNameTextController,
                    textAlign: TextAlign.center,
                    maxLength: 20,
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "Module Name")),
                Text("Credit by: "),
                Text("update at :  "),
              ],
            ),
          ),
        );
  }
}
