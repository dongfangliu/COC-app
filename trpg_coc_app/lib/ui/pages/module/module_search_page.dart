import 'dart:math';

import 'package:data_plugin/bmob/type/bmob_file.dart';
import 'package:faker/faker.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:trpgcocapp/bloc/module_search/module_search_repo.dart';
import 'package:trpgcocapp/data/file/coc_file.dart';
import 'package:trpgcocapp/data/storyModule/storyMod.dart';
import 'package:trpgcocapp/data/storyModule/storyModOnUse.dart';
import 'file:///E:/Mycodes/Android/Projects/COC-app/COC-app/trpg_coc_app/lib/ui/pages/module/module_card.dart';

class ModuleSearchPage extends StatefulWidget {
  ModuleSearchRepository _searchRepository = new ModuleSearchRepository();
  @override
  _ModuleSearchPageState createState() => _ModuleSearchPageState();
}

class _ModuleSearchPageState extends State<ModuleSearchPage> {
  final SearchBarController<StoryModUsing> _searchBarController =
      SearchBarController();

  final TextEditingController _hoursMin = new TextEditingController(text: "0");
  final TextEditingController _hoursMax =
      new TextEditingController(text: "999");

  final TextEditingController _peopleMin = new TextEditingController(text: "0");
  final TextEditingController _peopleMax =
      new TextEditingController(text: "999");

