import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operator_widget.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_bloc.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_event.dart';
import 'package:trpgcocapp/bloc/module_creation/module_creation_repository.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/ui/pages/wenji_pages/map_creation_page.dart';

class moduleCreationPage extends StatefulWidget {
  StoryModCreate _module;
  moduleCreationPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return moduleCreationState();
  }
}

class moduleCreationState extends State<moduleCreationPage> {
  final TextEditingController moduleNameTextController =
      TextEditingController();
  final TextEditingController authorTextController = TextEditingController();
  final TextEditingController introTextController = TextEditingController();
  final TextEditingController gamehoursTextController = TextEditingController();
  final TextEditingController hoursMaxTextController = TextEditingController();
  final TextEditingController hoursMinTextController = TextEditingController();
  final TextEditingController peopleMaxTextController = TextEditingController();
  final TextEditingController peopleMinTextController = TextEditingController();
  List<String> tagItems = [];
  ModuleCreationBloc _moduleCreationBloc;
  TextStyle subTextStyle = TextStyle(color: Colors.black);
  @override
  void initState() {
    _moduleCreationBloc = ModuleCreationBloc();
    _moduleCreationBloc.add(TryInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ModuleCreationBloc, TimecostOperationState>(
        bloc: _moduleCreationBloc,
        builder: (BuildContext context, state) {
          if (state is NotInitialized) {
            return buildPendingPage(context);
          } else {
            return buildBody(context);
          }
        },
      ),
      appBar: AppBar(
        title: Text(
          "Create Module",
          textAlign: TextAlign.center,
        ),
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
    if (widget._module == null) {
      widget._module = ModuleCreationRepository.getInstance();
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildModuleHeader(context),
          Padding(padding: EdgeInsets.all(5)),
          Card(
            child: Column(
              children: [
                buildIntroField(context),
                buildSummaryCard(context),
                buildNPCList(context),
                buildSceneList(context),
              ],
            ),
          ),
          MaterialButton(
              color: Colors.blueAccent,
              onPressed: () {
                OnSubmmitBtnPressed(context);
              },
              child: Text("Submit"))
        ],
      ),
    );
  }

