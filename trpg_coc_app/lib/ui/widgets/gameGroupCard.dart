import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trpgcocapp/data/gameGroup/gameGroup.dart';
import 'dialogs/statefulDialog.dart';
import '../../styles/addGroupDialogStyle.dart';
import '../../styles/gameGroupCardStyle.dart';
class gameGroupCard extends StatefulWidget {
  gameGroup group;
  @override
  createState() => new gameGroupCardState();

  gameGroupCard(this.group) {}
}

class gameGroupCardState extends State<gameGroupCard> {
  @override
  Widget build(BuildContext context) {

    return new InkWell(
      splashColor: gameGroupCardStyle.groupCardSplashColor,
      onTap: () {
        showStatefulDialog(context, getGroupDetailContent);
      },
      child: new CachedNetworkImage(
        // module thumbnail
        imageUrl:
        gameGroupCardStyle.defaultCardImgURL,
        imageBuilder: (context, imageProvider) {
          return new Container(
            height: MediaQuery.of(context).size.height * 0.2,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: gameGroupCardStyle.cardBgColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    color: gameGroupCardStyle.cardShadowColor,
                    offset: Offset(5.0, 5.0),
                    blurRadius: gameGroupCardStyle.cardShadowBlurRadius,
                    spreadRadius: gameGroupCardStyle.cardShadowSpreadRadius)
              ],
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
            child: new Stack(fit: StackFit.expand, children: <Widget>[
              new Positioned(
                top: MediaQuery.of(context).size.height * 0.001,
                left: MediaQuery.of(context).size.width * 0.05,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.group.name,
                      style: TextStyle(color: gameGroupCardStyle.cardTextColor, fontSize: 20),
                    ),
                    Text(
//                        widget.group.module.moduleName,
                        "module name",
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor)),
                    Text(widget.group.participants.length.toString(),
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor)),
                    Text(widget.group.description,
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor)),
                  ],
                ),
              ), //Group name
              new Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.002,
                  left: MediaQuery.of(context).size.width * 0.02,
                  child: getGroupMemAvator()), //Avators

              new Positioned(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.group.status.toString(),
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor, fontSize: 20),
                      ),
                      new Text(
                        addGroupDialogStyle.startTimeText +
                            DateTime.fromMicrosecondsSinceEpoch(
                                widget.group.startTime)
                                .toString(),
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor, fontSize: 10),
                      ),
                      new Text(
                        gameGroupCardStyle.activeTimeText +
                            DateTime.fromMicrosecondsSinceEpoch(
                                widget.group.lastActiveTime)
                                .toString(),
                        style: TextStyle(color: gameGroupCardStyle.cardTextColor, fontSize: 10),
                      ),
                    ]),
                bottom: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.04,
              ) //Group Status
            ]));
        },
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget getGroupMemAvator() {
    return new Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.06,
        child: ListView.builder(
//          itemCount: widget.group.participants.length,
          itemCount: 10,
          itemBuilder: (BuildContext ctxt, int index) {
            var defaultAvatorUrl = 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1713396441,1487163637&fm=26&gp=0.jpg';
            return new CachedNetworkImage(
//              imageUrl:widget.group.participants[index].avatar.url,
              imageUrl:
              defaultAvatorUrl,
              imageBuilder: (context, imageProvider) => new Container(
                width: MediaQuery.of(context).size.height * 0.05,
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                  DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget getGroupDetailContent(BuildContext context, StateSetter setState) {

    Widget content = new Container(
      height: MediaQuery.of(context).size.height * 0.8, //500
      width: MediaQuery.of(context).size.width * 0.8, //300
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: gameGroupCardStyle.groupContentBgColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          image: DecorationImage(
              image: new NetworkImage(
                  gameGroupCardStyle.defaultGroupThumbnailUrl),
              fit: BoxFit.cover)),
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(10),
            child: new Text(
              gameGroupCardStyle.defaultGroupName,
              style: new TextStyle(fontSize: 30),
            ),
          ),
          new Text(
            addGroupDialogStyle.startTimeText +
                DateTime.fromMicrosecondsSinceEpoch(widget.group.startTime)
                    .toString(),
            style: new TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),

          new Text(
            gameGroupCardStyle.activeTimeText +
                DateTime.fromMicrosecondsSinceEpoch(widget.group.lastActiveTime)
                    .toString(),
            style: new TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
//          new Text("Module : "+widget.group.module.moduleName),
          new Text(gameGroupCardStyle.moduleTextStart + "module name"),
          new Text(gameGroupCardStyle.headerTextNum +
              widget.group.minSize.toString() +
              " - " +
              widget.group.maxSize.toString()),
          new Container(
            padding: EdgeInsets.all(10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(addGroupDialogStyle.groupDescriptTextHeader),
                new Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid, color: addGroupDialogStyle.groupDescriptBorderColor),
                      color: addGroupDialogStyle.groupDescriptBgColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: new Text(
                    widget.group.description,
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.all(10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(addGroupDialogStyle.kpNoteTextHeader),
                new Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid, color: addGroupDialogStyle.kpNoteBorderColor),
                      color:addGroupDialogStyle.kpNoteBgColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: new Text(widget.group.note),
                )
              ],
            ),
          ),
          new RaisedButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            child: Text(gameGroupCardStyle.applyBtnText),
          )
        ],
      ),
    );
    return content;
  }
}
