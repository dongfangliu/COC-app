import 'package:flutter/material.dart';
import 'package:trpgcocapp/data/storyModule/storyModule.dart';

class storyMapWidget extends StatefulWidget {
  storyMap map;
  double width;
  double height;
  @override
  State<StatefulWidget> createState() {
    return storyMapWidgetState();
  }

  storyMapWidget(this.map, this.width, this.height);

}

class storyMapWidgetState extends State<storyMapWidget> {
  void callback(VoidCallback _callback){
    setState(_callback);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.map.gridy, //每行三列
              childAspectRatio: 1.0 //显示区域宽高相等
              ),
          itemCount: widget.map.gridy * widget.map.gridx,
          itemBuilder: (context, index) {
            if (widget.map.sceneIdx.contains(index)) {
              return storyMapPointWidget(
                  widget.map,
                  widget.map.scenes[index],
                  widget.width / widget.map.gridx,
                  widget.height / widget.map.gridy,this.callback);
            } else {
              return storyMapPointWidget(
                  widget.map,
                  storyScene("undefined", index),
                  widget.width / widget.map.gridx,
                  widget.height / widget.map.gridy,this.callback);
            }
            ;
          }),
      width: widget.width,
      height: widget.height,
    );
  }
}

class storyMapPointWidget extends StatefulWidget {
  storyMap _map;
  storyScene scene;
  double width;
  double height;
  Function setStateParent;
  final TextEditingController _controller = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return storyMapPointWidgetState();
  }

  storyMapPointWidget(this._map, this.scene, this.width, this.height,this.setStateParent);
}

class storyMapPointWidgetState extends State<storyMapPointWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.scene.name == "undefined"
        ? InkWell(
            child: RawMaterialButton(
                elevation: 0.0,
                child: null,
                constraints: BoxConstraints.tightFor(
                  height: widget.height,
                  width: widget.width,
                ),
                onPressed: () {
                  showDialog<Null>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext cxt) {
                        return new AlertDialog(
                          title: new Text('Create new scene?'),
                          content: new SingleChildScrollView(
                            child: new TextField(
                              controller: widget._controller,
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
                                widget.scene.name = widget._controller.text;
                                widget.setStateParent((){widget._map.addScene(widget.scene);});
                                Navigator.of(cxt).pop();
                              },
                            ),
                          ],
                        );
                      });
                },
                fillColor: Colors.transparent))
        : InkWell(
            child: RawMaterialButton(
            elevation: 0.0,
            child: null,
            onPressed: () {

              showDialog<Null>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext cxt) {
                    return new AlertDialog(
                      title: new Text('Edit scene?'),
                      content: new SingleChildScrollView(
                        child: Text("Scene : "+widget.scene.name),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('Confirm'),
                          onPressed: () {
                            Navigator.of(cxt).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            constraints: BoxConstraints.tightFor(
              height: widget.height,
              width: widget.width,
            ),
            shape:  CircleBorder(),
            fillColor: Colors.white,
          ));
  }
}