  Widget buildModuleHeader(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Card(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      image: FileImage(widget._module.thumbnailImg.file),
                      fit: BoxFit.fitWidth)),
              child: InkWell(
                onTap: () async {
                  File f = await ModuleCreationHelper.pickImage();
                  if (f != null) {
                    widget._module.thumbnailImg.file = f;
                  }
                  setState(() {});
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: FileImage(widget._module.iconImg.file),
                              fit: BoxFit.fitWidth)),
                      child: InkWell(onTap: () async {
                        File f = await ModuleCreationHelper.pickImage();
                        if (f != null) {
                          widget._module.iconImg.file = f;
                        }

                        setState(() {});
                      }),
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildModuleNameTextField(context),
                            buildAuthorTextField(context),
                            buildTags(context)
                          ]),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget buildModuleNameTextField(context) {
    return Container(
        child: AutoSizeTextField(
            style: TextStyle(color: Colors.black),
            controller: moduleNameTextController,
            textAlign: TextAlign.left,
            maxLength: 50,
            maxLines: 1,
            decoration: InputDecoration(
                hintText: "Module Name",
                hintStyle: TextStyle(color: Colors.black, fontSize: 20))));
  }

  Widget buildAuthorTextField(context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: AutoSizeTextField(
            style: subTextStyle,
            controller: authorTextController,
            textAlign: TextAlign.left,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
            ],
            maxLines: 1,
            decoration:
                InputDecoration(hintText: "author", hintStyle: subTextStyle)));
  }

  void OnSubmmitBtnPressed(BuildContext context) {
    widget._module.moduleName = moduleNameTextController.text;
    widget._module.descript = introTextController.text;
    widget._module.author = authorTextController.text;
    widget._module.hours_min = int.parse(hoursMinTextController.text);
    widget._module.hours_max = int.parse(hoursMaxTextController.text);
    widget._module.people_max = int.parse(peopleMaxTextController.text);
    widget._module.people_min = int.parse(peopleMinTextController.text);
    ModuleCreationRepository.modCreate = widget._module;
    _moduleCreationBloc.add(SubmmitModule());
  }

  Widget buildSceneList(BuildContext context) {
    return Container(
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
                          builder: (context) =>
                              MapCreationPage(widget._module.map),
                        ),
                      );
                    },
                  ),
                );
              },
            ))
      ]),
    );
  }

  Widget buildNPCList(BuildContext context) {
    return Container(
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
    );
  }

  Widget buildSummaryCard(BuildContext context) {
    var _crossAxisSpacing = 5.0;
    var _mainAxisSpacing = 5.0;
    var _drawerWidth =MediaQuery.of(context).size.height * 0.5-2*30;
    var _crossAxisCount = 2;
    var _width = (_drawerWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = MediaQuery.of(context).size.height * 0.05;
    var _aspectRatio = _width / cellHeight;
    return Container(

      padding: EdgeInsets.only(bottom: 20),
      child: Column(children: <Widget>[
        ListTile(
          leading: Icon(Icons.description),
          title: Text("Summary"),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: cellHeight*6,
          color: Colors.black12,
          child:
          Padding(
            padding: EdgeInsets.all(30),
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                childAspectRatio: _aspectRatio,
                crossAxisSpacing: _crossAxisSpacing,
                mainAxisSpacing: _mainAxisSpacing,
              ),
              children: [
                Text("年代 : " + ModEraText[ModEra.PPRESENT]),
                Text("地区 : " + ModRegionText[ModRegion.Europe]),
                Row(
                  children: <Widget>[
                    Text("时长："),
                    Flexible(
                        child: TextField(
                          controller: hoursMinTextController,
                        )),
                    Text("-"),
                    Flexible(
                        child: TextField(
                          controller: hoursMaxTextController,
                        )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("人数："),
                    Flexible(
                        child: TextField(
                          controller: peopleMinTextController,
                        )),
                    Text("-"),
                    Flexible(
                        child: TextField(
                          controller: peopleMaxTextController,
                        )),
                  ],
                ),
                Text("Support Map : "
//                    +
//                    (widget._module.map == null).toString()
                ),
                Text( "NPCS Num: "
//                    + widget._module.npcs.length.toString()
                ),
                Text("Scene Num : "
//                    + ((widget._module.map != null)? widget._module.map.scenes.length.toString():"0")
                ),

              ])
          )
          ,
        ),
      ]),
    );
  }

  Widget buildIntroField(BuildContext context) {
    return Container(
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
        ]));
  }

  buildTags(BuildContext context) {
    return Tags(
      textField: tagItems.length >= 3
          ? null
          : TagsTextField(
              maxLength: 4,
              width: 50,
              textStyle: TextStyle(fontSize: 10, color: Colors.black),
              onSubmitted: (String str) {
                // Add item to the data source.
                setState(() {
                  // required
                  tagItems.add(str);
                });
              },
            ),
      itemCount: tagItems.length, // required
      itemBuilder: (int index) {
        final item = tagItems[index];
        return ItemTags(
          // Each ItemTags must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(index.toString()),
          index: index, // required
          title: item,
          textStyle: TextStyle(fontSize: 10, color: Colors.black),
          icon: ItemTagsIcon(icon: MaterialCommunityIcons.tag_outline),
          combine: ItemTagsCombine.withTextAfter,
          removeButton: ItemTagsRemoveButton(
            onRemoved: () {
              // Remove the item from the data source.
              setState(() {
                // required
                tagItems.removeAt(index);
              });
              //required
              return true;
            },
          ), // OR null,
          onPressed: (item) => print(item),
          onLongPressed: (item) => print(item),
        );
      },
    );
  }
}