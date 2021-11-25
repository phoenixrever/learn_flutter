
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/Component/icon_badge.dart';
import 'package:learn_flutter/Component/page_view.dart';
import 'package:learn_flutter/Component/page_view_builder.dart';
import 'package:learn_flutter/component/route_button.dart';

import 'bottom_bar.dart';
import 'custom_icon.dart';
import 'drawer_demo.dart';
import 'layout/Layout_route.dart';
import 'other.dart';
import 'scroll/scroll_route_demo.dart';

class TabBarDemo extends StatefulWidget {
  const TabBarDemo({
    Key? key,
  }) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _currentIndex = 0;
  bool isShowAppbarBottom=true;
  _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("hello there"),
          backgroundColor: Colors.transparent,
          flexibleSpace: Image.network(
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181208%2F2e4676df0317489499aaf64bfd701ddf.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629169957&t=7398e9c9256df0f3e5355bed3a2fc163",
            fit: BoxFit.fitWidth,
          ),

          ///draw 会自动添加按钮
          // leading: IconButton(
          //   tooltip: "back",
          //   icon: Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          actions: [
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
          bottom: isShowAppbarBottom?TabBar(
            unselectedLabelColor: Colors.grey,

            ///tabbar 下方横线 label为文字宽度 tab为所占空间宽度
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.greenAccent,

            tabs: [
              Tab(
                icon: Icon(Icons.adb),
                child: Text("Constrained"),
              ),
              Tab(
                icon: Icon(Icons.padding),
                child: Text("customicon"),
              ),
              Tab(
                icon: Icon(Icons.favorite),
                child: Text("pageview"),
              ),
              Tab(
                icon: Icon(Icons.settings),
                child: Text("tab4"),
              ),
            ],
          ):null,
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Tab1View(),
            ScrollRouteDemo(),
            RouteButton(),
            LayoutRoute(),
            OtherDemo(),
          ],
        ),
        drawer: Container(
          width: 250,
          child: DrawerDemo(),
        ),
        bottomNavigationBar: BottomBar(
            changeIndex: (_currentIndex) => _changeIndex(_currentIndex),
            currentIndex: _currentIndex),
      ),
    );
  }
}




class Tab1View extends StatelessWidget {
  const Tab1View({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    // color: Color.fromRGBO(3, 54, 255, 1.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171003%2F20207c56c1844659997b1c71a9e2cefe.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629267871&t=e89b279833cf15a8540c5e0363015f2a"),
                        fit: BoxFit.cover)),

                ///  static const Alignment centerRight = Alignment(1.0, 0.0);
                alignment: Alignment(-0.85, -0.85),
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [
                          Color.fromRGBO(227, 240, 243, 0.3607843137254902),
                          Color.fromRGBO(214, 236, 240, 1.0),
                        ]),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(214, 236, 240, 0.3),
                            offset: Offset(6, 6),
                            blurRadius: 5,
                          ),
                          BoxShadow(
                              color: Color.fromRGBO(214, 236, 240, 0.3),
                              offset: Offset(-6, 6),
                              blurRadius: 5),
                          BoxShadow(
                              color: Color.fromRGBO(214, 236, 240, 0.3),
                              offset: Offset(6, -6),
                              blurRadius: 5),
                          BoxShadow(
                              color: Color.fromRGBO(214, 236, 240, 0.3),
                              offset: Offset(-6, 6),
                              blurRadius: 5)
                        ]),
                    child: Icon(
                      Icons.brightness_3,
                      color: Color.fromRGBO(214, 236, 240, 1.0),
                      size: 35,
                    ))),
            Positioned(
                top: 20,
                right: 20,
                child: Icon(
                  Icons.ac_unit,
                  color: Color.fromRGBO(214, 236, 240, 1.0),
                )),
          ],
        ),
        CustomIcon(),
        PageViewDemo(),
        PageViewBuilderDemo(),
      ],
    );
  }
}
