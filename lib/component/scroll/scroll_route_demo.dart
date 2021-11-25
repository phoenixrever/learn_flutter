import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learn_flutter/component/route_button.dart';

class ScrollRouteDemo extends StatefulWidget {
  const ScrollRouteDemo({
    Key? key,
  }) : super(key: key);

  @override
  _ScrollRouteDemoState createState() => _ScrollRouteDemoState();
}

class _ScrollRouteDemoState extends State<ScrollRouteDemo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "list view",
          to: "list-view",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "SingleChildScrollView",
          to: "SingleChildScrollView",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "github",
          to: "github",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "gridview",
          to: "gridview",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "list navigation",
          to: "list-navigation",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(226, 174, 194, 0.611764705882353),
          end: Color.fromRGBO(243, 10, 116, 1.0),
          borderColor:
          Color.fromRGBO(199, 66, 117, 0.611764705882353),
          name: "sliver",
          to: "sliver",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "sliver fill remaining",
          to: "sliver-fill-remaining",
        ),
        SizedBox(height: 20,),
        ComponentRoute(
          begin: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 0.3568627450980392),
          end: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1.0),
          borderColor: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),Random().nextInt(256), 1.0),
          name: "sliver app",
          to: "sliver-app",
        ),
      ],
    );
  }
}

class GirdViewDemo extends StatelessWidget {
  const GirdViewDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        padding: EdgeInsets.all(10),

        ///SliverGridDelegateWithMaxCrossAxisExtent 设置宽度计算每行元素个数
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            child: Center(
                child: Text(
              "GridView Builder $index",
              style: TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F11674695337%2F0.jpg&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1629250571&t=e5d75b1ae092d6a77e4db6a651c2e5b0"),
                    fit: BoxFit.cover)),
          );
        });
  }
}