  Future<List<StoryModUsing>> _getTestModules(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    List<StoryModUsing> posts = [];

    var random = new Random();
    var faker = new Faker();
    for (int i = 0; i < 10; i++) {
      StoryModUsing mod = new StoryModUsing([], faker.company.name(), 0, 0, 0, 0, 0);
      mod.author = new Faker().person.name();
      mod.likes = random.nextInt(100);
      mod.thumbnailImg = COCBmobServerFile();
      mod.thumbnailImg.serverfile = BmobFile();
      mod.thumbnailImg.serverfile.url =
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1381105898,90479310&fm=26&gp=0.jpg";
      mod.descript = "This is a good module";
      mod.tags = ["OULALA", "LALALA"];
      mod.people_max = random.nextInt(999);
      mod.people_min = random.nextInt(999);
      mod.hours_min = random.nextInt(999);
      mod.hours_max = random.nextInt(999);
      mod.region = ModRegion.values[random.nextInt(ModRegion.values.length-1)];
      mod.era = ModEra.values[random.nextInt(ModEra.values.length-1)];
      mod.updatedAt = DateTime.utc(2020,random.nextInt(12),random.nextInt(28),random.nextInt(12),random.nextInt(58)).toString();
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
          listPadding: EdgeInsets.only(left: 10,right: 10,top: 5),
//          onSearch: widget._searchRepository.searchByName,
          onSearch: _getTestModules,
          searchBarController: _searchBarController,
          placeHolder: buildPlaceHolder(),
          cancellationWidget: Text("Cancel"),
          emptyWidget: buildEmptyWidget(),
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

  Text buildEmptyWidget() => Text("empty");

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
                      child: Text(
                        "COC 7th",
                        textAlign: TextAlign.center,
                      ),
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
                      child: Text(
                        "COC 6th",
                        textAlign: TextAlign.center,
                      ),
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
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.NINETEENTH] =
                              !widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.NINETEENTH];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .eraFilter[ModEra.NINETEENTH],
                      child: Text(
                        "1920s",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.MODERN] =
                              !widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.MODERN];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .eraFilter[ModEra.MODERN],
                      child: Text(
                        "现代",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.PPRESENT] =
                              !widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.PPRESENT];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .eraFilter[ModEra.PPRESENT],
                      child: Text(
                        "当代",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.OTHERS] =
                              !widget._searchRepository.searchFilter
                                  .eraFilter[ModEra.OTHERS];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .eraFilter[ModEra.OTHERS],
                      child: Text(
                        "其他",
                        textAlign: TextAlign.center,
                      ),
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
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.Europe] =
                              !widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.Europe];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .regionFilter[ModRegion.Europe],
                      child: Text(
                        "欧洲",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.America] =
                              !widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.America];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .regionFilter[ModRegion.America],
                      child: Text(
                        "美洲",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.China] =
                              !widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.China];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .regionFilter[ModRegion.China],
                      child: Text(
                        "中国",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.Japan] =
                              !widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.Japan];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .regionFilter[ModRegion.Japan],
                      child: Text(
                        "日本",
                        textAlign: TextAlign.center,
                      ),
                      borderSize: 0,
                      unselectedBackgroundColor: Colors.white70,
                      selectedBackgroundColor: Colors.blue,
                    ),
                    SelectableContainer(
                      iconAlignment: Alignment.bottomRight,
                      onPressed: () {
                        setState(() {
                          widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.others] =
                              !widget._searchRepository.searchFilter
                                  .regionFilter[ModRegion.others];
                        });
                      },
                      padding: 0,
                      borderRadius: 5,
                      iconSize: 5,
                      height: 30,
                      selected: widget._searchRepository.searchFilter
                          .regionFilter[ModRegion.others],
                      child: Text(
                        "其他",
                        textAlign: TextAlign.center,
                      ),
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
                        controller: _peopleMin,
                        decoration: InputDecoration(hintText: "Min"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                        controller: _peopleMax,
                        decoration: InputDecoration(hintText: "Max"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                        controller: _hoursMin,
                        decoration: InputDecoration(hintText: "Min"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                        controller: _hoursMax,
                        decoration: InputDecoration(hintText: "Max"),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Reset",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      setState(() {
                        widget._searchRepository.searchFilter.resetAll();
                        _hoursMin.text = widget
                            ._searchRepository.searchFilter.hoursMin
                            .toString();
                        _hoursMax.text = widget
                            ._searchRepository.searchFilter.hoursMax
                            .toString();
                        _peopleMin.text = widget
                            ._searchRepository.searchFilter.peopleMin
                            .toString();
                        _peopleMax.text = widget
                            ._searchRepository.searchFilter.peopleMax
                            .toString();
                        _searchBarController.removeFilter();
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      "确定",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      widget._searchRepository.searchFilter.hoursMin =
                          int.parse(_hoursMin.text);
                      widget._searchRepository.searchFilter.hoursMax =
                          int.parse(_hoursMax.text);
                      widget._searchRepository.searchFilter.peopleMin =
                          int.parse(_peopleMin.text);
                      widget._searchRepository.searchFilter.peopleMax =
                          int.parse(_peopleMax.text);
                      _searchBarController.filterList(
                          widget._searchRepository.searchFilter.filterFunc);
                    },
                  )
                ],
              )
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
    _searchBarController.replayLastSearch();
    print("Cancelled triggered");
  }

  Widget buildSearchHeader(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(5),boxShadow: [BoxShadow( color: Colors.black54,
            offset: Offset(1.5,1.5),            blurRadius: 0.5)]),        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildSortBtn(),
            VerticalDivider(thickness: 1,width:1,color: Colors.grey,indent: 5,endIndent: 5,),
            FlatButton(
              child: Text("Reset Sort"),
              onPressed: () {
                _searchBarController.removeSort();
              },
            ),
          ],
        ),
      )
      ;
  }

  String _value = 'Recent';
  Widget buildSortBtn() {
    final List<String> items = ['Most Likes', 'Least Likes', 'Recent', 'Old'];
    final Map<String, int Function(StoryModUsing, StoryModUsing)> itemsfuncs = {
      'Most Likes': widget._searchRepository.sortByLikesMost2Least,
      'Least Likes': widget._searchRepository.sortByLikesLeast2Most,
      'Recent': widget._searchRepository.sortByTimeNew2Old,
      'Old': widget._searchRepository.sortByTimeOld2New,
    };
    return  DropdownButton<String>(
          value: _value,
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
                  child: Text(item, textAlign: TextAlign.center));
            }).toList();
          },
      underline: Container(),
          hint: Text("Sort", textAlign: TextAlign.center),
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            _searchBarController.sortList(itemsfuncs[value]);
          },
        );
  }

  Text buildPlaceHolder() => Text("placeholder");
}
