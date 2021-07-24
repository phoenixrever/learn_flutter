import 'package:flutter/material.dart';

class PageViewDemo extends StatelessWidget {
  const PageViewDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(
          initialPage: 0,
          ///记录当前页面默认true
          keepPage: true,
          ///默认页面占满整个视图
          viewportFraction: 1.0
      ),
      ///拖动超过一半过去,不超过一半返回
      pageSnapping: true,
      ///反向翻页
      reverse: false,
      scrollDirection:Axis.vertical ,
      onPageChanged: (currentPage)=>debugPrint("$currentPage"),
      children: [
        Container(
          color: Colors.brown[900],
          alignment: Alignment.center,
          child: Text("page view one ",style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.w600),),
        ),
        Container(
          color: Colors.grey[900],
          alignment: Alignment.center,
          child: Text("page view two",style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.w600),),
        ),
        Container(
          color: Colors.blueGrey[900],
          alignment: Alignment.center,
          child: Text("page view three",style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.w600),),
        ),
      ],
    );
  }
}