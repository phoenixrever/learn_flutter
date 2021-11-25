import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/network/http_request.dart';

class GridViewDemo extends StatefulWidget {
  const GridViewDemo({Key? key}) : super(key: key);

  @override
  _GridViewDemoState createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {
  int _selectedIndex = 0;
  List<dynamic> users = [];
  ScrollController _scrollController = ScrollController();

  getData() async {
    var result =
    await HttpRequest.request("https://api.github.com/search/users?q=s");
    users = result.data["items"];
    // return users;
    print(users);
    // return json.encode(result.data["items"]);
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              _scrollController.jumpTo(0.0);
            },
            child: Text("ListView")),
        centerTitle: true,
      ),
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            labelType: NavigationRailLabelType.all,
            selectedIndex: _selectedIndex,
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.wifi_off),
                  selectedIcon: Icon(Icons.wifi),
                  label: Text("gridview")),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("WheelScroll")),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("RotatedBox")),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("Reorderable")),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            width: 2,
          ),
          Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: 50,
                    physics: BouncingScrollPhysics(),

                    ///ipad不太友好
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //   mainAxisSpacing: 10,
                    //   crossAxisSpacing: 10,
                    //   ///长宽比例
                    //   childAspectRatio:1
                    // ),
                    //ipad不太友好
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      //最大尺寸with
                      maxCrossAxisExtent: 100,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Card(
                          child: Text("屏幕尺寸:$mediaSize"),
                        );
                      }
                      return Container(
                        alignment: Alignment.center,
                        color: Color.fromRGBO(Random().nextInt(256),
                            Random().nextInt(256), Random().nextInt(256), 1),
                        child: Text(
                          "$index",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                  ListWheelScrollView(
                      itemExtent: 100,
                      offAxisFraction: 0,
                      diameterRatio: 2.0,

                      //放大中间元素 配合Opacity 或是 useMagnifier使用
                      magnification: 1,
                      overAndUnderCenterOpacity: 0.5,
                      // useMagnifier: true,

                      //精确匹配元素位置
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (value) {
                        print(value);
                      },
                      children: List.generate(
                          10,
                              (index) =>
                              Container(
                                alignment: Alignment.center,
                                color: Color.fromRGBO(
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    Random().nextInt(256),
                                    1),
                                child: Text(
                                  "$index",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))),
                  //旋转组件
                  RotatedBox(
                    quarterTurns: 1,
                    child: ListWheelScrollView(
                        itemExtent: 100,
                        offAxisFraction: 0,
                        diameterRatio: 2.0,

                        //放大中间元素 配合Opacity 或是 useMagnifier使用
                        magnification: 1,
                        overAndUnderCenterOpacity: 0.8,
                        // useMagnifier: true,

                        //精确匹配元素位置
                        physics: FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (value) {
                          print(value);
                        },
                        children: List.generate(
                            10,
                                (index) =>
                                RotatedBox(
                                  quarterTurns: -1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Color.fromRGBO(
                                        Random().nextInt(256),
                                        Random().nextInt(256),
                                        Random().nextInt(256),
                                        1),
                                    child: Text(
                                      "$index",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ))
                    ),
                  ),
                  ReorderableListView(
                    header: Text("不可拖动"),
                    children:List.generate(
                      10,
                          (index) => Container(
                             key: UniqueKey(),
                            height: 100,
                            alignment: Alignment.center,
                            color: Color.fromRGBO(
                                Random().nextInt(256),
                                Random().nextInt(256),
                                Random().nextInt(256),
                                1),
                            child: Text(
                              "$index",
                              style: TextStyle(color: Colors.white,fontSize: 30),
                            ),
                          )), onReorder: (oldIndex, newIndex) {

                      },)
                ],
              ))
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          Card(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("屏幕尺寸:$mediaSize")),
          ),
          FloatingActionButton(
            heroTag: "first",
            onPressed: () {
              // _scrollController.jumpTo(0.0);
              _scrollController.animateTo(-20,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
            child: Icon(Icons.arrow_upward),
          ),
          FloatingActionButton(
            heroTag: "second",
            onPressed: () {
              print(_scrollController.offset);
              _scrollController.animateTo(1130,
                  duration: Duration(milliseconds: 1000), curve: Curves.linear);
            },
            child: Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }
}
