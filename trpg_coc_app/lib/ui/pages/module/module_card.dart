import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:data_plugin/bmob/response/bmob_updated.dart';
import 'package:flutter/material.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/styles/module_card_style.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ModuleCard extends StatefulWidget {
  StoryMod _modUsing;
  @override
  createState() => new ModuleCardState();

  ModuleCard(this._modUsing) {}
}

class ModuleCardState extends State<ModuleCard> {
  TextStyle subTextStyle = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: moduleCardStyle.groupCardSplashColor,
      onTap: () {
        //Go to module demo page
        // a dialog is better, then details go to demo page
      },
      child: new CachedNetworkImage(
        imageUrl: widget._modUsing.thumbnailImg.url,
        imageBuilder: (context, imageProvider) {
          return new Container(
              height: MediaQuery.of(context).size.height * 0.2,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: moduleCardStyle.cardBgColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      color: moduleCardStyle.cardShadowColor,
                      offset: Offset(4.0, 5.0),
                      blurRadius: moduleCardStyle.cardShadowBlurRadius,
                      spreadRadius: moduleCardStyle.cardShadowSpreadRadius)
                ],
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: new Stack(fit: StackFit.expand, children: <Widget>[
                new Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[buildModuleName(),Text(widget._modUsing.author,style: subTextStyle,)]
                  )
              ),

                new Positioned(
                  child: buildTags(context),
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.04,
                ) ,
                new Positioned(
                  child: buildLikeButton(),
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.04,
                ) ,
                new Positioned(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children:[ Text("时代：",style: subTextStyle), Text(ModEraText[widget._modUsing.era],style: subTextStyle)]),
                      SizedBox(height: 1,),
                      Row(children:[ Text("地区：",style: subTextStyle),  Text(ModRegionText[widget._modUsing.region],style: subTextStyle)]),
                      SizedBox(height: 2,),
                      Row(children:[ Icon(SimpleLineIcons.people,size: 16,), SizedBox(width: 10,),Text(widget._modUsing.getPeopleRangeText(),style: subTextStyle)]),
                      SizedBox(height: 5,),
                      Row(children:[ Icon(MaterialCommunityIcons.timer_sand_full,size: 16,), SizedBox(width: 10,), Text(widget._modUsing.getHourRangeText(),style: subTextStyle)]),
                    ],
                  ),
                  bottom: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.04,
                ) ,
              ]));
        },
        placeholder: (context, url) => Container(child: Center(child:CircularProgressIndicator(),),),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  Widget buildTags(BuildContext context){
    return Tags(
      key:_tagStateKey,
      textField: null,
      itemCount: widget._modUsing.tags.length, // required
      itemBuilder: (int index){
        final item = widget._modUsing.tags[index];
        return ItemTags(
          // Each ItemTags must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(index.toString()),
          icon: ItemTagsIcon(icon: MaterialCommunityIcons.tag_outline),
          pressEnabled: false,
          index: index, // required
          title: item,
          textStyle: TextStyle( fontSize:10, ),
          combine: ItemTagsCombine.withTextAfter,
        );

      },
    );
  }
  Text buildModuleName() {
    return Text(widget._modUsing.moduleName,
        style: TextStyle(color: moduleCardStyle.cardTextColor, fontSize: 20),
        maxLines: 1);
  }

  LikeButton buildLikeButton() {
    return LikeButton(
//      onTap: onLikeButtonTapped,
      likeCount: widget._modUsing.likes,
      countBuilder: (int count, bool isLiked, String text) {
        final ColorSwatch<int> color =
        isLiked ? Colors.pinkAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            'love',
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            count >= 1000
                ? (count / 1000.0).toStringAsFixed(1) + 'k'
                : text,
            style: TextStyle(color: color),
          );
        return result;
      },
    );
  }


  Future<bool> onLikeButtonTapped(bool isLiked) async {
    try {
      if (isLiked) {
        widget._modUsing.likes -= 1;
      } else {
        widget._modUsing.likes += 1;
      }
      BmobUpdated saved = await widget._modUsing.update();
      return !isLiked;
    } catch (e) {
      return isLiked;
    }
  }
}
