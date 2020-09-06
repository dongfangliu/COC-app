import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trpgcocapp/data/storyModule/storyModCreate.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';
import 'scene_creation_page.dart';



class storyMapCreateWidget extends StatefulWidget {
  StoryMapCreate map;
  @override
  State<StatefulWidget> createState() {
    return storyMapCreateWidgetState();
  }

  storyMapCreateWidget(this.map);
}

class storyMapCreateWidgetState extends State<storyMapCreateWidget> {
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
    // TODO: implement build
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
                    child: new Text('Edit this scene?'),
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
                              builder: (context) => sceneCreationPage(widget.map.scenes[index]),
                            ),
                          );
                        })
                  ],
                );
              });
        },
        onLongPress: () {
          showDialog<Null>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext cxt) {
                return new AlertDialog(
                  title: new Text('Scene ' + widget.map.scenes[index].name),
                  content: new SingleChildScrollView(
                    child: new Text('Delete this scene?'),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Cancel'),
                      onPressed: () {
                        Navigator.of(cxt).pop();
                      },
                    ),
                    new FlatButton(
                        child: new Text('Confirm'),
                        onPressed: () {
                          widget.map.scenes.removeAt(index);
                          setState(() {});
                          Navigator.of(cxt).pop();
                        })
                  ],
                );
              });
        },
      ),
    );
  }

  FloatingActionButton buildAddSceneFAB(BuildContext context) {
    return new FloatingActionButton(
      child: const Icon(Icons.add),
      backgroundColor: Colors.blueAccent,
      onPressed: () {
        showDialog<Null>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext cxt) {
              return new AlertDialog(
                title: new Text('Create new scene?'),
                content: new SingleChildScrollView(
                  child: new TextField(
                    controller: _controller,
                    maxLines: 1,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: "scene name"),
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Confirm'),
                    onPressed: () {
                      widget.map.addScene(
                          new StorySceneCreate( _controller.text, 0,[],0, 0));
                      _controller.clear();
                      setState(() {});
                      Navigator.of(cxt).pop();
                    },
                  ),
                ],
              );
            });
      },
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
              onTapUp: (details) {
                RenderBox box = stackKey.currentContext.findRenderObject();
                Offset offset = box.globalToLocal(details.globalPosition);
                showDialog<Null>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext cxt) {
                      return new AlertDialog(
                        title: new Text('Create new scene?'),
                        content: new SingleChildScrollView(
                          child: new TextField(
                            controller: _controller,
                            maxLines: 1,
                            maxLength: 20,
                            decoration: InputDecoration(hintText: "scene name"),
                          ),
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('Confirm'),
                            onPressed: () {
                              widget.map.addScene(new StorySceneCreate(
                                  _controller.text,0,[], offset.dx, offset.dy));
                              _controller.clear();
                              setState(() {});
                              Navigator.of(cxt).pop();
                            },
                          ),
                        ],
                      );
                    });
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
              child: buildAddSceneFAB(context),
              padding: EdgeInsets.all(5),
            ),
            Padding(
              child: buildSwapViewFAB(),
              padding: EdgeInsets.all(5),
            ),
          ],
        );
  }

  Widget getMapBg(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Image.file(
        widget.map.mapImg.file,
        fit: BoxFit.fitWidth,
      ),
//color: Colors.transparent,
    );
  }

  void buildMapPoints(BuildContext context) {
    movableMapPoints.clear();
    for (StorySceneCreate scene in widget.map.scenes) {
      movableMapPoints.add(storyMapPointWidget(widget.map,scene, this.callback));
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

class storyMapPointWidget extends StatefulWidget {
  StoryMapCreate map;
  StorySceneCreate scene;

  Function setStateParent;
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return storyMapPointWidgetState();
  }

  storyMapPointWidget(this.map,this.scene, this.setStateParent);
}

class storyMapPointWidgetState extends State<storyMapPointWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.scene.yPosition,
      left: widget.scene.xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            widget.scene.xPosition += tapInfo.delta.dx;
            widget.scene.yPosition += tapInfo.delta.dy;
          });
        },
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
                    child: new Text('Edit'),
                    onPressed: () {

                      Navigator.of(cxt).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => sceneCreationPage(widget.scene),
                        ),
                      );
                    },
                  ),
                  new FlatButton(
                      child: new Text('Delete'),
                      onPressed: () {
                        widget.map.scenes.remove(widget.scene);
                        widget.setStateParent(() {});
                        Navigator.of(cxt).pop();
                      })
                ],
              );
            },
          );
        },
        child: Container(
          width: 50,
          height: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
