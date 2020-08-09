import 'dart:math';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:trpgcocapp/data/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:trpgcocapp/ui/widgets/module_card.dart';

class ModuleSearchPage extends StatefulWidget {
  @override
  _ModuleSearchPageState createState() => _ModuleSearchPageState();
}

class _ModuleSearchPageState extends State<ModuleSearchPage> {
  final SearchBarController<StoryModUsing> _searchBarController =
      SearchBarController();

  Future<List<StoryModUsing>> _getTestModules(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<StoryModUsing> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      StoryModUsing mod = new StoryModUsing([], "Name", 0, 0, 0,0,0);
      mod.author="author";
      mod.likes = i;
      mod.thumbnailImg = COCBmobServerFile();
      mod.thumbnailImg.serverfile = BmobFile();
      mod.thumbnailImg.serverfile.url =
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1381105898,90479310&fm=26&gp=0.jpg";
      mod.descript = "This is a good module";
      mod.tags = ["OULALA", "LALALA"];
      posts.add(mod);
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<StoryModUsing>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getTestModules,
          searchBarController: _searchBarController,
          placeHolder: buildPlaceHolder(),
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          header: buildSearchHeader(context),
          onCancelled: () {
            OnSearchCanceled();
          },
          mainAxisSpacing: 10,
          onItemFound: (StoryModUsing modUsing, int index) {
            return buildItemWidget(modUsing, context);
          },
        ),
      ),
      endDrawer: buildFilterDrawer(context),
    );
  }

  Widget buildFilterDrawer(BuildContext context) {
    var _crossAxisSpacing = 5.0;
    var _mainAxisSpacing = 5.0;
    var _drawerWidth = MediaQuery.of(context).size.width * 0.5;
    var _crossAxisCount = 2;
    var _width = (_drawerWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 50;
    var _aspectRatio = _width / cellHeight;
    return SizedBox(
      width: _drawerWidth,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("版本"),
                subtitle: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio,
                    crossAxisSpacing: _crossAxisSpacing,
                    mainAxisSpacing: _mainAxisSpacing,
                  ),
                  children: <Widget>[
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("COC 7th",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("COC 6th",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                  ],
                ),
                dense: true,
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text("年代"),
                subtitle: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio,
                    crossAxisSpacing: _crossAxisSpacing,
                    mainAxisSpacing: _mainAxisSpacing,
                  ),
                  children: <Widget>[
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("1920s",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("现代",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("当代",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("其他",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                  ],
                ),
                dense: true,
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text("地区"),
                subtitle: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio,
                    crossAxisSpacing: _crossAxisSpacing,
                    mainAxisSpacing: _mainAxisSpacing,
                  ),
                  children: <Widget>[
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("欧洲",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("美洲",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("中国",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("日本",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {},
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: false,
                      child: Text("其他",textAlign: TextAlign.center,),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                  ],
                ),
                dense: true,
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text("人数"),
                subtitle: SizedBox(
                  width: _drawerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Flexible(
                          child: new TextField(
                        decoration: InputDecoration(hintText: "Min"),
                        textAlign: TextAlign.center,
                      )),
                      Container(
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                        width: _drawerWidth * 0.1,
                      ),
                      new Flexible(
                          child: new TextField(
                        decoration: InputDecoration(hintText: "Max"),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
                dense: true,
              ),
              Divider(
                height: 10,
              ),
              ListTile(
                title: Text("时长"),
                subtitle: SizedBox(
                  width: _drawerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Flexible(
                          child: new TextField(
                            decoration: InputDecoration(hintText: "Min"),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                        width: _drawerWidth * 0.1,
                      ),
                      new Flexible(
                          child: new TextField(
                            decoration: InputDecoration(hintText: "Max"),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                dense: true,
              ),
              Divider(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[RaisedButton(child: Text("Reset",textAlign: TextAlign.center,),onPressed: (){},),RaisedButton(child: Text("确定",textAlign: TextAlign.center,),onPressed: (){},)],)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemWidget(StoryModUsing post, BuildContext context) {
    return ModuleCard(post);
  }

  void OnSearchCanceled() {
    //Should load last search result
    print("Cancelled triggered");
  }

  Row buildSearchHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        RaisedButton(
          child: Text("Reset all"),
          onPressed: () {
            _searchBarController.removeSort();
          },
        ),
        buildSortBtn(),
      ],
    );
  }

  Widget buildSortBtn() {
    final String _value = "Most Likes";
    final List<String> items = ['Most Likes', 'Least Likes', 'New', 'Old'];
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          underline: SizedBox(),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(value, textAlign: TextAlign.center)),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Align(
                  alignment: Alignment.center,
                  child: Text("Sort", textAlign: TextAlign.center));
            }).toList();
          },
          hint: Align(
              alignment: Alignment.center,
              child: Text("Sort", textAlign: TextAlign.center)),
          onChanged: (value) {
            setState(() {
//    _searchBarController.sortList((Post a, Post b) {
//    return a.body.compareTo(b.body);
//    });
//    },
            });
          },
        ));
  }

  Text buildPlaceHolder() => Text("placeholder");
}
