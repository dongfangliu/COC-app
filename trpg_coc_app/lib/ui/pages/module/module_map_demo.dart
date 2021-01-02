import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/ui/pages/module/scene_demo_page.dart';


class StoryMapDemoWidget extends StatefulWidget {
  StoryMap map;
  @override
  State<StatefulWidget> createState() {
    return StoryMapDemoWidgetState();
  }

  StoryMapDemoWidget(this.map);
}

class StoryMapDemoWidgetState extends State<StoryMapDemoWidget> {
  List<Widget> movableMapPoints = [];
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  bool useListView = true;
  void callback(VoidCallback _callback) {
    setState(_callback);
  }

  final TextEditingController _controller = new TextEditingController();
  GlobalKey stackKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return useListView
        ? buildListViewPage(context)
        : buildTransformableMap(context);
  }

  Widget buildListViewPage(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child:
            ListView.builder(
              itemCount: widget.map.scenes.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return buildListViewCard(index, context);
              },
            ),

        ),
        buildFABRow(context),
      ],
    );
  }

  Card buildListViewCard(int index, BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: Icon(Icons.assignment_turned_in),
        title: Text(widget.map.scenes[index].name),
        onTap: () {
          showDialog<Null>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext cxt) {
                return new AlertDialog(
                  title: new Text('Scene ' + widget.map.scenes[index].name),
                  content: new SingleChildScrollView(
                    child: new Text('Enter this scene?'),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('No'),
                      onPressed: () {
                        Navigator.of(cxt).pop();
                      },
                    ),
                    new FlatButton(
                        child: new Text('Yes'),
                        onPressed: () {
                          Navigator.of(cxt).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SceneDemoPage(widget.map.scenes[index]),
                            ),
                          );
                        })
                  ],
                );
              });
        },
      ),
    );
  }

  FloatingActionButton buildSwapViewFAB() {
    return new FloatingActionButton(
        heroTag: "change Scene",
        child: const Icon(Icons.cached),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          setState(() {
            useListView = !useListView;
          });
        });
  }

  Widget buildTransformableMap(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: MatrixGestureDetector(
              onMatrixUpdate: (m, tm, sm, rm) {
                setState(() {});
                notifier.value = m;
              },
              child: Transform(
                transform: notifier.value,
                child: Stack(
                  key: stackKey,
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: composeWidgets(context),
                ),
              ),
            ),
          ),
          buildFABRow(context)
        ]);
  }

  Row buildFABRow(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: buildSwapViewFAB(),
              padding: EdgeInsets.all(5),
            ),
          ],
        );
  }

  Widget getMapBg(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: CachedNetworkImage( imageUrl:widget.map.mapImg.url,
        fit: BoxFit.fitWidth,
      ),
//color: Colors.transparent,
    );
  }

  void buildMapPoints(BuildContext context) {
    movableMapPoints.clear();
    for (StoryScene scene in widget.map.scenes) {
      movableMapPoints.add(storyMapPointDemoWidget(widget.map,scene, this.callback));
    }
  }

  List<Widget> composeWidgets(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(getMapBg(context));
    buildMapPoints(context);
    widgets.addAll(movableMapPoints);
    return widgets;
  }
}

class storyMapPointDemoWidget extends StatefulWidget {
  StoryMap map;
  StoryScene scene;

  Function setStateParent;
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return storyMapPointDemoWidgetState();
  }

  storyMapPointDemoWidget(this.map,this.scene, this.setStateParent);
}

class storyMapPointDemoWidgetState extends State<storyMapPointDemoWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.scene.yPosition,
      left: widget.scene.xPosition,
      child: GestureDetector(
        onTap: () {
          //show dialog  enter/delete
          showDialog<Null>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext cxt) {
              return new AlertDialog(
                title: new Text('Scene'),
                content: new SingleChildScrollView(
                  child: new Text(
                    'Scene Name: ' + widget.scene.name,
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Enter'),
                    onPressed: () {

                      Navigator.of(cxt).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SceneDemoPage(widget.scene),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.transparent,
          child: Icon(Icons.location_on,color:Colors.white),
        ),
      ),
    );
  }
}
