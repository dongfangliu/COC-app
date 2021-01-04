import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_event.dart';
import 'package:trpgcocapp/bloc/common/timecost_op/timecost_operation_state.dart';
import 'package:trpgcocapp/bloc/module_demostration/module_demo_bloc.dart';
import 'package:trpgcocapp/data/char_sheet/char_data.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/ui/pages/module/scene_demo_page.dart';

class moduleDemoPage extends StatefulWidget {
  moduleDemoPage();

  @override
  State<StatefulWidget> createState() {
    return moduleDemoPageState();
  }
}

class moduleDemoPageState extends State<moduleDemoPage> {
  ModuleDemoBloc _moduleDemoBloc;
  TextStyle subTextStyle = TextStyle(color: Colors.black);
  @override
  void initState() {
    _moduleDemoBloc = ModuleDemoBloc();
    _moduleDemoBloc.add(TryInitialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ModuleDemoBloc, TimecostOperationState>(
        bloc: _moduleDemoBloc,
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
                      image: buildCOCFileImg(_moduleDemoBloc.mod.thumbnailImg),
                      fit: BoxFit.fitWidth)),
              child: InkWell(
                onTap: () async {
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
                              image: buildCOCFileImg(_moduleDemoBloc.mod.iconImg),
                              fit: BoxFit.fitWidth)),
                      child: InkWell(onTap: () {
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
        child: AutoSizeText(_moduleDemoBloc.mod.moduleName,maxLines: 1,)

    )
    ;
  }

  Widget buildAuthorTextField(context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: 
        AutoSizeText(_moduleDemoBloc.mod.author,style:subTextStyle,maxLines: 1));
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
              itemCount: _moduleDemoBloc.mod.map.scenes.length ,
              itemBuilder: (BuildContext ctxt, int index) {
                  StoryScene scene = _moduleDemoBloc.mod.map.scenes[index];
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
//                        border: Border.all(color: Colors.black54, width: 2)
                    ),
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: CachedNetworkImageProvider(scene.subScenes[scene.mainSceneIdx].bgImg.url),
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.height * 0.3,
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Expanded(
                            child: AutoSizeText(scene.name),
                          )

                        ],
                      ),
                      onTap: () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SceneDemoPage(scene),
                          ),
                        ).then((value) =>
                            setState(() {

                            }));

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
              itemCount: _moduleDemoBloc.mod.npcs.length + 1,
              itemBuilder: (BuildContext ctxt, int index) {
                  CharData npc =
                  _moduleDemoBloc.mod.npcs[index];
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
//                        border: Border.all(color: Colors.black54, width: 2)
                    ),
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image(
                            image: CachedNetworkImageProvider(npc.avatar.url),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.height * 0.13,
                            height: MediaQuery.of(context).size.height * 0.13,
                          ),

                          Expanded(
                              child:
                              AutoSizeText(npc.infoData.name)
                          )
                        ],
                      ),
                      onTap: () async{},
                    ),
                  );
                },
            ))
      ]),
    );
  }

  Widget buildSummaryCard(BuildContext context) {
    var _crossAxisSpacing = 5.0;
    var _mainAxisSpacing = 5.0;
    var _drawerWidth = MediaQuery.of(context).size.height * 0.5 - 2 * 30;
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
          height: cellHeight * 6,
          color: Colors.black12,
          child: Padding(
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
                            child:
                            AutoSizeText(_moduleDemoBloc.mod.hours_min.toString())),
                        Text("-"),
                        Flexible(
                            child:
                            AutoSizeText(_moduleDemoBloc.mod.hours_max.toString())),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("人数："),
                        Flexible(
                            child:
                            AutoSizeText(_moduleDemoBloc.mod.people_min.toString())
                        ),
                        Text("-"),
                        Flexible(
                            child:
                            AutoSizeText(_moduleDemoBloc.mod.people_max.toString())
                        ),
                      ],
                    ),
                    Text("Support Map : "+(_moduleDemoBloc.mod.map == null).toString()
                    ),
                    Text("NPCS Num: "                    + _moduleDemoBloc.mod.npcs.length.toString()
                    ),
                    Text("Scene Num : "+ ((_moduleDemoBloc.mod.map != null)? _moduleDemoBloc.mod.map.scenes.length.toString():"0")
                    ),
                  ])),
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
          AutoSizeText(_moduleDemoBloc.mod.descript,maxLines: 4),
        ]));
  }

  buildTags(BuildContext context) {
    return Tags(
      textField: null,
      itemCount: _moduleDemoBloc.mod.tags.length, // required
      itemBuilder: (int index) {
        final item = _moduleDemoBloc.mod.tags[index];
        return ItemTags(
          // Each ItemTags must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(index.toString()),
          index: index, // required
          title: item,
          textStyle: TextStyle(fontSize: 10, color: Colors.black),
          icon: ItemTagsIcon(icon: MaterialCommunityIcons.tag_outline),
          combine: ItemTagsCombine.withTextAfter,
          removeButton: null, // OR null,
          onPressed: (item) => print(item),
          onLongPressed: (item) => print(item),
        );
      },
    );
  }
}
