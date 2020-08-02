import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator_widget.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_bloc.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_event.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_repository.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';
import 'package:trpgcocapp/ui/pages/map_creation_page.dart';

class moduleCreationPage extends StatefulWidget {
  StoryModCreate _module;
  moduleCreationPage();


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return moduleCreationState();
  }

  Future<void> setupModule() async {
    this._module = await StoryModCreate.getInstance();
  }
}

class moduleCreationState extends State<moduleCreationPage> {
  final TextEditingController moduleNameTextController =
      TextEditingController();
  final TextEditingController introTextController = TextEditingController();
  final TextEditingController gamehoursTextController = TextEditingController();
  final TextEditingController plhoursTextController = TextEditingController();
  final TextEditingController kphoursTextController = TextEditingController();
  ModuleCreationBloc _moduleCreationBloc;
  @override
  void initState() {
    super.initState();
    widget.setupModule().then((v){setState(() {
    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ModuleCreationBloc>(
        create: (context){_moduleCreationBloc = ModuleCreationBloc();return _moduleCreationBloc;},
        child: TimecostOpListenerWidget<ModuleCreationBloc>(
            child: widget._module==null?buildPendingPage(context):buildBody(context)
        )
      ),
      appBar: AppBar(
        title: Text("Create Module"),
      ),
    );
  }

  Widget buildPendingPage(BuildContext context) {
    return Center(
        child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            )));
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
              color: Colors.blueAccent,
              onPressed: () {
                OnSubmmitBtnPressed(context);
              },
              child: Text("Submit"))
        ],
      ),
//      width: MediaQuery.of(context).size.width,
    );
  }

  void OnSubmmitBtnPressed(BuildContext context) {
    widget._module.moduleName = moduleNameTextController.text;
    widget._module.descript = introTextController.text;
    widget._module.plHourMin = int.parse(plhoursTextController.text);
    widget._module.kpHourMin = int.parse(kphoursTextController.text);
    widget._module.estimate_hours = int.parse(gamehoursTextController.text);
    ModuleCreationRepository.modCreate = widget._module;
    _moduleCreationBloc.add(SubmmitModule());
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
                      border: Border.all(color: Colors.black54, width: 2)),
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.add),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapCreationPage(widget._module.map),
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
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black54, width: 2)),
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.add),
                        ],
                      ),
                      onTap: () {},
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
          child: Text("NPCS Num: " + widget._module.npcs.length.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child:
              Text("Support Map : " + (widget._module.map == null).toString()),
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
                decoration: InputDecoration(hintText: "Introduction Text"))
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