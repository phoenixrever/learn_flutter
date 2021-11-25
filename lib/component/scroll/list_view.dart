import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/scroll/refresh_list.dart';
import 'package:learn_flutter/network/http_request.dart';

import 'dismissible_demo.dart';
import 'github_demo.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
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
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  label: Text("separated")),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("listview")),
              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("下拉刷新")),              NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: Text("dismissible")),
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
              Scrollbar(
                child: ListView.separated(
                  itemCount: 100,
                  //缓冲区的范围 默认好像1/3屏幕
                  cacheExtent: 2000,

                  separatorBuilder: (context, index) {
                    return index % 2 == 0
                        ? Divider(
                            height: 2,
                            thickness: 1,
                          )
                        : Divider(
                            height: 2,
                            thickness: 1,
                            color: Colors.pinkAccent,
                          );
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      // color: Colors.blue[(index % 5)*100],
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('$index'),
                    );
                  },
                ),
              ),
              users.length > 0
                  ? ListView.builder(
                      itemCount: users.length,
                      //缓冲区的范围 默认好像1/3屏幕
                      // cacheExtent: 2000,
                      //强制设置每个item的高度
                      itemExtent: 60,
                      //滚动过量的效果 回弹
                      physics: BouncingScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index]["avatar_url"]),
                          ),
                          title: Text(users[index]["login"]),
                          trailing: Icon(Icons.arrow_forward_ios),
                        );
                      },
                    )
                  : Center(child: Text("no data")),
              RefreshDemo(),
              DismissibleDemo(),
            ],
          ))
        ],
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            heroTag: "first",
            onPressed: () {
              // _scrollController.jumpTo(0.0);
              _scrollController.animateTo(-20,
                  duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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
