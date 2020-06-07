import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:trpgcocapp/data/storyModule/storyModule.dart';
import 'package:vector_math/vector_math_64.dart' as v;

class storyMapWidget extends StatefulWidget {
  storyMap map;
  @override
  State<StatefulWidget> createState() {
    return storyMapWidgetState();
  }

  storyMapWidget(this.map);
}

class storyMapWidgetState extends State<storyMapWidget> {
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
    return useListView?buildListViewPage(context):buildTransformableMap(context);
  }

  Widget buildListViewPage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        ListView.builder(
          itemCount: widget.map.scenes.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return buildListViewCard(index, context);
          },
        ),
        Positioned(
            bottom: 10.0,
            child: Row(
              children: <Widget>[
                Padding(
                  child: 
                  buildAddSceneFAB(context),
                  padding: EdgeInsets.only(right: 5),
                ),
                Padding(
                  child: buildSwapViewFAB(),
                  padding: EdgeInsets.only(left: 5),
                ),
              ],
            )),
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
                        title: new Text(
                            'Scene ' + widget.map.scenes[index].name),
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
//                                setState(() {});
                                Navigator.of(cxt).pop();
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
                        title: new Text(
                            'Scene ' + widget.map.scenes[index].name),
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
                                decoration:
                                    InputDecoration(hintText: "scene name"),
                              ),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text('Confirm'),
                                onPressed: () {
                                  widget.map.addScene(new storyScene(
                                      widget.map, _controller.text, 0, 0));
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
    return

      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
Flexible(
  child:MatrixGestureDetector(
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
                    widget.map.addScene(new storyScene(
                        widget.map, _controller.text, offset.dx, offset.dy));
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
      child:
      Stack(
        key: stackKey,
        fit: StackFit.expand,
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: composeWidgets(context),
      ),
    )
    ,
  ),
),

            buildSwapViewFAB()
          ]
    );
  }

  Widget getMapBg(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: CachedNetworkImage(
        imageUrl:
            "https://www.filledstacks.com/assets/static/043.07cc2b7.6f4ea837fbd6bd8a22f973da839908d8.jpg",
        fit: BoxFit.fitWidth,
      ),
//color: Colors.transparent,
    );
  }

  void buildMapPoints(BuildContext context) {
    movableMapPoints.clear();
    for (storyScene scene in widget.map.scenes) {
      movableMapPoints.add(storyMapPointWidget(scene, this.callback));
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
  storyScene scene;

  Function setStateParent;
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return storyMapPointWidgetState();
  }

  storyMapPointWidget(this.scene, this.setStateParent);
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
                    },
                  ),
                  new FlatButton(
                      child: new Text('Delete'),
                      onPressed: () {
                        widget.scene.map.scenes.remove(widget.scene);
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
